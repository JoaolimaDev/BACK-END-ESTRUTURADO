<?php 
namespace view;

use model\Handle;

require_once("api/model/Db_handle.php");

use \PDO;


class Chave
{

    public static function auth_key() : void
    {

        $data = json_decode(file_get_contents("php://input"));

        $chave = htmlspecialchars(strip_tags($data->chave));


        $sql = "SELECT dbase FROM `cliente` WHERE chave = :chave";

       
        $conn = Handle::Db_handle("jcasolutions_gip2021Admin");

        $stmt = $conn->prepare($sql);

        $stmt->bindValue(':chave', $chave, PDO::PARAM_STR);

        $stmt->execute();

        if ($stmt->rowCount() > 0) {
            
            $dados = $stmt->fetch(PDO::FETCH_ASSOC);

            http_response_code(200);
            echo json_encode([
                'Sucesso'=> 1,
                'Sados'=>$dados
            ]);
            exit;

        }else{

            http_response_code(200);
            echo json_encode([
                'Sucesso'=> 0,
                'Sados'=>'Chave inválida!'
            ]);
            exit;

        }

        
    }
    
   
}


?>