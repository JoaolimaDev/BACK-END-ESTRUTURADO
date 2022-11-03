<?php 
namespace controller;
session_start();

class Token
{

    public static function Gb_Token(string $user) : string
    {
        function base64ErlEncode($data)
        {
            return str_replace(['+', '/', '='], ['-', '_', ''], base64_encode($data));

        }

        $header = json_encode([
        'alg' => 'HS256',
        'typ' => 'JWT'
        ]);

        $header = base64ErlEncode($header);

        $payload = json_encode([
        'iss' => 'GIP',
        'user' => $user,
        'exp'=> date("Y-m-d", strtotime("+1 day")),
        'log-data' => date("Y-m-d h:i:sa")
        ]);

        $payload = base64ErlEncode($payload);

        session_regenerate_id();

        $signature = hash_hmac('sha256',"$header.$payload",session_id(),true);
        $signature = base64ErlEncode($signature);

        return  "$header.$payload.$signature";

    }
    
}

?>