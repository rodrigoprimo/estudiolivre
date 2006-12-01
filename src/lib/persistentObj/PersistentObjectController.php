<?php
/*
 * Created on 30/11/2006
 *
 * by: nano (thenano@gmail.com)
 * 
 * This is an abstract class (shouldn't be instanciated)
 * to control persistentObjects.
 * The pattern is to create subclass called MyClassController,
 * to do operations in the persistentObject subclass MyClass.
 * 
 */

require_once ('lib/tikidblib.php');

class PersistentObjectController extends TikiDB {
	
	var $controlledClass;
	
	function PersistentObjectController($class) {
		if (!class_exists($class)) trigger_error("Incorrect parameter, must provide a valid subclass of PersistentObject.", E_USER_ERROR);
		for ($super = get_parent_class($class); $super; $super = get_parent_class($super)) {
			if ($super == 'persistentobject') {
				$pass = true;
				break;
			}	
		}
		if (!$pass) trigger_error("Incorrect parameter, must provide a valid subclass of PersistentObject.");
		global $dbTiki;
	    $this->db = $dbTiki;
		$this->controlledClass = strtolower($class);
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
	
	function findAll($filters = array()) {
		$class = $this->controlledClass;
		$result = $this->query("select id from $class " . $this->_prepQueryConditions($filters), $filters);
		$objs = array();
		while ($row = $result->fetchRow()) {
			$objs[] = new $class((int)$row['id']);
		}
		return $objs;
	}
	
}

?>
