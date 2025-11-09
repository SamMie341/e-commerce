import 'dart:io';

import 'package:e_commerce/core/widgets/show_alert.dart';
import 'package:e_commerce/features/home/data/models/product_model.dart';
import 'package:e_commerce/features/payment/data/models/add_product.dart';
import 'package:e_commerce/features/profile/domain/entities/profile_entity.dart';
import 'package:e_commerce/features/profile/domain/usecases/add_product_usecase.dart';
import 'package:e_commerce/features/profile/domain/usecases/dropdown_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DropdownController extends GetxController {
  final DropdownUseCase dropdownUseCase;
  final AddProductUseCase addProductUseCase;

  DropdownController(this.dropdownUseCase, this.addProductUseCase);

  final RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  final RxList<UnitModel> unitList = <UnitModel>[].obs;

  CategoryModel? selectedCat;
  UnitModel? selectedUnit;

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController detailProductController = TextEditingController();
  final TextEditingController priceProductController = TextEditingController();

  final isLoading = false.obs;

  final Rx<ImagePicker> picker = ImagePicker().obs;
  var imageFile = Rx<File?>(null);

  int? cateId;
  int? unitId;

  @override
  void onInit() {
    super.onInit();
    fetchCategory();
    fetchUnit();
  }

  Future<void> pickImage() async {
    final XFile? pickedFile =
        await picker.value.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  Future<void> fetchCategory() async {
    isLoading.value = true;
    try {
      final result = await dropdownUseCase.category();
      categoryList.value = result;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchUnit() async {
    isLoading.value = true;

    try {
      final result = await dropdownUseCase.unit();
      unitList.value = result;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addProduct(AddProductModel data) async {
    try {
      isLoading.value = true;
      await addProductUseCase(data);
      showDialogSuccess('ສຳເລັດ', 'ເພີ່ມສິນຄ້າສຳເລັດ');
      clearData();
    } catch (e) {
      showDialogError('ຜິດພາດ', '', Duration(seconds: 5));
    } finally {
      isLoading.value = false;
    }
  }

  void clearData() {
    productNameController.clear();
    detailProductController.clear();
    priceProductController.clear();
    imageFile.value = null;
  }
}
