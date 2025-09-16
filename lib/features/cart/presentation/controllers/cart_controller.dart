import 'package:e_commerce/core/utils/utility.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <Map<String, dynamic>>[].obs;
  var cartCount = 0.obs;
  var quantity = 1.obs;
  var userCode = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  Future<void> loadCart() async {
    cartItems.value = await Utility.getCartItems();
    cartCount.value = cartItems.length;
  }

  Future<void> addProduct(Map<String, dynamic> product) async {
    await Utility.addToCart(product);
    await loadCart();
  }

  Future<void> removeProduct(Map<String, dynamic> product) async {
    await Utility.removeItem(product['id']);
    await loadCart();
  }

  Future<void> clearCart() async {
    await Utility.clearCart();
    await loadCart();
  }

  Future<void> deleteProduct(Map<String, dynamic> product) async {
    await Utility.removeFromCart(product);
    await loadCart();
  }

  void incrementQuantity() {
    quantity.value++;
    quantity.refresh();
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
      quantity.refresh();
    }
  }
}
