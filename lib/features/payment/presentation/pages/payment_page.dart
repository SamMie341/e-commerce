import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:e_commerce/core/utils/constant.dart';
import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/utils/format_pattern.dart';
import 'package:e_commerce/core/utils/utility.dart';
import 'package:e_commerce/core/widgets/appbar_widget.dart';
import 'package:e_commerce/core/widgets/full_image_widget.dart';
import 'package:e_commerce/core/widgets/show_alert.dart';
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

  @override
  void initState() {
    final orderId = orderController.orderProcessList;
    super.initState();
    controller.fetchBank(orderId.first.id);
  }

  @override
  Widget build(BuildContext context) {
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
                    fontSize: 20),
              ),
              SizedBox(height: 5),
              Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                      child: CircularProgressIndicator(color: primaryColor));
                }
                if (controller.paymentList.value == null) {
                  return Center(
                      child: Text('ບໍ່ມີລາຍການ',
                          style: TextStyle(fontWeight: FontWeight.bold)));
                }
                final order = controller.paymentList.value!;

                final productList = order.orderDetails;

                if (productList == null || productList.isEmpty) {
                  return Center(child: Text('ບໍ່ມີລາຍການສິນຄ້າໃນ Order ນີ້'));
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ຮ້ານຄ້າ: ${order.shop!.name}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'ໄອດີສັ່ງຊື້: ${order.orderNo}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        final item = productList[index];
                        return Column(
                          children: [
                            Card(
                              margin: const EdgeInsets.all(0),
                              elevation: 2,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  // color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    CachedNetworkImage(
                                        height: 80,
                                        width: 80,
                                        imageUrl:
                                            '$apiProductUrl/${item.product?.pimg}'),
                                    SizedBox(width: 10),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${item.product!.title}',
                                          maxLines: 2,
                                          style: TextStyle(),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'ຈຳນວນ: ',
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text('${item.quantity}'),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 16),
                                          child: Row(
                                            children: [
                                              Text(
                                                'ລວມເປັນເງິນທັງໝົດ: ',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Text(
                                                Utility.formatLaoKip(
                                                    double.parse(
                                                        item.totalprice!)),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.red),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                          ],
                        );
                      },
                    ),
                  ],
                );
              }),
              // SizedBox(height: 10),
              // Text(Utility.formatLaoKip(num.tryParse(
              //         controller.paymentList.value?.grandtotalprice!) ??
              //     0)),
              SizedBox(height: 20),
              Text(
                'ເລືອກສະຖານທີ່ຮັບເຄື່ອງ',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 10),
              Form(
                key: controller.formKey,
                child: Obx(
                  () => DropdownButtonFormField(
                      validator: (value) {
                        if (value == null) {
                          return 'ກະລຸນາເລືອກສະຖານທີ່ຮັບເຄື່ອງ';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        // labelText: 'ສະຖານທີ່ຮັບເຄື່ອງ',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                            // borderSide: BorderSide(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        focusedBorder: OutlineInputBorder(
                            // borderSide: BorderSide(),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      value: controller.selectedLocat.value,
                      items: controller.locationList.map((l) {
                        return DropdownMenuItem(value: l, child: Text(l.name));
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          controller.selectedLocat.value = value;
                        }
                      }),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'ຊຳລະຜ່ານທະນາຄານ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5),
              Obx(() {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (controller.bankList.isNotEmpty)
                        ...List.generate(controller.bankList.length, (index) {
                          final bank = controller.bankList[index];
                          return buildBankCard(bankData: bank);
                        })
                      else
                        Center(
                            child: Text('ບໍ່ພົບຂໍ້ມູນທະນາຄານ',
                                style: TextStyle(color: Colors.grey))),
                    ],
                  ),
                );
              }),
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
                  controller: controller.commentController,
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
                                          'ອັບໂຫຼດສະລິປການໂອນ',
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
        height: 70,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(primaryColor),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            onPressed: () {
              showDialogQuestion(
                'ຊຳລະເງິນ',
                'ທ່ານແນ່ໃຈທີ່ຈະຊຳລະບໍ?',
                context,
                btnConfirm: 'ຢືນຢັນ',
                btnCancel: 'ຍົກເລີກ',
                onConfirm: () {
                  Get.back();
                  if (controller.formKey.currentState!.validate()) {
                    controller.payment();
                  }
                },
              );
            },
            child: SizedBox(
              height: 20,
              child: Center(
                child: Text(
                  'ຢືນຢັນການຊຳລະ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    // fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            )),
      ),
    );
  }

  Widget buildBankCard({required bankData}) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              final qrCodeFileName = bankData.bankqr;
              final bankName = bankData.banklogo!.name!;
              final qrCodeUrl = '$apiBankUrl/$qrCodeFileName';

              return Container(
                height: MediaQuery.of(context).size.height,
                // padding: EdgeInsets.all(12),
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
                            bankData.banklogo!.name!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              // fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                              onPressed: () {
                                if (qrCodeFileName != null &&
                                    qrCodeFileName.isNotEmpty) {
                                  controller.downloadQRCode(
                                      qrCodeUrl, bankName);
                                } else {
                                  Get.snackbar('Error',
                                      'ບໍ່ສາມາດດາວໂຫຼດໄດ້: ບໍ່ພົບ QR Code URL');
                                }
                              },
                              icon: Icon(
                                Icons.download_outlined,
                                size: 30,
                              )),
                        )
                      ],
                    ),
                    Obx(() {
                      final currentBankList = controller.bankList;

                      if (currentBankList.isEmpty || bankData.bankqr == null) {
                        return Center(
                            child: Text('ບໍ່ມີ QR Code/ຂໍ້ມູນບໍ່ຖືກຕ້ອງ'));
                      }

                      final qrCodeUrl = '$apiBankUrl/${bankData.bankqr}';
                      return Center(
                          child: Column(
                        children: [
                          Text(FormatPattern()
                              .formatPattern3and4(bankData.accountNo)),
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                  () => FullScreenImagePage(
                                      imageUrl: qrCodeUrl, heroTag: qrCodeUrl),
                                  opaque: false,
                                  transition: Transition.fadeIn,
                                  duration: const Duration(milliseconds: 300));
                            },
                            child: Hero(
                              tag: qrCodeUrl,
                              child: CachedNetworkImage(
                                imageUrl: qrCodeUrl,
                                height: Get.height * .39,
                                placeholder: (context, url) => Center(
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: primaryColor,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error, size: 50),
                              ),
                            ),
                          ),
                        ],
                      ));
                    }),
                    SizedBox(height: 10),
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: Get.width * .25,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Column(
            children: [
              Image.network('$apiBankUrl/${bankData.banklogo!.bankimg}',
                  width: 40),
              SizedBox(height: 10),
              Text(
                bankData.banklogo!.name!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
