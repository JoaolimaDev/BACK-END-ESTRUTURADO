<?php 
namespace controller;

require_once("api/model/Db_handle.php");

use model\Handle;
use PDO;


class Auth
{

    public static function Auth_Token($token, $db) : bool
    {

        if (!preg_match('/Bearer/', $token) || empty($db))
        {
            http_response_code(403);
            echo json_encode([
                'Sucesso'=>0,
                'Mensagem'=>'Erro desconhecido! Por favor contate o administrador!'
            ]);
            exit;
        }

        $tk = htmlspecialchars(strip_tags($token));
        $part = explode(".",$tk);
        $data = json_decode(
            base64_decode($part[1])
        );

        
        if ($data->exp < date("Y-m-d")) {
            http_response_code(403);
            echo json_encode([
                'Sucesso'=>0,
                'Mensagem'=>'Sessão expirada! Por favor realize o login novamente..'
            ]);
            exit;
        }


        $sql = "SELECT id_log FROM `user` WHERE user = :user";

        $conn = Handle::Db_handle($db);

        $stmt = $conn->prepare($sql);

        $stmt->bindValue(":user", $data->user, PDO::PARAM_STR);

        $stmt->execute();


        if ($stmt->rowCount() > 0) {
            
            $dados = $stmt->fetch(PDO::FETCH_ASSOC);

            $valid = $dados['id_log'];
                
            $tokenVal = trim($token, 'Bearer');


            if ($valid == trim($tokenVal)) {
                   
              return true;

            }else{
                http_response_code(403);
                echo json_encode([
                    'Sucesso'=>0,
                    'Mensagem'=>'Sessão expirada! Por favor realize o login novamente...'
                ]);
                exit;
            }
          
        }else{

            http_response_code(403);
            echo json_encode([
                'Sucesso' => 0,
               'Mensagem' => 'Erro desconhecido! Por favor contate o administrador!'
            ]);
            exit;
        }
        
        
    }
}


?> 