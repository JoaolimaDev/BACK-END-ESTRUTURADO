<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Credentials: true");


function loader() : void
{
    spl_autoload_register(function($class){

        $prefix = str_replace("\\", DIRECTORY_SEPARATOR, $class);


        require_once("api/".$prefix.".php");


    });
}

require_once("vendor/autoload.php");
require_once("api/controller/Ctrl.php");


use Psr\Http\Message\ServerRequestInterface as Request;
use Selective\BasePath\BasePathMiddleware;
use Slim\Factory\AppFactory;
use view\Chave;
use controller\Ctrl;

$app = AppFactory::create();

$app->addRoutingMiddleware();
$app->add(new BasePathMiddleware($app));
$app->addErrorMiddleware(false, true ,true);



    $app->post('/client/{menuop}/', function (Request $request) {

        $menuop = is_string($request->getAttribute('menuop')) ? htmlspecialchars($request->getAttribute('menuop')) : null;

        loader();

        new view\Client($menuop);
            
    });

    $app->post('/client/auth-key', function () {

       loader();
    
        Chave::auth_key();
        
    });


    $app->post('/user-action/{menuop}/', function (Request $request) {

        loader();

      $menuop = is_string($request->getAttribute('menuop')) ? htmlspecialchars($request->getAttribute('menuop')) : null;
    
      new view\Login($menuop, $_SERVER['DB']);

    });


    $app->post('/user/cadastro', function () {
    
        loader();
        new view\User("cadastro", $_SERVER['DB']);

    });

    $app->post('/user/{menuop}/', function (Request $request) {
        
        Ctrl::Auth_call($_SERVER['HTTP_AUTHORIZATION'], $_SERVER['DB']);

        $menuop = is_string($request->getAttribute('menuop')) ? htmlspecialchars($request->getAttribute('menuop')) : null;
     
         loader();
         new view\User($menuop, $_SERVER['DB']);
 
     });

$app->run();


?>
