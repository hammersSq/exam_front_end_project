class Product {
  int id;
  String name;
  String category;
  String description;
  double price;
  int quantity;


  Product({this.id, this.name, this.category, this.description,this.price,this.quantity});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      description: json['description'],
      price: json['price'],
      quantity: json['quantity']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'category': category,
    'description': description,
    'price' : price,
    'quantity': quantity
  };

  @override
  String toString() {
    return name;
  }


}