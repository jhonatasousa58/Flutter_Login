
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './signup.dart';

class pageLogin extends StatefulWidget{
  @override

  _LoginState createState() =>_LoginState();
}

class DadosLogin {
  final int id;
  final String nome;
  final String emaillog;
  final String cpf;
  final String data_nascimento;
  final String data_criacao_conta;


  DadosLogin({this.id, this.nome, this.emaillog, this.cpf, this.data_nascimento, this.data_criacao_conta});

  factory DadosLogin.fromJson(Map<String, dynamic> json) {
    return DadosLogin(
      id: json['id'] as int,
      nome: json['nome'] as String,
      emaillog: json['email'] as String,
      cpf: json['cpf'] as String,
      data_nascimento: json['data_nascimento'] as String,
      data_criacao_conta: json['data_criacao_conta'] as String,
    );
  }
}

class _LoginState extends State<pageLogin> {

  String email, senha;
  @override

  final _key = new GlobalKey<FormState>();
  final focusSenha = FocusNode();

  checkE(){
    final form = _key.currentState;
    if(form.validate()) {
      form.save();
      loginH();
    }
  }

  loginH() async{
    final res = await http.get("http://10.0.2.2:2345?method=get&db=bd&operation=2&email=$email&senha=$senha", headers: {"Accept": "application/json"});
    if(res.statusCode == 200){
      final data = jsonDecode(res.body);
      print(data);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _key,
          child: Container(
            padding: EdgeInsets.only(
              top: 110,
              left: 40,
              right: 40,
            ),
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Center(
                child: Container(
                  width: 400.0,
                  height: 60.0,
                  child: Text(
                    ('SpotJAMS'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Arial', fontSize: 50.0, fontWeight: FontWeight.bold
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0), color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (e) =>
                    !e.contains('@') ? "Por favor inserir um email válido" : null,
                onSaved: (e) => email = e,
                autofocus: false,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (term){
                  FocusScope.of(context).requestFocus(focusSenha);
                },
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                  style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (e){
                  if(e.isEmpty){
                    return "Por favor insira uma senha";
                  }
                },
                onSaved: (e) => senha = e,
                autofocus: false,
                keyboardType: TextInputType.text,
                obscureText: true,
                focusNode: focusSenha,
                decoration: InputDecoration(
                  labelText: "Senha",
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 60,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Color(0xFF19B37A),
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: SizedBox.expand(
                  child: FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Entrar",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 30,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    onPressed: () {
                      checkE();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Novo por aqui ?",
                  ),
                ],
              ),
              Center(
                child: RaisedButton(
                    child: Text(
                        "Registrar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                    ),
                    onPressed: () {
                      Navigator.push(context, SlideRightRoute(page: pageSignUp()));
                    },
                    color: Color(0xFF19B37A),
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
  );
}