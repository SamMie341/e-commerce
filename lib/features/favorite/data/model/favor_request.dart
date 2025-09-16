class FavoriteRequest {
  final int productId;
  bool favorite;

  FavoriteRequest({required this.productId, required this.favorite});

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "favorite": favorite,
      };
}
