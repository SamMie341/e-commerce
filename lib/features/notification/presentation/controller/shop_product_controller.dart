import 'dart:io';

import 'package:e_commerce/core/widgets/show_alert.dart';
import 'package:e_commerce/features/home/data/models/product_model.dart';
import 'package:e_commerce/features/notification/data/model/bank_model.dart';
import 'package:e_commerce/features/notification/data/model/shop_model.dart';
import 'package:e_commerce/features/notification/domain/usecase/add_bank_qr_usecase.dart';
import 'package:e_commerce/features/notification/domain/usecase/add_product_usecase.dart';
import 'package:e_commerce/features/notification/domain/usecase/delete_product_usecase.dart';
import 'package:e_commerce/features/notification/domain/usecase/delete_qr_bank_usecase.dart';
import 'package:e_commerce/features/notification/domain/usecase/get_bank_qr_usecase.dart';
import 'package:e_commerce/features/notification/domain/usecase/get_dropdown_bank_usecase.dart';
import 'package:e_commerce/features/notification/domain/usecase/get_dropdown_usecase.dart';
import 'package:e_commerce/features/notification/domain/usecase/get_product_by_shop_usecase.dart';
import 'package:e_commerce/features/notification/domain/usecase/update_bank_qr_usecase.dart';
import 'package:e_commerce/features/notification/domain/usecase/update_product_usecase.dart';
import 'package:e_commerce/features/notification/data/model/add_product_model.dart';
import 'package:e_commerce/features/profile/domain/entities/profile_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ShopProductController extends GetxController {
  final GetProductByShopUseCase usecase;
  final GetDropdownUseCase dropdownUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final GetBankQrUseCase bankQrUseCase;
  final GetDropdownBankUseCase getDropdownBankUseCase;
  final AddBankQrUseCase addBankQrUseCase;
  final UpdateBankQrUseCase updateBankQrUseCase;
  final DeleteQrBankUseCase deleteQrBankUseCase;
  final AddProductUseCase addProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;

  ShopProductController(
    this.usecase,
    this.dropdownUseCase,
    this.updateProductUseCase,
    this.bankQrUseCase,
    this.getDropdownBankUseCase,
    this.addBankQrUseCase,
    this.updateBankQrUseCase,
    this.deleteQrBankUseCase,
    this.addProductUseCase,
    this.deleteProductUseCase,
  );

  final RxList<ShopModel> productList = <ShopModel>[].obs;
  final RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  final RxList<UnitModel> unitList = <UnitModel>[].obs;
  final RxList<BankModel> bankList = <BankModel>[].obs;
  final RxList<Banklogo> dropdownBank = <Banklogo>[].obs;

  int? eDitTingProductId;
  int? eDitTingBankId;

  final existingImageUrl = Rxn<String>();
  final existingBankQR = Rxn<String>();
  final isLoading = false.obs;
  final isLoadingImage = false.obs;

  final Rx<ImagePicker> picker = ImagePicker().obs;
  var imageFile = Rx<File?>(null);

  Rxn<CategoryModel> selectedCat = Rxn<CategoryModel>();
  Rxn<UnitModel> selectedUnit = Rxn<UnitModel>();
  Rxn<Banklogo> selectedBank = Rxn<Banklogo>();

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController detailProductController = TextEditingController();
  final TextEditingController priceProductController = TextEditingController();

  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController accountNameController = TextEditingController();

  var context = Get.context!;

  final scrollController = ScrollController();
  var isFabVisible = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProduct();
    _fetchCategory();
    _fetchUnit();
    _fetchBankQR();
    _fetchDropdownBank();

    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (isFabVisible.value) {
          isFabVisible.value = false;
        }
      } else if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!isFabVisible.value) {
          isFabVisible.value = true;
        }
      }
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> pickImage() async {
    if (Get.context == null) return;

    try {
      final List<AssetEntity>? result = await AssetPicker.pickAssets(
        Get.context!,
        pickerConfig: const AssetPickerConfig(
          maxAssets: 1,
          requestType: RequestType.image,
          textDelegate: EnglishAssetPickerTextDelegate(),
        ),
      );

      if (result != null && result.isNotEmpty) {
        final File? file = await result.first.file;

        if (file != null) {
          imageFile.value = file;
        }
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  // Future<void> pickImageProduct() async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? image = await picker.pickImage(source: ImageSource.gallery);

  //   if (image != null) {
  //     CroppedFile? croppedFile = await ImageCropper().cropImage(
  //         sourcePath: image.path,
  //         aspectRatio: CropAspectRatio(ratioX: 5, ratioY: 4),
  //         uiSettings: [
  //           AndroidUiSettings(
  //             // toolbarTitle: 'ຕັດຮູບພາບຕາມຄວາມເໝາະສົມ',
  //             toolbarColor: primaryColor,
  //             toolbarWidgetColor: Colors.white,
  //             // initAspectRatio: CropAspectRatioPreset.ratio3x2,
  //             lockAspectRatio: true,
  //             hideBottomControls: true,
  //             // cropStyle: CropStyle.rectangle,
  //             // aspectRatioPresets: [
  //             //   CropAspectRatioPreset.square,
  //             // ],
  //           ),
  //           IOSUiSettings(title: 'ຕັດຮູບພາບຕາມຄວາມເໝາະສົມ')
  //         ]);
  //     if (croppedFile != null) {
  //       imageFile.value = File(croppedFile.path);
  //       update();
  //     }
  //   }
  // }

  void onSavedProduct() async {
    if (selectedCat.value == null) {
      showDialogError(
          'ຜິດພາດ',
          'ກະລຸນາເລືອກປະເພດສິນຄ້າ',
          duration: const Duration(seconds: 3),
          context);
      return;
    }
    if (selectedUnit.value == null) {
      showDialogError(
          'ຜິດພາດ',
          'ກະລຸນາເລືອກຫົວໜ່ວຍສິນຄ້າ',
          duration: const Duration(seconds: 3),
          context);
      return;
    }
    if (productNameController.text.isEmpty) {
      showDialogError(
          'ຜິດພາດ',
          'ກະລຸນາໃສ່ຊື່ສິນຄ້າ',
          duration: const Duration(seconds: 3),
          context);
      return;
    }
    if (detailProductController.text.isEmpty) {
      showDialogError(
          'ຜິດພາດ',
          'ກະລຸນາໃສ່ລາຍລະອຽດສິນຄ້າ',
          duration: const Duration(seconds: 3),
          context);
      return;
    }
    if (priceProductController.text.isEmpty) {
      showDialogError(
          'ຜິດພາດ',
          'ກະລຸນາໃສ່ລາຄາສິນຄ້າ',
          duration: const Duration(seconds: 3),
          context);
      return;
    }
    if (eDitTingProductId == null) {
      if (imageFile.value == null) {
        showDialogError(
            'ຜິດພາດ',
            'ກະລຸນາເພີ່ມຮູບພາບສິນຄ້າ',
            duration: const Duration(seconds: 3),
            context);
        return;
      }
      showDialogSuccess(
        eDitTingProductId == null ? 'ເພີ່ມສິນຄ້າ' : 'ແກ້ໄຂສິນຄ້າ',
        eDitTingProductId == null
            ? 'ທ່ານແນ່ໃຈທີ່ຈະເພີ່ມສິນຄ້າບໍ?'
            : 'ທ່ານແນ່ໃຈທີ່ແກ້ໄຂສິນຄ້າບໍ?',
        context,
        showCancelBtn: true,
        btnCancel: 'ຍົກເລີກ',
        onCancel: () {
          Get.back();
        },
        showConfirmBtn: true,
        btnConfirm: 'ຢືນຢັນ',
        onConfirm: () {
          Get.back();
          addProduct();
        },
      );
    } else {
      showDialogSuccess(
        eDitTingProductId == null ? 'ເພີ່ມສິນຄ້າ' : 'ແກ້ໄຂສິນຄ້າ',
        eDitTingProductId == null
            ? 'ທ່ານແນ່ໃຈທີ່ຈະເພີ່ມສິນຄ້າບໍ?'
            : 'ທ່ານແນ່ໃຈທີ່ແກ້ໄຂສິນຄ້າບໍ?',
        context,
        showCancelBtn: true,
        btnCancel: 'ຍົກເລີກ',
        onCancel: () {
          Get.back();
        },
        showConfirmBtn: true,
        btnConfirm: 'ຢືນຢັນ',
        onConfirm: () {
          Get.back();
          updateProduct();
        },
      );
    }
  }

  Future<void> addProduct() async {
    try {
      print('${selectedCat.value!.id}, ${selectedUnit.value!.id}');
      final data = AddProductModel(
        categoryId: selectedCat.value!.id,
        productunitId: selectedUnit.value!.id,
        title: productNameController.text,
        detail: detailProductController.text,
        price: num.parse(priceProductController.text.replaceAll(',', '')),
        pimg: imageFile.value,
      );

      final result = await addProductUseCase(data);
      result.fold((failure) => Get.snackbar('Error', failure.message),
          (success) {
        clearFormProduct();
        Get.back();
        showDialogSuccess('ສຳເລັດ', 'Success', context, btnConfirm: 'ຕົກລົງ');
        fetchProduct();
      });
    } finally {
      isLoading(false);
    }
  }

  void onSavedBankQRPressed() async {
    if (selectedBank.value == null) {
      showDialogError(
          'ຜິດພາດ',
          'ກະລຸນາເລືອກທະນາຄານ',
          duration: const Duration(seconds: 3),
          context);
      return;
    }
    if (accountNumberController.text.isEmpty) {
      showDialogError(
          'ຜິດພາດ',
          'ກະລຸນາປ້ອນເລກບັນຊີ',
          duration: const Duration(seconds: 3),
          context);
      return;
    }
    if (accountNameController.text.isEmpty) {
      showDialogError(
          'ຜິດພາດ',
          'ກະລຸນາປ້ອນຊື່ບັນຊີ',
          duration: const Duration(seconds: 3),
          context);
      return;
    }

    if (eDitTingBankId == null) {
      if (imageFile.value == null) {
        showDialogError(
            'ຜິດພາດ',
            'ກະລຸນາເລືອກຮູບ QR',
            duration: const Duration(seconds: 3),
            context);
        return;
      }
      addBankQR();
    } else {
      updateBankQR();
    }
  }

  Future<void> addBankQR() async {
    if (imageFile.value == null) {
      showDialogError(
          'Error',
          'Please select a QR image.',
          duration: const Duration(seconds: 5),
          context);
      return;
    }

    isLoading(true);
    try {
      final qrData = AddQRModel(
        banklogoId: selectedBank.value!.id,
        accountNo: accountNumberController.text,
        accountName: accountNameController.text,
        bankqr: imageFile.value!,
      );

      final result = await addBankQrUseCase(qrData);
      result.fold((failure) {
        showDialogError(
            'ຜິດພາດ',
            failure.message,
            duration: const Duration(seconds: 5),
            context);
      }, (success) {
        clearFormBankQR();
        Get.back();
        showDialogSuccess('ສຳເລັດ', 'ເພີ່ມ Bank QR ສຳເລັດ', context);
        _fetchBankQR();
      });
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateBankQR() async {
    if (eDitTingBankId == null) {
      Get.snackbar('Error to update Bank QR', 'No bank selected');
    }
    isLoading(true);
    try {
      final qrData = AddQRModel(
        banklogoId: selectedBank.value?.id,
        accountNo: accountNumberController.text,
        accountName: accountNameController.text,
        bankqr: imageFile.value,
      );
      final result = await updateBankQrUseCase(qrData, eDitTingBankId!);
      result.fold(
          (failure) => showDialogError(
              'Error',
              failure.message,
              duration: Duration(seconds: 5),
              context), (success) {
        clearFormBankQR();
        Get.back();
        _fetchBankQR();
      });
    } finally {
      isLoading(false);
    }
  }

  void fetchProduct() async {
    isLoading(true);
    try {
      final result = await usecase();
      result.fold((failure) {
        // Get.snackbar('Error Fetch Product', failure.message);
        isLoading(false);
      }, (stream) {
        productList.value = stream.map((p) => p).toList();
      });
    } catch (e) {
      // Get.snackbar('error all Products', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> _fetchCategory() async {
    final result = await dropdownUseCase.callCategory();
    result.fold((failure) => Get.snackbar('Error', failure.message),
        (cat) => categoryList.value = cat.map((c) => c).toList());

    if (categoryList.isNotEmpty) {
      selectedCat.value = categoryList.first;
    }
  }

  Future<void> _fetchUnit() async {
    final result = await dropdownUseCase.callUnit();
    result.fold((failure) => Get.snackbar('Error Unit', failure.message),
        (unit) => unitList.value = unit.map((u) => u).toList());
    if (unitList.isNotEmpty) {
      selectedUnit.value = unitList.first;
    }
  }

  Future<void> _fetchDropdownBank() async {
    isLoading(true);
    try {
      final result = await getDropdownBankUseCase();
      result.fold(
          (failure) => Get.snackbar('Error dropdown bank', failure.message),
          (bank) => dropdownBank.value = bank.map((i) => i).toList());
      if (dropdownBank.isNotEmpty) {
        selectedBank.value = dropdownBank.first;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> _fetchBankQR() async {
    final result = await bankQrUseCase();
    result.fold(
        (failure) => null, (b) => bankList.value = b.map((qr) => qr).toList());
  }

  void setEditData(ShopModel item) async {
    eDitTingProductId = item.id;
    if (eDitTingProductId == null) {
      showDialogError(
          'Error',
          'Product ID is missing. Cannot edit.',
          duration: const Duration(seconds: 3),
          context);
      return;
    }
    if (item.categoryId != null && categoryList.isNotEmpty) {
      selectedCat.value = categoryList
          .firstWhereOrNull((element) => element.id == item.categoryId);
    }

    if (item.productunitId != null && unitList.isNotEmpty) {
      selectedUnit.value = unitList
          .firstWhereOrNull((element) => element.id == item.productunitId);
    }
    final formatter = NumberFormat('#,###', 'en_EN');
    productNameController.text = item.title ?? '';
    detailProductController.text = item.detail ?? '';
    priceProductController.text =
        formatter.format(num.parse(item.price.toString()));
    imageFile.value = null;
    existingImageUrl.value = item.pimg;
  }

  void setEditDataQR(BankModel item) async {
    eDitTingBankId = item.id;
    accountNumberController.text = item.accountNo ?? '';
    accountNameController.text = item.accountName ?? '';
    imageFile.value = null;
    existingBankQR.value = item.bankqr;

    if (item.banklogoId != null && dropdownBank.isNotEmpty) {
      selectedBank.value =
          dropdownBank.firstWhereOrNull((e) => e.id == item.banklogoId);
    }
  }

  Future<void> updateProduct() async {
    if (eDitTingProductId == null) {
      Get.snackbar('Error to update', 'No Product selected for editting');
      return;
    }
    isLoading(true);
    try {
      final productData = AddProductModel(
        categoryId: selectedCat.value?.id,
        productunitId: selectedUnit.value?.id,
        title: productNameController.text,
        detail: detailProductController.text,
        price: num.tryParse(priceProductController.text.replaceAll(',', '')),
        pimg: imageFile.value,
      );

      final result =
          await updateProductUseCase(productData, eDitTingProductId!);
      result.fold((failure) {
        // Get.snackbar('Error', failure.message);
      }, (r) {
        clearFormProduct();
        Get.back();
        Get.snackbar('ສຳເລັດ', 'ແກ້ໄຂສິນຄ້າສຳເລັດ');
        fetchProduct();
      });
    } finally {
      isLoading(false);
    }
  }

  void deleteProduct(int id) async {
    isLoading(true);
    try {
      final result = await deleteProductUseCase(id);
      result.fold(
          (failure) => showDialogError(
              'ຜິດພາດ',
              failure.message,
              duration: const Duration(seconds: 5),
              context), (success) {
        Get.back();
        fetchProduct();
        showDialogSuccess('ສຳເລັດ', 'ລົບສິນຄ້າສຳເລັດ', context,
            onConfirm: () => Get.back(), btnConfirm: 'ກັບຄືນ');
      });
    } finally {
      isLoading(false);
    }
  }

  void deleteQRBank(int id) async {
    isLoading(true);
    try {
      final result = await deleteQrBankUseCase(id);
      result.fold(
          (failure) => showDialogError(
              'ຜິດພາດ',
              failure.message,
              duration: const Duration(seconds: 5),
              context), (success) {
        _fetchBankQR();
        Get.back();
        showDialogSuccess('ສຳເລັດ', 'ລົບ QR Code ແລ້ວ', context);
      });
    } finally {
      isLoading(false);
    }
  }

  void clearFormBankQR() {
    eDitTingBankId = null;
    accountNumberController.clear();
    accountNameController.clear();
    imageFile.value = null;
    existingBankQR.value = null;
  }

  void clearFormProduct() {
    eDitTingProductId = null;
    selectedCat.value = null;
    selectedUnit.value = null;
    productNameController.clear();
    detailProductController.clear();
    priceProductController.clear();
    imageFile.value = null;
    existingImageUrl.value = null;
  }

  String status(num st) {
    if (st == 1) {
      return 'ລໍຖ້າອະນຸມັດ';
    }
    if (st == 2) {
      return 'ອະນຸມັດແລ້ວ';
    }
    if (st == 3) {
      return 'ປະຕິເສດ';
    }
    return '';
  }
}
