<?php 
namespace view;

require_once("api/controller/Ctrl.php");
require_once("api/model/Db_handle.php");

use controller\Ctrl;
use model\Handle;
use \PDO;


class Login
{

    public function __construct(string $opt, string $db)
    {

        switch ($opt) {

            case 'login':

             return $this->Login($db);
               
            break;
            
            default:
               
                http_response_code(403);
                echo json_encode([
                    'Sucesso' => 0,
                'Mensagem' => 'Operação inválida!'
                ]);
                exit;
                
            break;
        }
        

    }

    public function Login(string $db) : void
    {
        $data = json_decode(file_get_contents("php://input"));

        if (empty(trim($data->user))):
            http_response_code(400);
            echo json_encode(['sucesso' => 0, 'mensagem' => 'Adicione o usuário!']);
            exit;
        endif;

        if (empty(trim($data->senha))):
            http_response_code(400);
            echo json_encode(['sucesso' => 0, 'mensagem' => 'Adicione a senha!']);
            exit;
        endif;

        $user = htmlspecialchars(strip_tags($data->user));
        $senha = htmlspecialchars(strip_tags($data->senha));

        $sql = "SELECT user, password FROM `user` WHERE user = :user";

        $conn = Handle::Db_handle($db);

        $stmt = $conn->prepare($sql);

        
        $stmt->bindValue(':user', $user, PDO::PARAM_STR);
        

        $stmt->execute();

        if ($stmt->rowCount() > 0){

            $dados = $stmt->fetch(PDO::FETCH_ASSOC);

            if(password_verify($senha, $dados['password'])){

                $sql = "UPDATE `user` SET id_log = :id_log
                WHERE user = :user";
        
                $stmt = $conn->prepare($sql);
        
                $stmt->bindValue(':user', $dados['user'], PDO::PARAM_STR);

                $log = Ctrl::Token_call($user);

                $stmt->bindValue(':id_log', $log , PDO::PARAM_STR);

            
                if ($stmt->execute()) {

                    $this->Backlog(date("Y-m-d h:i:sa"), $user, $db);
                    
                    http_response_code(200);  //HTTP 200 OK
                    echo json_encode([
                    'Sucesso' => 1,
                    'Mensagem' => 'Usuário autenticado - '. $dados['user'],
                    'Session_id' => $log]);
                    exit; 
                }

            }else{

                http_response_code(400);
                echo json_encode([
                    'Sucesso' => 0,
                   'Mensagem' => 'Usuário ou senha inválidos!'
                ]);
                exit;
            
            }
        

        }else{
            http_response_code(400);
            echo json_encode([
                'Sucesso' => 0,
               'Mensagem' => 'Usuário ou senha inválidos!'
            ]);
            exit;
        }

    }

    private function Backlog($back_log, $user, $db)
    {
        
        $query = "INSERT INTO `user_log`(user_log, user) VALUES(:user_log, :user)";

        $conn = Handle::Db_handle($db);
        $stmt = $conn->prepare($query);
        //bind dos valores
        $stmt->bindValue(':user_log', $back_log, PDO::PARAM_STR);
        $stmt->bindValue(':user', $user. " logou", PDO::PARAM_STR);

        $stmt->execute();
            
    }
    
}



?>