
import 'package:flutter/material.dart';
import 'package:front_end_project/UI/pages/Cart.dart';
import 'package:front_end_project/UI/widgets/CircularIconButton.dart';


import 'Login.dart';
import 'Search.dart';

class Layout extends StatefulWidget {
  final String title;


  Layout({Key key, this.title}) : super(key: key);

  @override
  _LayoutState createState() => _LayoutState(title);
}

class _LayoutState extends State<Layout> {
  String title;


  _LayoutState(String title) {
    this.title = title;
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          title: Center(child:Text(title)),
          bottom: TabBar(
            tabs: [
              Tab(text: "home", icon: Icon(Icons.home_rounded)),
              Tab(text:"Shop", icon: Icon(Icons.search_rounded))
              //Tab(text: "user", icon: Icon(Icons.person_rounded)),
            ],
          ),
          actions: [CircularIconButton(icon: Icons.shopping_cart,onPressed:(){goToCart();} ,)],
        ),
        body: TabBarView(
          children: [
            Login(),
            Search()
            //UserRegistration(),
          ],
        ),
      ),
    );
  }
  void goToCart(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Cart()),
    );
  }


}
