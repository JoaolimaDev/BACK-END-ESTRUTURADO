<?php 
namespace view;

require_once("api/model/DAO.php");

use model\Sql;


class Chave
{

    public static function auth_key() : void
    {

        $data = json_decode(file_get_contents("php://input"));

        $chave = htmlspecialchars(strip_tags($data->chave));

        if (empty(trim($chave))) {
            http_response_code(400);
            echo json_encode([
                'Sucesso'=> 0,
                'Dados'=>'Por favor adione uma chave!'
            ]);
            exit;
        }

 
        $array_param = array(':chave' => $chave);

  
        $dados = Sql::select("SELECT dbase FROM `cliente` WHERE chave = :chave", "jcasolutions_gip2021Admin", $array_param);

        
        if (count($dados) > 0) {

            http_response_code(200);
            echo json_encode([
                'Sucesso'=> 1,
                'Dados'=>$dados
            ]);
            exit;

        }else{

            http_response_code(403);
            echo json_encode([
                'Sucesso'=> 0,
                'Mensagem'=>'Chave inválida!'
            ]);
            exit;

        }

        
    }
    
   
}

?>