
import 'package:flutter/material.dart';
import 'package:front_end_project/UI/pages/Layout.dart';
import 'package:front_end_project/model/support/Constants.dart';


class App extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.APP_NAME,

      theme: ThemeData(
        primaryColor: Colors.indigo,
        backgroundColor: Colors.white,
        buttonColor: Colors.lightBlueAccent,
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.deepPurple,
        backgroundColor: Colors.black,
        canvasColor: Colors.black,
        buttonColor: Colors.deepPurple,
        cardColor: Colors.grey,
      ),
      home: Layout(title: Constants.APP_NAME),
    );
  }


}
