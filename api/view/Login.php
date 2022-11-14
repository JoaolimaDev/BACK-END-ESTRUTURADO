<?php 
namespace view;

require_once("api/model/DAO.php");
require_once("api/controller/Ctrl.php");

use model\Sql;
use controller\Ctrl;


class Login
{

    public function __construct(string $opt, string $db)
    {

        switch ($opt) {

            case 'login':

             return $this->Login($db);
               
            break;

            case 'logout':

                return $this->Logout($db);
                  
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
        
        $array_params = array(':user' => $user);

        $dados = Sql::select("SELECT id_usuario, password FROM `user` WHERE user = :user", $db, $array_params);

        
        if (count($dados) > 0){

            $resu = $dados[0];


            if(password_verify($senha, $resu['password'])){
        
                
                $log = Ctrl::Token_call($user);

                Sql::query("UPDATE `user` SET id_log = :id_log
                WHERE id_usuario = :id_usuario", $db, array(':id_log' => $log,
                ':id_usuario' => $resu['id_usuario']));

            
                $this->Backlog(date("Y-m-d h:i:sa"), "Logou". $user, $db);
                
                http_response_code(200);  //HTTP 200 OK
                echo json_encode([
                'Sucesso' => 1,
                'Mensagem' => 'Usuário autenticado - '. $user,
                'Session_id' => $log]);
                exit; 
                

            }else{

                http_response_code(400);
                echo json_encode([
                    'Sucesso' => 0,
                   'Mensagem' => 'Usuário ou senha inválidos 1 !'
                ]);
                exit;
            
            }
        

        }else{
            http_response_code(400);
            echo json_encode([
                'Sucesso' => 0,
               'Mensagem' => 'Usuário ou senha inválidos 2!'
            ]);
            exit;
        }

    }

    
    private function Backlog($back_log, $user, $db)
    {

        $array_params = array(':user_log' => $back_log, ':user' => $user);

        Sql::query("INSERT INTO `user_log`(user_log, user) VALUES(:user_log, :user)",
        $db, $array_params);
            
    }

    public function Logout(string $db) : void
    {

        $id_log = trim($_SERVER['HTTP_AUTHORIZATION'], 'Bearer');

        
       $query = Sql::select("SELECT id_usuario, user FROM `user` WHERE id_log = :id_log", $db, array(':id_log' => 
          trim($id_log)));

     
        if(count($query) > 0){

            $dados = $query[0];

            session_regenerate_id();

            $id = password_hash(session_id(), PASSWORD_DEFAULT);
            $log = base64_encode($id.":".date("Y-m-d h:i:sa"));

            Sql::query("UPDATE `user` SET id_log = :id_log
            WHERE id_usuario = :id_usuario", $db, array(':id_log' => $log,
            ':id_usuario' => $dados['id_usuario']));
            
            session_unset();
            session_destroy();

            
            $this->Backlog(date("Y-m-d h:i:sa"), "Logout ".$dados['user'], $db);

            http_response_code(200);
            echo json_encode([
                'sucesso' => 1,
                'mensagem' => 'Sessão encerrada!',
                'Session_status'=> session_status()
            ]);
            exit;


        }else{
            http_response_code(400);
            echo json_encode([
                'sucesso' => 0,
                'mensagem' => 'Não foi possível executar a operação.'
            ]);
            exit;
        }

    }
    
}
?>