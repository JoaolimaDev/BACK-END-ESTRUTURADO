<?php
namespace controller;


class Ctrl 
{

  
    public static function Token_call(string $user) : string
    {
        require_once("Token.php");

        return Token::Gb_Token($user);
    }

    public static function Auth_call($token, $db)
    {
        require_once("Auth.php");

        Auth::Auth_token($token, $db);
        
    }
}




?>