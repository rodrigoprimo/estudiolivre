<?php 
/*
 * Created on 28/11/2006
 *
 * by: nano (thenano@gmail.com)
 * 
 * this is an abstract class (shouldn't be instanciated)
 * for class->database persistence.
 * all the subclasses should have a table with the same name as the class,
 * and all the properties for the table rows, except id, wich belongs to 
 * this class. errors are triggered as E_USER_ERROR and should be caught 
 * by the implementing system
 * 
 */

require_once ('PersistentObjectFactory.php');

/* this is an option to add extraStructure beyond your class hierarchy
 * to ise this, you must create the file bellow in your application
 * in this file you add methods to this class with the name pattern
 * actionExtra, i.e. insertTag. action must be insert, update, delete or select 
 */
@include_once ('PersistentObjectExtra.php');

class PersistentObject {
	
	var $table;
	var $id;
	var $hasMany = array();
	var $belongsTo = array();
	var $hasManyAndBelongsTo = array();
	var $extraStructure = array();
	
	/* This is the base constructor for the framework. it relies on the 
	 * basis that if you send an id, you want to retrieve, and if you send 
	 * fields, you want to insert a new entry. modification is done by retrieving
	 * and then modifying.
	 * The second parameter serves the purpose of stopping infinite loops when selecting
	 * objects with 1 <-> N or N <-> N (not yet implemented) relations
	 */
	function PersistentObject($fields, $referenced = false) {
	    $this->table = strtolower(get_class($this));
	    if (is_array($fields)) {
	    	if (count($fields)) {
	    		if (isset($this->actualClass))
			    	$fields['actualClass'] = $this->table;
		    	$this->_populateObject($fields);
		    	$this->id = $this->insert($fields);
		    	$this->_extraStructure('insert');
	    	} else trigger_error("Incorrect parameters, need array with at least one field to create object", E_USER_ERROR);
	    } elseif (is_int($fields)) {
	    	$this->id = $fields;
	    	$this->select($referenced);
	    } else trigger_error("Incorrect parameters, need array or integer of 'id' to fetch", E_USER_ERROR);
	    return $this;
	}
	
	function _populateObject($fields) {
		$errors = "";
		foreach ($fields as $key => $value) {
			$errors .= $this->_checkField($key, $value);
			$this->$key = $value;
		}
		return $errors;
	}
	
	function query($query, $bindvals = array()) {
		global $dbConnection;
	    return $dbConnection->query($query, $bindvals);
	}
	
	function getOne($query, $bindvals = array()) {
		global $dbConnection;
	    return $dbConnection->getOne($query, $bindvals);
	}
	
	// this does not check anything, an actual method 
	// per field must be implemented in subclasses
	// the check methods should trigger E_USER_ERROR
	function _checkField($name, $value) {
		$methodName = "checkField_" . $name;
	  	if (method_exists($this, $methodName)) {
	  		return $this->$methodName($value);
	  	}
	}
	
	// PHP4 hack
	function __array_diff_key($a1, $a2) {
		$diff = array();
		foreach ($a1 as $key => $value) {
			if (!array_key_exists($key, $a2)) {
				$diff[$key] = $value;
			}
		}
		return $diff;
	}

	// PHP4 hack
	function __array_intersect_key($a1, $a2) {
		$diff = array();
		foreach ($a1 as $key => $value) {
			if (array_key_exists($key, $a2)) {
				$diff[$key] = $value;
			}
		}
		return $diff;
	}

	// builds the insertion values and cuts out the last ","
	function _prepInsertQuery($fields, $table) {
		if (count($fields)) {
			$query = "insert into $table (";
			$queryVals = "values(";
			foreach ($fields as $key => $value) {
				$query .= "$key,";
				$queryVals .= "?,";
			}
			$query = substr($query, 0, strlen($query)-1);
			$queryVals = substr($queryVals, 0, strlen($queryVals)-1);
			$query .= ") ";
			$queryVals .= ")";
			return $query . $queryVals;
		} else {
			return "insert into $table () values()";
		}
	}
	
	function _prepQueryConditions($fields) {
		if (count($fields)) {
			$query = "where ";
			foreach ($fields as $key => $value) {
				$query .= "$key = ? and ";
			}
			$query = substr($query, 0, strlen($query)-5);
			return $query;
		}
	}
	
	function insert($fields, $table = false) {
		if (!$table) $table = $this->table;
		$super = strtolower(get_parent_class($table));

		$parentProperties = get_class_vars($super);
		$parentFields = $this->__array_intersect_key($fields, $parentProperties);
		$localFields = $this->__array_diff_key($fields, $parentProperties);
		$id = false;
		if ($super != 'persistentobject') {
			$id = $this->insert($parentFields, $super);
			$localFields['id'] = $id;
			$this->query($this->_prepInsertQuery($localFields, $table), $localFields);  
		} else {
			$this->query($this->_prepInsertQuery($localFields, $table), $localFields);
			$id = (int)$this->getOne("select max(id) from $table " . $this->_prepQueryConditions($localFields), $localFields);
		}
		return $id;
	}
	
