<?php 
namespace view;

require_once("api/model/DAO.php");
use model\Sql;

class Perm
{
    
    public function All_Perm()
    {
        
    }

    public static function User_Perm(string $user, string $db, string $perms)
    {

        $query = Sql::select("SELECT id_usuario FROM `user` WHERE user = :user", $db, array(':user' =>
        $user));

        $dados = $query[0];

        Sql::query("INSERT INTO `permissions` (perms, user_id_usuario) VALUES(:perms, :user_id)", $db, 
        array(':perms' => $perms, ':user_id' => $dados['id_usuario']));
    
    }


    public static function Select_User_Perm (string $id_user, string $db)
    {
        
    }

    public static function Delete_User_Perm(string $id_user, string $db)
    {
        
    }


    public static function User_Perm_update(string $id_user, string $db, string $perms)
    {
        
    }
}


?>