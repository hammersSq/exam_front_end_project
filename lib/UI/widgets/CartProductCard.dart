import 'package:front_end_project/model/objects/Product.dart';
import 'package:flutter/material.dart';
import 'package:front_end_project/UI/pages/Cart.dart';
import 'package:front_end_project/model/objects/ProductInOrder.dart';

class CartProductCard extends StatelessWidget {
  final Product product;


  CartProductCard({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int quantity=product.quantity;
    double price=product.price;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              product.name,
              style: TextStyle(
                fontSize: 40,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              product.description,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              "prezzo:€ $price",
              style: TextStyle(
                  color: Theme.of(context).primaryColor
              ),
            ),
            Text(
              "quantita: $quantity",
              style: TextStyle(
                  color: Theme.of(context).primaryColor
              ),
            ),
          ],
        ),
      ),
    );
  }



}