
import 'package:flutter/material.dart';
import 'package:front_end_project/UI/pages/Cart.dart';
import 'package:front_end_project/model/objects/Product.dart';
import 'package:front_end_project/model/objects/ProductInOrder.dart';


class ProductCard extends StatelessWidget {
  final Product product;


  ProductCard({Key key, this.product}) : super(key: key);

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
            RawMaterialButton(onPressed: (){addToCart();},child: Icon(Icons.add_shopping_cart),fillColor: Theme.of(context).buttonColor, )
          ],
        ),
      ),
    );
  }
  void addToCart(){
    bool flag=false;
    for(int i=0;i<CartState.products.length;i++){
      if(CartState.products[i].product.id==product.id){
        CartState.products[i].product.quantity++;
        flag=true;
      }
    }
    if(!flag && product.quantity>0){
      Product toAdd=new Product(id: product.id,quantity: 1, category: product.category,description: product.description,price: product.price, name: product.name);
      CartState.products.add(ProductInOrder(quantity: 1,product: toAdd));
    }
  }


}
