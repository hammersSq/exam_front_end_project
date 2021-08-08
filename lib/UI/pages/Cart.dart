import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_end_project/UI/widgets/CartProductCard.dart';
import 'package:front_end_project/UI/widgets/CircularIconButton.dart';
import 'package:front_end_project/UI/widgets/ProductCard.dart';
import 'package:front_end_project/model/Model.dart';
import 'package:front_end_project/model/objects/Product.dart';
import 'package:front_end_project/model/objects/ProductInOrder.dart';

class Cart extends StatefulWidget{
  Cart({Key key}) : super(key: key);
  @override
  CartState createState() => CartState();
}

class CartState extends State<Cart>{

  static List<ProductInOrder> products=<ProductInOrder>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
          child:RawMaterialButton(
          fillColor: Theme.of(context).buttonColor,
          child: Text("Acquista ora", style: TextStyle(color: Theme.of(context).backgroundColor),),
          onPressed:(){doPurchase();},
        ),)
        ],
        title: Center(child:Text("Carrello")),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: Bottom(),
    );
  }
  Widget Bottom(){
    if(products==null || products.length==0 ){
      return Center(
          child: Text("Nessun prodotto nel carrello",style: TextStyle(color: Theme.of(context).accentColor),)
      );
    }
    return ProductInCart();

  }
  Widget ProductInCart(){
    return Container(
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(child:CartProductCard(
                  product: products[index].product,
                )),
                CircularIconButton(icon: Icons.plus_one,onPressed:(){add1(products[index]);},),
                CircularIconButton(icon: Icons.remove,onPressed:(){remove1(products[index]);},)
              ],
            );
          },
        ),
    );
  }

  void add1(ProductInOrder p){
    setState(() {
      for(int i=0;i<products.length;i++){
        if(products[i].product.id==p.product.id){
          products[i].quantity++;
          products[i].product.quantity++;
        }
      }
    });
  }
  void remove1(ProductInOrder p){
    setState(() {
      for(int i=0;i<products.length;i++){
        if(products[i].product.id==p.product.id){
          if(products[i].product.quantity >1){
            products[i].quantity--;
            products[i].product.quantity--;
          }
          else{
            products.remove(products[i]);
          }
        }
      }
    });

  }
  void doPurchase(){
      Model.sharedInstance.doPurchase(products).then((flag) {
        setState(() {
          if(flag.contains("acquisto ok")){
            products.clear();
            _showDialog("Acquisto andato a buon fine");
          }
          else if(flag.contains("effettua login prima di effettuare gli acquisti")){
            _showDialog("effettua login prima di effettuare gli acquisti");

          }
          else{
            _showDialog("quantitá non disponibile");
          }
        });
      });

  }
  void _showDialog(String message){
    showDialog(
        context: context,
        builder:(BuildContext context){
          return AlertDialog(
            title: new Text("Attenzione!!"),
            content: new Text(message),
            backgroundColor: Theme.of(context).primaryColor,

          );
        }


    );
  }



}