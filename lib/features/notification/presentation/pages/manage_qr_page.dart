import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:e_commerce/core/utils/constant.dart';
import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/widgets/appbar_widget.dart';
import 'package:e_commerce/core/widgets/customButton.dart';
import 'package:e_commerce/core/widgets/show_alert.dart';
import 'package:e_commerce/features/notification/data/model/bank_model.dart';
import 'package:e_commerce/features/notification/presentation/controller/shop_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageQrPage extends StatefulWidget {
  const ManageQrPage({super.key});

  @override
  State<ManageQrPage> createState() => _ManageQrPageState();
}

class _ManageQrPageState extends State<ManageQrPage> {
  final controller = Get.find<ShopProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBarCustom(context, 'ການຈັດການ QR'),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(
                    child: CircularProgressIndicator(color: primaryColor));
              }
              if (controller.bankList.isEmpty) {
                return Center(
                    child: const Text(
                  'ບໍ່ມີ QR ທະນາຄານ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ));
              }
              return ListView.builder(
                shrinkWrap: true,
                controller: controller.scrollController,
                itemCount: controller.bankList.length,
                itemBuilder: (context, index) {
                  final item = controller.bankList[index];

                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      // dense: true,
                      isThreeLine: true,
                      leading: Image.network(
                          '$apiUrl/upload/bank/${item.banklogo!.bankimg}'),
                      title: Text(item.accountName!),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.banklogo!.name!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(item.accountNo!),
                        ],
                      ),
                      trailing: OverflowBar(
                        children: [
                          IconButton(
                              onPressed: () {
                                controller.setEditDataQR(item);
                                _showAddBank(context);
                              },
                              icon: Icon(
                                Icons.edit_outlined,
                              )),
                          Obx(
                            () => controller.isLoading.value
                                ? Center(
                                    child: CircularProgressIndicator(
                                        color: primaryColor))
                                : IconButton(
                                    onPressed: () {
                                      showDialogQuestion(
                                          'ລຶບ QR Code',
                                          'ທ່ານຕ້ອງການລຶບ QR Code ບໍ?',
                                          btnConfirm: 'ຢືນຢັນ',
                                          btnCancel: 'ຍົກເລີກ',
                                          context, onConfirm: () {
                                        controller.deleteQRBank(item.id!);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.delete_outline_rounded,
                                      color: Colors.red,
                                    )),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            })),
        floatingActionButton: Obx(() {
          return AnimatedSlide(
            offset: controller.isFabVisible.value
                ? Offset.zero
                : const Offset(0, 2),
            duration: const Duration(milliseconds: 300),
            child: AnimatedOpacity(
              opacity: controller.isFabVisible.value ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              child: FloatingActionButton(
                  backgroundColor: primaryColor,
                  onPressed: () {
                    controller.clearFormBankQR();
                    _showAddBank(context);
                  },
                  child: Icon(Icons.add)),
            ),
          );
        }));
  }

  void _showAddBank(BuildContext context) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Center(
                      child: Text(
                    controller.eDitTingBankId == null ? 'ເພີ່ມ QR' : 'ແກ້ໄຂ QR',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )),
                  DropdownButtonFormField<Banklogo>(
                      decoration: const InputDecoration(
                        labelText: 'ເລືອກທະນາຄານ',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      value: controller.selectedBank.value,
                      items: controller.dropdownBank.map((item) {
                        return DropdownMenuItem<Banklogo>(
                          value: item,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(item.name!),
                              Image.network(
                                '$apiUrl/upload/bank/${item.bankimg}',
                                width: 24,
                                height: 24,
                              )
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        if (newValue != null) {
                          controller.selectedBank.value = newValue;
                        }
                      }),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: controller.accountNumberController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'ກະລຸນາໃສ່ເລກບັນຊີທະນາຄານ';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'ເລກບັນຊີທະນາຄານ',
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: controller.accountNameController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'ກະລູນາໃສ່ຊື່ບັນຊີທະນາຄານ';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'ຊື່ບັນຊີທະນາຄານ',
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      // Upload Area
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                            onTap: () {
                              controller.pickImage();
                            },
                            child: controller.isLoadingImage.value == false
                                ? DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(8),
                                    dashPattern: [8, 4],
                                    strokeWidth: 1,
                                    color: Colors.blue,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        controller.imageFile.value != null
                                            ? IconButton(
                                                onPressed: () {
                                                  controller.imageFile.value =
                                                      null;
                                                },
                                                icon: Icon(
                                                  Icons.close_rounded,
                                                  color: Colors.red,
                                                  size: 25,
                                                ))
                                            : SizedBox.shrink(),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          width: double.infinity,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              if (controller.imageFile.value !=
                                                  null)
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.file(
                                                    controller.imageFile.value!,
                                                    width: 250,
                                                    // height: 150,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              else if (controller
                                                      .existingBankQR.value !=
                                                  null)
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        '$apiUrl/upload/bank/${controller.existingBankQR.value}',
                                                    width: 250,
                                                    // height: 150,
                                                    fit: BoxFit.cover,
                                                    errorListener: (value) =>
                                                        Icon(
                                                      Icons
                                                          .image_not_supported_outlined,
                                                      size: 40,
                                                      color: Colors.grey,
                                                    ),
                                                    filterQuality:
                                                        FilterQuality.low,
                                                  ),
                                                )
                                              else
                                                Column(
                                                  children: [
                                                    Icon(
                                                      Icons.image,
                                                      size: 40,
                                                      color: Colors.blue,
                                                    ),
                                                    SizedBox(height: 8),
                                                    Text(
                                                      'ເພີ່ມ QR',
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )
                                                  ],
                                                )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Center(
                                    child: CircularProgressIndicator(
                                        color: primaryColor))),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  buildCustomButton(
                      onPressed: () {
                        showDialogSuccess(
                          controller.eDitTingBankId == null
                              ? 'ເພີ່ມ QR Code'
                              : 'ແກ້ໄຂ QR Code',
                          controller.eDitTingBankId == null
                              ? 'ທ່ານແນ່ໃຈທີ່ຈະເພີ່ມ QR Code ບໍ?'
                              : 'ທ່ານແນ່ໃຈທີ່ແກ້ໄຂ QR Code ບໍ?',
                          context,
                          showCancelBtn: true,
                          btnCancel: 'ຍົກເລີກ',
                          onCancel: () {
                            Get.back();
                          },
                          showConfirmBtn: true,
                          btnConfirm: 'ຢືນຢັນ',
                          onConfirm: () {
                            controller.onSavedBankQRPressed();
                          },
                        );
                      },
                      text: controller.eDitTingBankId == null
                          ? 'ເພີ່ມຂໍ້ມູນ'
                          : 'ແກ້ໄຂຂໍ້ມູນ',
                      textStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
            )),
      ),
    );
  }
}
