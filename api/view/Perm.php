<?php 
namespace view;
require_once("api/model/Db_handle.php");


use model\Handle;
use PDO;

class Perm
{
    public static function User_Perm($db)
    {

        $data = json_decode(file_get_contents("php://input"));
        
        $user = 1; 


        $query = "INSERT INTO `permissions` (fk_id_user, perms) VALUES((SELECT id_user FROM user WHERE user = $user), :perm)";

        $conn = Handle::Db_handle($db);
        $stmt = $conn->prepare($query);
        //bind dos valores
        
        $stmt->bindValue(':perm', $data->perm , PDO::PARAM_STR);

        if ($stmt->execute()) {

            echo json_encode([
                'sucesso' => 0,
                'mensagem' => 'Por favor, confirme sua senha.',
            ]);
            exit;
            
        }
            
    }


    public static function User_Perm_update()
    {
        # code...
    }
}


?>