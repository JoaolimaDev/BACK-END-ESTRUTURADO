<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Credentials: true");


require_once("vendor/autoload.php");
//require_once("api/controller/Ctrl.php");

//use controller\Ctrl;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Selective\BasePath\BasePathMiddleware;
use Slim\Factory\AppFactory;
use view\Chave;

/*
$arr = ["POST", "GET", "PUT", "DELETE"];

if (in_array($_SERVER['REQUEST_METHOD'], $arr)) {

    Ctrl::Auth_call($_SERVER['HTTP_AUTHORIZATION'], $_SERVER['DB']);
}
*/


$app = AppFactory::create();

$app->addRoutingMiddleware();
$app->add(new BasePathMiddleware($app));
$app->addErrorMiddleware(false, true ,true);

    $app->get('/', function (Request $request, Response $response) {
        $response->getBody()->write(
            json_encode([
                'Sucesso'=>0,
                'Mensagem'=>'Sistema_Rest.API_GIP'
            ]));
        return $response;
    });

    $app->post('/user/chave', function () {

        require_once("api/view/Chave.php");
    
        Chave::auth_key();
        
    });

    $app->post('/user/{menuop}', function (Request $request) {

        $menuop = is_string($request->getAttribute('menuop')) ? htmlspecialchars($request->getAttribute('menuop')) : null;
    
        new view\Login($menuop, $_SERVER['DB']);
        
    });
  



$app->run();


?>
