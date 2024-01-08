class CartItem {
  final int id;
  final String productName;
  final double price;
  final String currency;
  final String imageUrl;
  int quantity;

  CartItem({
    required this.id,
    required this.productName,
    required this.price,
    required this.currency,
    required this.imageUrl,
    this.quantity = 1,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      productName: json['product_name'],
      price: json['price'].toDouble(),
      currency: json['currency'],
      imageUrl: json['image_url'],
      quantity: 1,
    );
  }
}

class ShoppingCart {
  final List<CartItem> cart;

  ShoppingCart({required this.cart});

  factory ShoppingCart.fromJson(Map<String, dynamic> json) {
    List<dynamic> cartJson = json['cart'];
    List<CartItem> cartItems =
        cartJson.map((item) => CartItem.fromJson(item)).toList();

    return ShoppingCart(cart: cartItems);
  }
}
