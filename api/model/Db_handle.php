<?php 
namespace model;

require_once("Database.php");

class Handle 
{

public static function Db_handle($db_name)
{
    $database = new Database;


    if (!preg_match('/jcasolutions_gip2021Admin/', $db_name)) {
        
        return $database->connect01($db_name);
        
    }else{


        return $database->connect();

    }

 

  
  
}
    
}





?>