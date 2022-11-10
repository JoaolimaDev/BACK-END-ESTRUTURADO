<?php
namespace model;
use PDO;

require_once("Db_handle.php");

class Sql{
    
    public static $stmt;

    public static function select(string $Raw_Query, string $db, array $params = array()) : array
    {

        $conn = Handle::Db_handle($db);

        Sql::$stmt = $conn->prepare($Raw_Query);
        
        Sql::Bind($params);

        Sql::$stmt->execute();
    
        return Sql::$stmt->fetchAll(PDO::FETCH_ASSOC);
        
    }

    public function query(string $Raw_Query, string $db, array $params = array())
    {
      
      $conn = Handle::Db_handle($db);

      Sql::$stmt = $conn->prepare($Raw_Query);

      Sql::Bind($params);

      Sql::$stmt->execute();

    }

    public static function Bind($params)
    {

      foreach ($params as $key => $value) {

        return Sql::$stmt->bindValue($key, $value);

      }

    }
 
}
?>