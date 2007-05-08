<?php
/*
 * Created on 30/11/2006
 *
 * by: nano (thenano@gmail.com)
 * 
 * 
 */

require_once ('PersistentObjectFactory.php');

class PersistentObjectController {
	
	var $controlledClass;
	
	function PersistentObjectController($class) {
		require_once($class . ".php");
		if (!class_exists($class)) trigger_error("Incorrect parameter, must provide a valid subclass of PersistentObject.", E_USER_ERROR);
		for ($super = get_parent_class($class); $super; $super = get_parent_class($super)) {
			if ($super == 'persistentobject') {
				$pass = true;
				break;
			}	
		}
		if (!$pass) trigger_error("Incorrect parameter, must provide a valid subclass of PersistentObject.", E_USER_ERROR);
		$this->controlledClass = strtolower($class);
	}
	
	function query($query, $bindvals = array(), $offset = 0, $maxRecords = -1, $sortMode = false) {
		global $dbConnection;
		if ($sortMode) {
			$query .= " order by " . preg_replace("/\_/", " ", $sortMode);
		}
		if ($maxRecords > 0) {
			$query .= " limit $offset,$maxRecords";
		}
	    return $dbConnection->query($query, $bindvals);
	}
	
	function getOne($query, $bindvals = array()) {
		global $dbConnection;
	    return $dbConnection->getOne($query, $bindvals);
	}
	
	function _prepQueryConditions($fields) {
		if (count($fields)) {
			$bindvals = array();
			$query = "where ";
			foreach ($fields as $key => $value) {
				if (is_array($key)) {
					$query .= "(";
					foreach ($key as $f) {
						$query .= "$f like ? or ";
						$bindvals[] = "%" . $value . "%";
					}
					$query = substr($query, 0, strlen($query)-4);
					$query .= ") and ";
				} else {
					if (is_array($value)) {
						$query .= "$key in (";
						foreach ($value as $param) {
							$query .= "?,";
							$bindvals[] = $param;
						}
						$query = substr($query, 0, strlen($query)-1);
						$query .= ") and ";
					} else {
						$query .= "$key = ? and ";
						$bindvals[] = $value;
					}
				}
			}
			$query = substr($query, 0, strlen($query)-5);
			return array($query, $bindvals);
		}
	}
	
	function findAll($filters = array(), $offset = 0, $maxRecords = -1, $sortMode = false) {
		$queryParams = $this->_prepQueryConditions($filters);
		$result = $this->query("select id from $this->controlledClass " . $queryParams[0], $queryParams[1], $offset, $maxRecords, $sortMode);
		$objs = array();
		while ($row = $result->fetchRow()) {
			$objs[] = PersistentObjectFactory::createObject($this->controlledClass, (int)$row['id']);
		}
		return $objs;
	}
	
	function countAll($filters = array()) {
		$queryParams = $this->_prepQueryConditions($filters);
		return $this->getOne("select count(id) from $this->controlledClass " . $queryParams[0], $queryParams[1]);
	}
	
	function noStructureFindAll($filters = array(), $offset = 0, $maxRecords = -1, $sortMode = false) {
		$queryParams = $this->_prepQueryConditions($filters);
		$result = $this->query("select * from $this->controlledClass " . $queryParams[0], $queryParams[1], $offset, $maxRecords, $sortMode);
		$objs = array();
		while ($row = $result->fetchRow()) {
			$objs[] = $row;
		}
		return $objs;
	}
	
}

?>
