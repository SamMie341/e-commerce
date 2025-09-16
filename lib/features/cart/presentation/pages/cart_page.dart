import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/utils/constant.dart';
import 'package:e_commerce/core/utils/utility.dart';
import 'package:e_commerce/core/widgets/appbar_widget.dart';
import 'package:e_commerce/features/cart/presentation/controllers/cart_controller.dart';
import 'package:e_commerce/features/cart/presentation/controllers/sale_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cartController = Get.find<CartController>();
  final controller = Get.find<SaleController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 243, 243),
        appBar: buildAppBar(context,
            title: 'ກະຕ່າ',
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ))),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: Obx(() {
            if (cartController.cartItems.isEmpty) {
              return const Center(
                child: Text('ບໍ່ມີສິນຄ້າໃນກະຕ່າ'),
              );
            }
            return Padding(
              padding: const EdgeInsets.only(
                top: 10,
                right: 10,
                left: 10,
                bottom: 10,
              ),
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartController.cartItems[index];
                  return Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        item['pimg'] != null
                            ? CachedNetworkImage(
                                imageUrl:
                                    '$apiUrl/upload/product/${item['pimg']}',
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.contain)),
                                ),
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              )
                            : const Icon(
                                Icons.image_not_supported_outlined,
                              ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title'],
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  item['detail'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          // await Utility.removeFromCart(item);
                                          // setState(() {});
                                          await cartController
                                              .deleteProduct(item);
                                          setState(() {});
                                        },
                                        icon: Icon(
                                            Icons.do_not_disturb_on_outlined)),
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: FutureBuilder(
                                            future: Utility.getCartItems(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Text('1');
                                              }
                                              final cart = snapshot.data!;
                                              final index = cart.indexWhere(
                                                  (pr) =>
                                                      pr['id'] == item['id']);
                                              return Text(
                                                '${index != -1 ? cart[index]['quantity'] : 1}',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              );
                                            })),
                                    IconButton(
                                        onPressed: () async {
                                          await cartController.addProduct(item);
                                          setState(() {});
                                        },
                                        icon: Icon(
                                            Icons.add_circle_outline_rounded)),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 0.5,
                                              color: Colors.black54))),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        // Utility.formatLaoKip(item['price'] *
                                        //     (item['quantity'] ?? 1)),
                                        Utility.formatLaoKip(item['price']),
                                        style: TextStyle(
                                          // fontSize: 16,
                                          // fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      Utility.formatLaoKip(
                                          item['price'] * item['quantity']),
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // IconButton(
                                    //     onPressed: () async {
                                    //       await cartController
                                    //           .removeProduct(item);
                                    //       setState(() {});
                                    //     },
                                    //     icon: Icon(
                                    //       Icons.delete,
                                    //       color: Colors.red,
                                    //     ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          }),
        ),
        bottomNavigationBar: FutureBuilder(
            future: Utility.getCartItems(),
            builder: (context, snapshot) {
              var total = 0.0.obs;
              if (!snapshot.hasData) return SizedBox.shrink();
              final cart = snapshot.data!;
              total.value = cart.fold<double>(
                  0.0,
                  (sum, item) =>
                      sum + (item['price'] * (item['quantity'] ?? 1)));

              return Container(
                color: Colors.white,
                height: 120,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ລວມເງິນທັງໝົດ:',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          Obx(() => Text(
                                Utility.formatLaoKip(total.value),
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ))
                        ],
                      ),
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            elevation: WidgetStatePropertyAll(5),
                            shadowColor: WidgetStatePropertyAll(Colors.black),
                            backgroundColor: WidgetStatePropertyAll(Colors.red),
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)))),
                        onPressed: () async {
                          final items = cart.map((item) {
                            final total = cart.fold<num>(
                                0,
                                (sum, item) =>
                                    sum +
                                    (item['price'] * (item['quantity'] ?? 1)));
                            return {
                              "productId": item['id'],
                              "quantity": item['quantity'],
                              "price": item['price'],
                              "totalprice": total,
                            };
                          }).toList();
                          print('items: $items');
                          await controller.submitSale(items);
                          await cartController.clearCart();
                          total.value = 0;
                        },
                        child: Container(
                            width: double.maxFinite,
                            height: 50,
                            child: Center(
                                child: Text(
                              'ສັ່ງຊື້',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ))))
                  ],
                ),
              );
            }));
  }
}
