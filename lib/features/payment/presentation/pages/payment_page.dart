import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:e_commerce/core/utils/constant.dart';
import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/utils/utility.dart';
import 'package:e_commerce/core/widgets/appbar_widget.dart';
import 'package:e_commerce/features/payment/presentation/controller/payment_controller.dart';
import 'package:e_commerce/features/transaction/presentation/controller/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final controller = Get.find<PaymentController>();
  final orderController = Get.find<OrderController>();

  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // print(Get.arguments['paymentId']);
    return Scaffold(
      backgroundColor: HexColor('f4f4f4'),
      appBar: buildAppBarCustom(context, 'ຊຳລະເງິນ'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            top: 15,
            right: 10,
            bottom: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: HexColor('#F5F073'),
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.all(5),
                child: Text.rich(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'ໝາຍເຫດ: ',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                          text:
                              'ຫຼັງຈາກທີ່ສະແກນ QR Code ຊຳລະແລ້ວທ່ານຈະຕ້ອງແຄັບໜ້າຈໍ ຊຳລະເງິນຂອງແອັບທະນາຄານ ແລ້ວອັບໂຫລດຮູບລົງໃນເມນູ '),
                      TextSpan(
                          text: 'ທຸລະກຳ ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline)),
                      TextSpan(text: 'ເຊິ່ງຈະໃຊ້ເວລາກວດສອບພາຍໃນ '),
                      TextSpan(
                        text: '24ຊົ່ວໂມງ ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: 'ອີງຕາມໂມງລັດຖະການ ແລະ ເວລາແຈ້ງຊຳລະເງິນ '),
                      TextSpan(
                        text:
                            '(ຖ້າບໍ່ມີການແຈ້ງຊຳລະເງິນພາຍໃນ1ຊົ່ວໂມງ ຫຼັງການສັ່ງຊື້ລະບົບຈະຍົກເລີກຄຳສັ່ງຊື້ຂອງທ່ານ).',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'ລາຍລະອຽດສິນຄ້າ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5),
              // FutureBuilder(
              //     future: controller.getPaymentById(Get.arguments['id']),
              //     builder: (context, snapshot) {
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return Center(
              //             child:
              //                 CircularProgressIndicator(color: primaryColor));
              //       }
              //       if (snapshot.hasError) {
              //         return Center(child: Text('ຜິດພາດ: ${snapshot.error}'));
              //       }

              //       if (snapshot.hasData) {
              //         if (snapshot.hasData == false) {
              //           return Center(child: Text('ບໍ່ມີສິນຄ້າ'));
              //         }
              //         final item = controller.paymentList.value;
              //         return Obx(() => Card(
              //               margin: const EdgeInsets.all(0),
              //               elevation: 2,
              //               child: Container(
              //                 padding: EdgeInsets.all(10),
              //                 decoration: BoxDecoration(
              //                   color: Colors.white,
              //                   borderRadius: BorderRadius.circular(8),
              //                 ),
              //                 child: Row(
              //                   children: [
              //                     CachedNetworkImage(
              //                         height: 80,
              //                         width: 80,
              //                         imageUrl:
              //                             '$apiProductUrl/${item!.orderDetails!.first.product!.pimg}'),
              //                     SizedBox(width: 10),
              //                     Column(
              //                       mainAxisAlignment: MainAxisAlignment.start,
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.start,
              //                       children: [
              //                         Row(
              //                           children: [
              //                             Text(
              //                               'ໄອດີສັ່ງຊື້: ${item.orderNo}',
              //                               style: TextStyle(
              //                                   fontWeight: FontWeight.bold),
              //                             ),
              //                           ],
              //                         ),
              //                         SizedBox(height: 10),
              //                         Row(
              //                           children: [
              //                             Text(
              //                               'ຈຳນວນ: ',
              //                               style: TextStyle(
              //                                 color: Colors.grey,
              //                               ),
              //                             ),
              //                             Text(
              //                                 '${item.orderDetails!.last.quantity}'),
              //                           ],
              //                         ),
              //                         SizedBox(height: 10),
              //                         Row(
              //                           children: [
              //                             Text(
              //                               'ລວມເປັນເງິນທັງໝົດ: ',
              //                               style: TextStyle(
              //                                 color: Colors.grey,
              //                               ),
              //                             ),
              //                             Text(
              //                               Utility.formatLaoKip(double.parse(
              //                                   item.orderDetails!.last
              //                                       .totalprice!)),
              //                               style: TextStyle(
              //                                   fontSize: 16,
              //                                   fontWeight: FontWeight.w600,
              //                                   color: Colors.red),
              //                             ),
              //                           ],
              //                         ),
              //                       ],
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ));
              //       }
              //       return Center(
              //           child: CircularProgressIndicator(color: Colors.red));
              //     }),
              Obx(() {
                final item = controller.paymentList.value;
                if (controller.isLoading.value) {
                  return CircularProgressIndicator();
                }
                return Card(
                  margin: const EdgeInsets.all(0),
                  elevation: 2,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        CachedNetworkImage(
                            height: 80,
                            width: 80,
                            imageUrl:
                                '$apiProductUrl/${item!.orderDetails!.single.product!.pimg}'),
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'ໄອດີສັ່ງຊື້: ${item.orderNo}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'ຈຳນວນ: ',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                Text('${item.orderDetails!.last.quantity}'),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'ລວມເປັນເງິນທັງໝົດ: ',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  Utility.formatLaoKip(double.parse(
                                      item.orderDetails!.last.totalprice!)),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.red),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
              SizedBox(height: 20),
              Text(
                'ຊຳລະຜ່ານທະນາຄານ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildBankCard(img: 'ldb.png', name: 'LDB Trust'),
                  buildBankCard(img: 'bcel.png', name: 'BCEL One'),
                  buildBankCard(img: 'jdb.png', name: 'JDB Yes'),
                  buildBankCard(img: 'ib.png', name: 'IB Cool'),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'ເພີ່ມຄຳເຫັນສຳລັບສິນຄ້າ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  autofocus: false,
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  controller: commentController,
                  cursorColor: Colors.grey[600],
                  maxLength: 200,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'ຄຳຄິດເຫັນກ່ຽວກັບສິນຄ້າ......',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                    counterStyle: TextStyle(
                      color: HexColor('#B9B9B9'),
                      fontSize: 12,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'ອັບໂຫຼດຮູບພາບ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  // Upload Area
                  Expanded(
                      flex: 2,
                      child: Obx(
                        () => GestureDetector(
                          onTap: () {
                            controller.pickImage();
                          },
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(8),
                            dashPattern: [8, 4],
                            strokeWidth: 2,
                            color: Colors.blue,
                            child: Container(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (controller.imageFile.value == null)
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.image,
                                          size: 40,
                                          color: Colors.blue,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'ອັບໂຫຼດສະລິປການໂອນຊຳລະ',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  if (controller.imageFile.value != null)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        controller.imageFile.value!,
                                        width: 150,
                                        height: 150,
                                        fit: BoxFit.contain,
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(HexColor('#537BEC')),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            onPressed: () {
              final item = controller.paymentList.value;
              print(item!.id);
              print(4);
              print(commentController.text);
              print(controller.imageFile.value);
              controller.payment(item.id!, 4, commentController.text,
                  controller.imageFile.value!);
            },
            child: SizedBox(
              height: 25,
              child: Center(
                child: Text(
                  'ຢືນຢັນການຊຳລະ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            )),
      ),
    );
  }

  Widget buildBankCard({String? img, String? name}) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            name,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.download_outlined,
                                size: 30,
                              )),
                        )
                      ],
                    ),
                    Center(child: Icon(Icons.qr_code_2_rounded, size: 320)),
                    // Spacer(),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.white)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'ປິດ',
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                  ],
                ),
              );
            }).whenComplete(() {
          FocusScope.of(context).unfocus();
        });
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Column(
          children: [
            Image.asset('assets/images/$img', width: 40),
            SizedBox(height: 10),
            Text(
              name!,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
