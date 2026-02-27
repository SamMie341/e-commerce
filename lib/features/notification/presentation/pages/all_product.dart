import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:e_commerce/core/utils/constant.dart';
import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/utils/currency_input_formatter.dart';
import 'package:e_commerce/core/widgets/appbar_widget.dart';
import 'package:e_commerce/core/widgets/customButton.dart';
import 'package:e_commerce/features/home/data/models/product_model.dart';
import 'package:e_commerce/features/notification/presentation/controller/shop_product_controller.dart';
import 'package:e_commerce/features/notification/presentation/widget/card_product.dart';
import 'package:e_commerce/features/profile/domain/entities/profile_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AllProductPage extends StatefulWidget {
  const AllProductPage({super.key});

  @override
  State<AllProductPage> createState() => AllProductPageState();
}

class AllProductPageState extends State<AllProductPage> {
  final controller = Get.find<ShopProductController>();
  final FocusNode buttonFocusNode = FocusNode();

  @override
  void dispose() {
    buttonFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarCustom(context, 'ສິນຄ້າທັງໝົດ'),
      body: RefreshIndicator(
          onRefresh: () async {
            controller.fetchProduct();
          },
          color: primaryColor,
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(
                  child: CircularProgressIndicator(color: primaryColor));
            }
            if (controller.productList.isEmpty) {
              return Center(
                  child: const Text(
                'ບໍ່ມີສິນຄ້າ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ));
            }
            return Padding(
              padding: const EdgeInsets.only(
                left: 5,
                right: 5,
                top: 10,
                bottom: 10,
              ),
              child: GridView.builder(
                  controller: controller.scrollController,
                  shrinkWrap: true,
                  itemCount: controller.productList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1 / 1.50,
                    mainAxisExtent: 280,
                  ),
                  itemBuilder: (context, index) {
                    final item = controller.productList[index];
                    return GestureDetector(
                      onLongPress: () {
                        controller.setEditData(item);
                        _showEditProduct(context);
                      },
                      child: buildCardProduct(
                        item.pimg!,
                        item.title!,
                        item.detail!,
                        num.parse(item.price!),
                        controller.status(item.approved!),
                        item.approved!,
                        child: MenuAnchor(
                          childFocusNode: buttonFocusNode,
                          style: MenuStyle(
                              alignment: AlignmentGeometry.bottomLeft),
                          menuChildren: <Widget>[
                            MenuItemButton(
                                onPressed: () {
                                  controller.setEditData(item);
                                  _showEditProduct(context);
                                },
                                child: TextButton.icon(
                                  iconAlignment: IconAlignment.start,
                                  onPressed: null,
                                  label: Text(
                                    'ແກ້ໄຂ',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  icon: Icon(
                                    Icons.edit_outlined,
                                    color: Colors.black,
                                  ),
                                )),
                            // MenuItemButton(
                            //     onPressed: () {
                            //       showDialogSuccess(
                            //         'ລົບສິນຄ້າ',
                            //         'ທ່ານຈະສືບຕໍ່ລົບສິນຄ້າບໍ?',
                            //         showConfirmBtn: true,
                            //         showCancelBtn: true,
                            //         context,
                            //         btnCancel: 'ຍົກເລີກ',
                            //         onCancel: () => Get.back(),
                            //         btnConfirm: 'ຢືນຢັນ',
                            //         onConfirm: () => {
                            //           controller.deleteProduct(item.id!),
                            //         },
                            //       );
                            //     },
                            //     child: TextButton.icon(
                            //       iconAlignment: IconAlignment.start,
                            //       onPressed: null,
                            //       label: Text(
                            //         'ລຶບ',
                            //         style: TextStyle(color: Colors.red),
                            //       ),
                            //       icon: Icon(
                            //         Icons.delete_forever_outlined,
                            //         color: Colors.red,
                            //       ),
                            //     ))
                          ],
                          builder:
                              (_, MenuController controllers, Widget? child) {
                            return IconButton(
                                focusNode: buttonFocusNode,
                                onPressed: () {
                                  if (controllers.isOpen) {
                                    controllers.close();
                                  } else {
                                    controllers.open();
                                  }
                                },
                                icon: Icon(
                                  Icons.more_vert,
                                  color: Colors.black,
                                ));
                          },
                        ),
                      ),
                    );
                  }),
            );
          })),
      floatingActionButton: Obx(() {
        return AnimatedSlide(
          duration: Duration(milliseconds: 300),
          offset:
              controller.isFabVisible.value ? Offset.zero : const Offset(0, 2),
          child: AnimatedOpacity(
            opacity: controller.isFabVisible.value ? 1 : 0,
            duration: const Duration(milliseconds: 300),
            child: FloatingActionButton(
              onPressed: () {
                controller.clearFormProduct();
                _showEditProduct(context);
              },
              backgroundColor: primaryColor,
              child: Icon(Icons.add_outlined),
            ),
          ),
        );
      }),
    );
  }

  void _showEditProduct(BuildContext context) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: Obx(() => Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: AlignmentGeometry.center,
                        child: Text(
                          controller.eDitTingProductId == null
                              ? 'ເພີ່ມສິນຄ້າ'
                              : 'ແກ້ໄຂສິນຄ້າ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: primaryColor),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.red,
                            )),
                      )
                    ],
                  ),
                  DropdownButtonFormField<CategoryModel>(
                      validator: (value) {
                        if (value == null) {
                          return 'ກະລຸນາເລືອກປະເພດສິນຄ້າສິນຄ້າ';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'ປະເພດສິນຄ້າ',
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
                      value: controller.selectedCat.value,
                      items: controller.categoryList.map((cat) {
                        return DropdownMenuItem<CategoryModel>(
                          value: cat,
                          child: Text(cat.name),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        if (newValue != null) {
                          controller.selectedCat.value = newValue;
                        }
                      }),
                  SizedBox(height: 20),
                  DropdownButtonFormField<UnitModel>(
                      validator: (value) {
                        if (value == null) {
                          return 'ກະລຸນາເລືອກຫົວໜ່ວຍສິນຄ້າ';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'ຫົວໜ່ວຍສິນຄ້າ',
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
                      value: controller.selectedUnit.value,
                      items: controller.unitList.map((unit) {
                        return DropdownMenuItem<UnitModel>(
                          value: unit,
                          child: Text(unit.name),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        if (newValue != null) {
                          controller.selectedUnit.value = newValue;
                        }
                      }),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'ກະລຸນາໃສ່ຊື່ສິນຄ້າ';
                      }
                      return null;
                    },
                    controller: controller.productNameController,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    decoration: InputDecoration(
                      labelText: 'ຊື່ສິນຄ້າ',
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'ກະລຸນາໃສ່ລາຍລະອຽດສິນຄ້າ';
                      }
                      return null;
                    },
                    controller: controller.detailProductController,
                    maxLength: 200,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'ລາຍລະອຽດ',
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'ກະລຸນາໃສ່ລາຄາສິນຄ້າ';
                      }
                      return null;
                    },
                    controller: controller.priceProductController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CurrencyInputFormatter(),
                    ],
                    decoration: InputDecoration(
                      labelText: 'ລາຄາ',
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
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
                                          padding:
                                              const EdgeInsets.only(bottom: 0),
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
                                                    // height: 350,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              else if (controller
                                                      .existingImageUrl.value !=
                                                  null)
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        '$apiProductUrl/${controller.existingImageUrl.value}',
                                                    width: 250,
                                                    // height: 350,
                                                    fit: BoxFit.cover,
                                                    errorListener: (value) =>
                                                        Icon(
                                                      Icons
                                                          .image_not_supported_outlined,
                                                      size: 40,
                                                      color: Colors.grey,
                                                    ),
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
                                                      'ເພີ່ມຮູບສິນຄ້າ',
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
                                        color: primaryColor),
                                  )),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  buildCustomButton(
                      onPressed: () {
                        controller.onSavedProduct();
                      },
                      text: controller.eDitTingProductId == null
                          ? 'ເພີ່ມສິນຄ້າ'
                          : 'ຢືນຢັນການແກ້ໄຂ',
                      textStyle: TextStyle(fontSize: 16))
                ],
              )),
        ),
      ),
    );
  }
}
