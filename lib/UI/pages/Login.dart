

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_end_project/UI/widgets/BoolProgressIndicator.dart';
import 'package:front_end_project/UI/widgets/CircularIconButton.dart';
import 'package:front_end_project/UI/widgets/InputField.dart';
import 'package:front_end_project/model/Model.dart';
import 'package:front_end_project/model/support/LogInResult.dart';

class Login extends StatefulWidget{
  Login({Key key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{

  static String text="";
  bool _loading=false;
  static bool _logged=false;
  TextEditingController _emailFiledController = TextEditingController();
  TextEditingController _passwordFiledController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(!_logged){
      return login();
    }
    return home();
  }
  Widget login(){
    return Scaffold(
      body:Center(

        child:Padding(
          padding: EdgeInsets.fromLTRB(100, 100, 100, 100),
          child: Column(
            children: [
             InputField(labelText: "username",controller: _emailFiledController),
             InputField(labelText: "password",controller: _passwordFiledController,isPassword: true,),
             CircularIconButton(onPressed: (){_login();},icon: Icons.login_rounded,),
              Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0),child:BoolProgressIndicator(_loading)),
            ],
         ),
       )
      ),
    );
  }
  Widget home(){
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 50,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Icon(
                Icons.shopping_basket_outlined,
                size: 300,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: CircularIconButton(icon: Icons.logout_rounded,onPressed: (){_logout();},)
            )
          ],
        ),
      ),
    );
  }

  void _login(){
   setState(() {
     _loading=true;


   });
   Model.sharedInstance.logIn(_emailFiledController.text, _passwordFiledController.text).then((result) {
     setState(() {
       print("richiesta finita");
       _passwordFiledController.clear();
       _loading=false;
       if(LogInResult.logged==result){
         _logged=true;
         text="welcome "+_emailFiledController.text;
       }
       if(LogInResult.error_wrong_credentials==result){
         _showDialog();
       }

     });
   });
  }
  void _logout(){
    Model.sharedInstance.logOut().then((value) {
      setState(() {
        _logged=false;
      });
    });
  }

  void _showDialog(){
    showDialog(
      context: context,
      builder:(BuildContext context){
        return AlertDialog(
            title: new Text("Attenzione!!"),
        content: new Text("Credenziali Sbagliate"),
          backgroundColor: Theme.of(context).primaryColor,

        );
      }


    );
  }




}