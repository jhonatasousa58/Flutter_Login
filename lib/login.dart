
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './signup.dart';

class pageLogin extends StatelessWidget {

  String email, senha;

  @override

  final _key = new GlobalKey<FormState>();
  final focusSenha = FocusNode();

  checkE(){
    print("$email, $senha");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        key: _key,
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
              validator: (e){
                if(e.isEmpty){
                  return "Porfavor inserir um email";
                }
              },
              autofocus: false,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (term){
                FocusScope.of(context).requestFocus(focusSenha);
              },
              onSaved: (e)=>email = e,
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
              onSaved: (e)=>senha = e,
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