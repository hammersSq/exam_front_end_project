import 'package:front_end_project/model/objects/ProductInOrder.dart';

class Order {
  List<ProductInOrder> products;
  Order({this.products});

  Map<String,dynamic> toJson() => {
    'products': products
  };
}