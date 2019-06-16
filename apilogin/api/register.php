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


        $check = "SELECT * FROM usuarios WHERE cpf = '$cpf' OR email = '$email'";
        $resultc = mysqli_fetch_array(mysqli_query($conn, $check));

        if(isset($resultc)){
            $resposta['value'] = 2;
            $resposta['mensagem'] = "CPF ou Email ja cadastrado";
            echo json_encode($resposta);
        }else{
            $insert = "INSERT INTO usuarios VALUES('$nome','$cpf','$email','$senha','$datanasc','$datacriacao',)";

            if(mysqli_query($conn, $insert)){
                $resposta['value'] = 1;
                $resposta['mensagem'] = "Cadastro Realizado com Sucesso";
                echo json_encode($resposta);
            }else{
                $resposta['value'] = 0;
                $resposta['mensagem'] = "Cadastro Falhou";
                echo json_encode($resposta);
            }
        }
    }