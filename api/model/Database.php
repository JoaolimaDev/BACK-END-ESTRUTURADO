<?php

namespace model;
use \PDO;
use PDOException;

class Database {
  // DB Params
 
  private $host = 
  private $db_name = 
  private $username = 
  private $password = 
  private $conn;

  // DB Connect


  public function connect() {
    $this->conn = null;

    try {
      
      $this->conn = new PDO('mysql:host=' . $this->host . ';dbname=' . $this->db_name,
      $this->username, $this->password);
      $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    } catch(PDOException $e) {
      echo 'Connection Error: ' . $e->getMessage();
    }

    return $this->conn;
  }


  public function connect01(string $db_name) {
    $this->conn = null;

    try {
      
      $this->conn = new PDO('mysql:host=' . $this->host . ';dbname=' .$db_name,
      $this->username, $this->password);
      $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    } catch(PDOException $e) {
      echo 'Connection Error: ' . $e->getMessage();
    }

    return $this->conn;
  }



  
}




?>
