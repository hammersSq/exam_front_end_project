import 'package:front_end_project/model/objects/Product.dart';

class ProductInOrder {
  
  int quantity;
  Product product;
  
  ProductInOrder({this.product,this.quantity});


  factory ProductInOrder.fromJson(Map<String, dynamic> json) {
    return ProductInOrder(
        product: Product.fromJson(json['product']),
        quantity : json['quantity']
    );
  }
  Map<String, dynamic> toJson() => {
    'product': product,
    'quantity' : quantity
  };
  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}