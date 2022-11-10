<?php 
namespace view;

require_once("api/controller/Ctrl.php");
require_once("api/model/Db_handle.php");

use controller\Ctrl;
use model\Handle;
use \PDO;

class User
{

    public function __construct(string $opt, string $db){

            switch ($opt) {

                case 'cadastro':

                    return $this->create($db);

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


    public function create(string $db)
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

        if (!isset($data->rSenha) && empty(trim($data->rSenha))) : // validação da senha

            echo json_encode([
                'sucesso' => 0,
                'mensagem' => 'Por favor, confirme sua senha.',
            ]);
            exit;
        endif;

        $user = htmlspecialchars(strip_tags($data->user));
        $senha = htmlspecialchars(strip_tags($data->senha));
        $rSenha = htmlspecialchars(strip_tags($data->rSenha));

    
        if($senha == $rSenha){

            $sql = "SELECT user FROM `user` WHERE user = :user";

            $conn = Handle::Db_handle($db);

            $stmt_query = $conn->prepare($sql);

            $stmt_query->bindValue(':user', $user, PDO::PARAM_STR);
            $stmt_query->execute();

            if ($stmt_query->rowCount() > 0) {

                http_response_code(403);
                echo json_encode([
                    'sucesso' => 1,
                    'mensagem' => ' Usuário já cadastrado, Por favor utilize outro.'
                ]);
                exit;
                
            }

            $query = "INSERT INTO `user`(user, password, id_log) VALUES(:user, :password, :id_log)";
                
                
            $stmt = $conn->prepare($query);

            $log = Ctrl::Token_call($user);

            $stmt->bindValue(':user', $user, PDO::PARAM_STR);
            $stmt->bindValue(':password', password_hash($senha, PASSWORD_DEFAULT), PDO::PARAM_STR);
            $stmt->bindValue('id_log', $log, PDO::PARAM_STR);


              

            if ($stmt->execute()) {

                http_response_code(200);
                //mensagem de erro
                echo json_encode([ 
                    'sucesso' => 0,
                    'mensagem' => 'Usuário ' . $user. ' Cadastrado com sucesso!'
                ]);
                exit;
            }


        }else{

            http_response_code(400);
            //mensagem de erro
            echo json_encode([ 
                'sucesso' => 0,
                'mensagem' => 'Senhas não Correspondem! Por favor tente novamente.'
            ]);
            exit;
        }
        
    }


}









?>