	function update($fields) {
		$errors = $this->_populateObject($fields);
		$this->_doUpdate($fields); 
		$this->_extraStructure('update', $fields);
		if ($errors) return $errors;
		return $fields;
	}
	
	function _doUpdate($fields, $table = false) {
		if (!$table) $table = $this->table;
		$super = strtolower(get_parent_class($table));
		$parentProperties = get_class_vars($super);
		$parentFields = $this->__array_intersect_key($fields, $parentProperties);
		$localFields = $this->__array_diff_key($fields, $parentProperties);
		if (count($parentFields) && $super != 'persistentobject') {
			$this->_doUpdate($parentFields, $super);
		}
		if (count($localFields)) {
			$this->_updateObject($localFields, $table);
		}
	}
	
	function _updateObject($fields, $table) {
		$query = "update $table set ";
		foreach ($fields as $key => $value) {
			$query .= "$key = ?,";
		}
		$query = substr($query, 0, strlen($query)-1);
		$query .= " where id = ?";
		$fields[] = $this->id;
		$this->query($query, $fields);
	}
		
	function delete() {
		$this->query("delete from $this->table where id = ?", array($this->id));
		for ($table = strtolower(get_parent_class($this->table)); $table != 'persistentobject'; $table = strtolower(get_parent_class($table))) {
			$this->query("delete from $table where id = ?", array($this->id));
		}
		$this->_deleteRelations();
		$this->_extraStructure('delete');
	}
	
	// deletes 1 to N and N to N relations
	function _deleteRelations() {
		foreach ($this->hasMany as $child => $me) {
			$varName = strtolower($child) . "s";
			foreach ($this->$varName as $child)
				$child->delete();
		}
		foreach ($this->hasManyAndBelongsTo as $peer => $me) {
			$myName = strtolower($me);
			$peerName = strtolower($peer);
			if ($peerName < $myName) $tableName = $peerName . "_" .  $myName;
			else $tableName = $myName . "_" .  $peerName;
			$this->query("delete from $tableName where ${myName}Id = ?", array($this->id));
		}
	}
	
	function select($referenced = false) {
		$tables = "$this->table";
		$conditions = "where "; 
		for ($table = strtolower(get_parent_class($this)); !preg_match("/.*persistentobject.*/", $table); $table = strtolower(get_parent_class($table))) {
			$tables .= ",$table";
			$conditions .= "$this->table.id = $table.id and ";
		}
		$conditions .= "$this->table.id = ?";
		$result = $this->query("select * from $tables $conditions", array($this->id));
		if ($row = $result->fetchRow()) $this->_populateObject($row);
		else trigger_error("Incorrect parameters, id doesn't exist", E_USER_ERROR);
		if (!$referenced) {
			$this->_getParent();
			$this->_getPeers();
			$this->_getChildren();
		}
		$this->_extraStructure('select');
	}
	
	/* Populates the "1" side of a 1 to N relation
	 * note that the superclass wich corresponds to the "1" side
	 * will not be instanciated, only the subclasses will
	 */
	function _getParent() {
		foreach ($this->belongsTo as $parent) {
			$varName = strtolower($parent);
			$idName = $varName . "Id";
			if ($this->$idName) {
				$this->$varName = PersistentObjectFactory::createObject($parent, (int)$this->$idName, true);
			}
		}
	}
	
	/* Populates the "N" side of a 1 to N relation
	 * note that the superclass wich corresponds to the "N" side
	 * will not be instanciated, only the subclasses will
	 */
	function _getChildren() {
		foreach ($this->hasMany as $child => $parent) {
			require_once($child . ".php");
			$childName = strtolower($child);
			$varName = $childName . "s";
			$idName = strtolower($parent) . "Id";
			
			$result = $this->query("select id from $childName where $idName = ?", array($this->id));
			while ($row = $result->fetchRow()) {
				array_push($this->$varName, PersistentObjectFactory::createObject($child, (int)$row['id'], true));
			}
		}
	}
	
	/* populates "N" to "N" relations
	 */
	function _getPeers() {
		foreach ($this->hasManyAndBelongsTo as $peer => $me) {
			require_once($peer . ".php");
			$myName = strtolower($me);
			$peerName = strtolower($peer);
			$varName = $peerName . "s";
			if ($peerName < $myName) $tableName = $peerName . "_" .  $myName;
			else $tableName = $myName . "_" .  $peerName;
			$result = $this->query("select ${peerName}Id as id from $tableName where ${myName}Id = ?", array($this->id));
			while ($row = $result->fetchRow()) {
				if ($row['actualClass']) $actualClass = $row['actualClass'];
				else $actualClass = $peer;
				array_push($this->$varName, new $actualClass((int)$row['id'], true));
			}
		}
	}

	function _extraStructure($action, $fields = false) {
		foreach($this->extraStructure as $structure) {
			$methodName = $action . $structure;
			if (class_exists("PersistentObjectExtra")) {
				if ($fields) PersistentObjectExtra::$methodName($this, $fields);
				else PersistentObjectExtra::$methodName($this);
			}
		}
	}
	
}

?>
