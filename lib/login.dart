
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './signup.dart';
import './user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class pageLogin extends StatefulWidget{
  @override

  _LoginState createState() =>_LoginState();
}

enum LoginStatus{
  naoLogado,
  Logado
}

class DadosLogin {
  final String id;
  final String nome;
  final String emaillog;
  final String cpf;
  final String data_nascimento;
  final String data_criacao_conta;


  DadosLogin({this.id, this.nome, this.emaillog, this.cpf, this.data_nascimento, this.data_criacao_conta});

  factory DadosLogin.fromJson(Map<String, dynamic> json) {
    return new DadosLogin(
      id: json['id'],
      nome: json['nome'],
      emaillog: json['email'],
      cpf: json['cpf'],
      data_nascimento: json['data_nascimento'],
      data_criacao_conta: json['data_criacao_conta']
    );
  }
}

List<User> convertUser(List<DadosLogin> list){
  List<User> userL = new List<User>();
  User user;
  for (DadosLogin i in list) {
    user =  new User();
    print(i.nome);
    print(i.id);
    print(i.emaillog);
    user.setUser(i.id, i.nome, i.emaillog, i.cpf, i.data_nascimento, i.data_criacao_conta, );
    userL.add(user);
  }
  return userL;
}

class _LoginState extends State<pageLogin> {
  LoginStatus _loginStatus = LoginStatus.naoLogado;
  String email, senha;
  @override

  final _key = new GlobalKey<FormState>();
  final focusSenha = FocusNode();

  checkE(){
    final form = _key.currentState;
    if(form.validate()) {
      form.save();
      fetchDados();
      loginH();
    }
  }

  User user;
  Future<List<User>> fetchDados() async{
    final response = await http.get("http://10.0.2.2:2345?method=get&db=bd&operation=2&email=$email&senha=$senha", headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      var j = json.decode(response.body);
      List<User>  list = new   List<User>();
      List<DadosLogin> users = new List<DadosLogin>.from(j.map((i)=> DadosLogin.fromJson(i)).toList());
      list = convertUser(users);
      print("TAMANHO LISTAAAAAAAAAA");
      print(list.length);
      return list;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  loginH() async{
    //final res = await http.get("http://10.0.2.2:2345?method=get&db=bd&operation=2&email=$email&senha=$senha", headers: {"Accept": "application/json"});
    //if(res.statusCode == 200){
      //final data = jsonDecode(res.body);
      int id = 1;
      if(id != null){
        setState(() {
          _loginStatus = LoginStatus.naoLogado;
          //savePreferences(id);
        });
      }else{
        print("erro");
      }
    //}
  }
/*
  savePreferences(int id) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt("id", id);
      // ignore: deprecated_member_use
      prefs.commit();
    });
  }

  var value;
  getPreferences() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      value = prefs.getInt("id");
      _loginStatus = value == 1 ? LoginStatus.Logado : LoginStatus.naoLogado;
    });
  }

  @override
  void initState(){
    super.initState();
    getPreferences();
  }
*/
  Widget build(BuildContext context) {
    switch(_loginStatus){
      case LoginStatus.naoLogado:
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
        break;
      case LoginStatus.Logado:
        return MainMenu();
        break;
    }
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

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('LOGADAO'),
      ),
    );
  }
}
