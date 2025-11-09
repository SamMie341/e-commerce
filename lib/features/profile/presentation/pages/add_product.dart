import 'package:dotted_border/dotted_border.dart';
import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/widgets/appbar_widget.dart';
import 'package:e_commerce/features/payment/data/models/add_product.dart';
import 'package:e_commerce/features/profile/presentation/controller/add_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final controller = Get.find<DropdownController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: buildAppBarCustom(context, 'ເພີ່ມສິນຄ້າ'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Obx(
                  () => controller.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            DropdownButtonFormField(
                                elevation: 5,
                                dropdownColor: Colors.white,
                                icon: Icon(Icons.keyboard_arrow_down_rounded),
                                decoration: InputDecoration(
                                  hintText: 'ເລືອກປະເພດສິນຄ້າ',
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        width: .5, color: Colors.grey.shade600),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        width: .5, color: Colors.grey.shade600),
                                  ),
                                ),
                                items: controller.categoryList.map((item) {
                                  return DropdownMenuItem(
                                    alignment: Alignment.center,
                                    value: item,
                                    child: Text(item.name),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    controller.selectedCat = value;
                                    controller.cateId = value?.id;
                                  });
                                }),
                            SizedBox(height: 10),
                            DropdownButtonFormField(
                                dropdownColor: Colors.white,
                                icon: Icon(Icons.keyboard_arrow_down_rounded),
                                decoration: InputDecoration(
                                  hintText: 'ເລືອກຫົວໜ່ວຍສິນຄ້າ',
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        width: .5, color: Colors.grey.shade600),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        width: .5, color: Colors.grey.shade600),
                                  ),
                                ),
                                items: controller.unitList.map((item) {
                                  return DropdownMenuItem(
                                    alignment: Alignment.center,
                                    value: item,
                                    child: Text(item.name),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    controller.selectedUnit = value;
                                    controller.unitId = value?.id;
                                  });
                                }),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: controller.productNameController,
                              onTapOutside: (event) {
                                FocusScope.of(context).unfocus();
                              },
                              cursorColor: Colors.grey.shade600,
                              decoration: InputDecoration(
                                hintText: 'ຊື່ສິນຄ້າ',
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade600),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      width: .5, color: Colors.grey.shade600),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      width: .5, color: Colors.grey.shade600),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: controller.detailProductController,
                              maxLines: 5,
                              cursorColor: Colors.grey.shade600,
                              decoration: InputDecoration(
                                hintText: 'ລາຍລະອຽດສິນຄ້າ',
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade600),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      width: .5, color: Colors.grey.shade600),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      width: .5, color: Colors.grey.shade600),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: controller.priceProductController,
                              cursorColor: Colors.grey.shade600,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'ລາຄາ',
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade600),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      width: .5, color: Colors.grey.shade600),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      width: .5, color: Colors.grey.shade600),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                // Upload Area
                                Expanded(
                                  flex: 2,
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.pickImage();
                                    },
                                    child: DottedBorder(
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(8),
                                      dashPattern: [8, 4],
                                      strokeWidth: 1,
                                      color: Colors.blue,
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            top: 20, bottom: 20),
                                        width: double.infinity,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            if (controller.imageFile.value ==
                                                null)
                                              Column(
                                                children: [
                                                  Icon(
                                                    Icons.image,
                                                    size: 40,
                                                    color: Colors.blue,
                                                  ),
                                                  SizedBox(height: 8),
                                                  Text(
                                                    'ເພີ່ມຮູບພາບສິນຄ້າ',
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            if (controller.imageFile.value !=
                                                null)
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.file(
                                                  controller.imageFile.value!,
                                                  width: 200,
                                                  height: 200,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            TextButton(
                                style: ButtonStyle(
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  backgroundColor: WidgetStatePropertyAll(
                                      HexColor('#537BEC')),
                                ),
                                onPressed: () {
                                  controller.addProduct(AddProductModel(
                                      categoryId: controller.cateId!,
                                      productunitId: controller.unitId!,
                                      title:
                                          controller.productNameController.text,
                                      detail: controller
                                          .detailProductController.text,
                                      price: num.tryParse(controller
                                              .priceProductController.text
                                              .toString()) ??
                                          0,
                                      pimg: controller.imageFile.value!));
                                },
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'ເພີ່ມສິນຄ້າ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
