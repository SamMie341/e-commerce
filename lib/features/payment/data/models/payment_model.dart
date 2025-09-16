class PaymentModel {
  final int id;
  final String orderNo;
  final int productId;
  final String userCode;
  final int quantity;
  final String price;
  final String totalprice;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Product product;

  PaymentModel({
    required this.id,
    required this.orderNo,
    required this.productId,
    required this.userCode,
    required this.quantity,
    required this.price,
    required this.totalprice,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json["id"],
        orderNo: json["orderNo"],
        productId: json["productId"],
        userCode: json["userCode"],
        quantity: json["quantity"],
        price: json["price"],
        totalprice: json["totalprice"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderNo": orderNo,
        "productId": productId,
        "userCode": userCode,
        "quantity": quantity,
        "price": price,
        "totalprice": totalprice,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "product": product.toJson(),
      };
}

class Product {
  final int id;
  final String title;
  final String pimg;

  Product({
    required this.id,
    required this.title,
    required this.pimg,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        pimg: json["pimg"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "pimg": pimg,
      };
}
