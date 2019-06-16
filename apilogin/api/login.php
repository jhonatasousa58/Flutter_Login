<?php

    require ('../config/connect.php');

    if($_SERVER['REQUEST_METHOD'] == "POST"){
        $resposta = array();
        $nome = $_POST['nome'];
        $cpf = $_POST['cpf'];
        $email = $_POST['email'];
        $senha = md5($_POST['senha']);
        $datanasc = $_POST['data_nascimento'];
        $datacriacao = date('y-m-d');


        $check = "SELECT * FROM usuarios WHERE email = '$email' AND senha = '$senha'";
        $resultc = mysqli_fetch_array(mysqli_query($conn, $check));

        if(isset($resultc)){
            $resposta['value'] = 1;
            $resposta['mensagem'] = "Sucesso no login";
            echo json_encode($resposta);
        }else{
            $resposta['value'] = 0;
            $resposta['mensagem'] = "Falha no login";
            echo json_encode($resposta);
        }
    }