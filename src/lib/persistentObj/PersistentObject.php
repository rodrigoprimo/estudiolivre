<?php
/*
 * Created on 28/11/2006
 *
 * by: nano (thenano@gmail.com)
 * 
 * this is an abstract class (shouldn't be instanciated)
 * for class->database persistence.
 * all the subclasses should have a table with the same name as the class,
 * and all the properties for the table rows
 * 
 */

require_once ('lib/tikidblib.php');

class PersistentObject extends TikiDB {
	
	var $table;
	var $id;
	
	function PersistentObject($fields) {
		global $dbTiki;
	    $this->db = $dbTiki;
	    $this->table = get_class($this);
	    if (is_array($fields)) {
	    	if (count($fields)) {
		    	$this->_populateObject($fields);
		    	$this->id = $this->insert($fields);
	    	} else trigger_error("Incorrect parameters, need array with at least one field to create object", E_USER_ERROR);
	    } elseif (is_int($fields)) {
	    	$this->id = $fields;
	    	$this->select();
	    } else trigger_error("Incorrect parameters, need array or integer of 'id' to fetch", E_USER_ERROR);
	    return $this;
	}
	
	function _populateObject($fields) {
		foreach ($fields as $key => $value) {
			$this->_checkField($key, $value);
			$this->$key = $value;
		}
		return $this;
	}
	
	// this does not check anything, an actual method 
	// per field must be implemented in subclasses
	// the check methods should trigger errors
	function _checkField($name, $value) {
		$methodName = "checkField_" . $name;
	  	if (method_exists($this, $methodName)) {
	  		$this->$methodName($value);
	  	}
	}
	
	function __array_diff_key($a1, $a2) {
		$diff = array();
		foreach ($a1 as $key => $value) {
			if (!array_key_exists($key, $a2)) {
				$diff[$key] = $value;
			}
		}
		return $diff;
	}

	function __array_intersect_key($a1, $a2) {
		$diff = array();
		foreach ($a1 as $key => $value) {
			if (array_key_exists($key, $a2)) {
				$diff[$key] = $value;
			}
		}
		return $diff;
	}

	
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
		$super = get_parent_class($table);
		$parentProperties = get_class_vars($super);
		$parentFields = $this->__array_intersect_key($fields, $parentProperties);
		$localFields = $this->__array_diff_key($fields, $parentProperties);
		if ($super != 'persistentobject') {
			$id = $this->insert($parentFields, $super);
			$localFields['id'] = $id;
			$this->query($this->_prepInsertQuery($localFields, $table), $localFields);
			return $id;  
		} else {
			$this->query($this->_prepInsertQuery($localFields, $table), $localFields);
			return (int)$this->getOne("select max(id) from $table " . $this->_prepQueryConditions($localFields), $localFields);
		}
	}
	
	function update($fields, $table = false) {
		if (!$table) $table = $this->table;
		$super = get_parent_class($table);
		$parentProperties = get_class_vars($super);
		$parentFields = $this->__array_intersect_key($fields, $parentProperties);
		$localFields = $this->__array_diff_key($fields, $parentProperties);
		if (count($parentFields) && $super != 'persistentobject') {
			$this->update($parentFields, $super);
		}
		if (count($localFields)) {
			$this->_updateObject($localFields, $table);
		}
		return $this;
	}
	
	function _updateObject($fields, $table) {
		$query = "update $table set "; 
		$this->_populateObject($fields);
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
		for ($table = get_parent_class($this->table); $table != 'persistentobject'; $table = get_parent_class($table)) {
			$this->query("delete from $table where id = ?", array($this->id));
		}
	}
	
	function select() {
		$tables = "$this->table";
		$conditions = "where "; 
		for ($table = get_parent_class($this->table); $table != 'persistentobject'; $table = get_parent_class($table)) {
			$tables .= ",$table";
			$conditions .= "$this->table.id = $table.id and ";
		}
		$conditions .= "$this->table.id = ?";
		$result = $this->query("select * from $tables $conditions", array($this->id));
		if ($row = $result->fetchRow()) $this->_populateObject($row);
		else trigger_error("Incorrect parameters, id doesn't exist", E_USER_ERROR);
	}
	
}

?>
