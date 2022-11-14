<?php 
namespace view;

require_once("api/model/DAO.php");

use model\Sql;
use PDO;
use PDOException;


class Client
{
        private $host = 'localhost';
        private $username = 'admin';
        private $password = 'admin';
        private $conn;


    public function __construct($menuop)
    {
        switch ($menuop) 
        {
            case 'add_client':

             return $this->Client_add();

            break;

            case 'insert_client':
                
             return $this->Insert_client();
    
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


    public function Client_add() : void
    {

        $this->conn = null;

        try {

            $data = json_decode(file_get_contents("php://input"));

            if (empty(trim($data->nome))):
                http_response_code(400);
                echo json_encode(['sucesso' => 0, 'mensagem' => 'Adicione o nome do cliente!']);
                
                exit;
            endif;

            $cliente = htmlspecialchars(strip_tags($data->nome));
            
            $this->conn = new PDO('mysql:host=' . $this->host,
            $this->username, $this->password);

            $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

            $sql_table = file_get_contents("api/view/sql/jcasolutions_perecife.sql");

            $sql = "CREATE DATABASE $cliente; USE $cliente;". $sql_table; // adicionar o négocio do cpanel;

            if ($this->conn->exec($sql)) {
                http_response_code(200);
                echo json_encode([
                 'Sucesso' => 1,
                 'Mensagem' => 'Sistema criado! Database .:'.$cliente. 
                 'Próximo passo cadastre o Banco deste cliente!'
                ]);
                exit;

            }
    
                                                            
        } catch(PDOException $e) {
         http_response_code(200);
         echo json_encode([
          'Sucesso' => 0,
          'Mensagem' => 'Erro .:'.$e->getMessage()
         ]);
         exit;

        }

    }

    public function Insert_client() :void
    {
        $data = json_decode(file_get_contents("php://input"));

        if (empty(trim($data->nome))):
            http_response_code(400);
            echo json_encode(['sucesso' => 0, 'mensagem' => 'Adicione o nome do cliente!']);
            
            exit;
        endif;

        if (empty(trim($data->dbase))):
            http_response_code(400);
            echo json_encode(['sucesso' => 0, 'mensagem' => 'Adicione o DB do cliente!']);
            
            exit;
        endif;

        $chave =  Chave::Get_Key();

        $array_client = array(':chave' => $chave, ':nome' => $data->nome, 
        ':dbase' => $data->dbase);

        Sql::query("INSERT INTO `cliente` (chave, nome, dbase) VALUES (:chave, :nome, 
        :dbase)", "jcasolutions_gip2021Admin", $array_client);

              http_response_code(200);
              echo json_encode([
               'Sucesso' => 1,
               'Mensagem' => 'Cliente cadastrado com sucesso! Chave de acesso .: ' .$chave
              ]);
              exit;

          
    }   
    
}

?>