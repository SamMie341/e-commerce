class OrderModel {
  final int productId;
  final int quantity;
  final int price;
  final int totalprice;

  OrderModel({
    required this.productId,
    required this.quantity,
    required this.price,
    required this.totalprice,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        productId: json["productId"],
        quantity: json["quantity"],
        price: json["price"],
        totalprice: json["totalprice"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "quantity": quantity,
        "price": price,
        "totalprice": totalprice,
      };
}
