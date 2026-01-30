import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/widgets/customButton.dart';
import 'package:e_commerce/core/widgets/show_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget checkStatusButton({
  required int statusId,
  required bool isShop,
  required Function(int) onUpdateStatus,
  required VoidCallback onGoToPayment,
  Function(int)? onConfirmReceive,
  TextEditingController? controller,
}) {
  var context = Get.context!;
  if (isShop) {
    switch (statusId) {
      case 1:
        return Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                  child: buildCustomButton(
                      text: 'ຍົກເລີກອໍເດີ້',
                      textStyle: TextStyle(fontWeight: FontWeight.bold),
                      backgroundColor: Colors.red,
                      onPressed: () {
                        showDialogQuestion(
                          'ຍົກເລີກອໍເດີ້',
                          // 'ທ່ານຕ້ອງການຍົກເລີກອໍເດີ້ບໍ?',
                          'ເຫດຜົນທີ່ຍົກເລີກ',
                          context,
                          textAlignment: TextAlign.start,
                          widget: TextField(
                            controller: controller,
                            onTapOutside: (event) =>
                                FocusScope.of(context).unfocus(),
                            decoration: InputDecoration(
                                hintText: 'ເຫດຜົນທີ່ຍົກເລີກ',
                                border: OutlineInputBorder()),
                          ),

                          btnConfirm: 'ຢືນຢັນ',
                          btnCancel: 'ຍົກເລີກ',
                          onCancel: () {
                            Get.back();
                          },
                          onConfirm: () {
                            Get.back();
                            onUpdateStatus(2);
                          },
                        );
                      })),
              SizedBox(width: 16),
              Expanded(
                  child: buildCustomButton(
                      text: 'ຮັບອໍເດີ້',
                      textStyle: TextStyle(fontWeight: FontWeight.bold),
                      backgroundColor: primaryColor,
                      onPressed: () {
                        showDialogQuestion(
                          'ຮັບອໍເດີ້?',
                          'ທ່ານແນ່ໃຈທີ່ຈະຮັບອໍເດີ້ບໍ?',
                          context,
                          btnConfirm: 'ຢືນຢັນ',
                          btnCancel: 'ຍົກເລີກ',
                          onCancel: () {
                            Get.back();
                          },
                          onConfirm: () {
                            Get.back();
                            onUpdateStatus(3);
                          },
                        );
                      }))
            ],
          ),
        );
      case 4:
        return Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: buildCustomButton(
                    text: 'ຍົກເລີກອໍເດີ້',
                    textStyle: TextStyle(fontWeight: FontWeight.bold),
                    backgroundColor: Colors.red.withOpacity(0.8),
                    onPressed: () {
                      showDialogQuestion(
                        'ຍົກເລີກ',
                        // 'ທ່ານຕ້ອງການຍົກເລີກອໍເດີ້ບໍ?',
                        'ເຫດຜົນທີ່ຍົກເລີກ',
                        context,

                        textAlignment: TextAlign.start,
                        widget: TextField(
                          controller: controller,
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                        ),
                        btnConfirm: 'ຢືນຢັນ',
                        btnCancel: 'ຍົກເລີກ',
                        onCancel: () {
                          Get.back();
                        },
                        onConfirm: () {
                          Get.back();
                          onUpdateStatus(2);
                        },
                      );
                    }),
              ),
              SizedBox(width: 16),
              Expanded(
                child: buildCustomButton(
                    text: 'ຢືນຢັນການຊຳລະ',
                    backgroundColor: primaryColor,
                    textStyle: TextStyle(fontWeight: FontWeight.bold),
                    onPressed: () => showDialogQuestion(
                          'ກວດສອບຢືນຢັນຊຳລະເງິນ',
                          'ການຊຳລະເງິນຖືກຕ້ອງແລ້ວບໍ?',
                          context,
                          btnConfirm: 'ຢືນຢັນ',
                          btnCancel: 'ຍົກເລີກ',
                          onCancel: () {
                            Get.back();
                          },
                          onConfirm: () {
                            Get.back();
                            onUpdateStatus(5);
                          },
                        )),
              ),
            ],
          ),
        );
      case 5:
        return Container(
          padding: const EdgeInsets.all(10),
          child: buildCustomButton(
              text: 'ສົ່ງສິນຄ້າ',
              textStyle: TextStyle(fontWeight: FontWeight.bold),
              onPressed: () => showDialogQuestion(
                    'ສົ່ງສິນຄ້າ',
                    'ທ່ານແນ່ໃຈທີ່ຈະສົ່ງສິນຄ້າບໍ?',
                    context,
                    btnConfirm: 'ຢືນຢັນ',
                    btnCancel: 'ຍົກເລີກ',
                    onCancel: () {
                      Get.back();
                    },
                    onConfirm: () {
                      Get.back();
                      onUpdateStatus(6);
                    },
                  )),
        );
      default:
        return SizedBox.shrink();
    }
  } else {
    switch (statusId) {
      case 1:
        return Container(
          padding: const EdgeInsets.all(10),
          child: buildCustomButton(
              text: 'ຍົກເລີກ',
              textStyle: TextStyle(fontWeight: FontWeight.bold),
              backgroundColor: Colors.red,
              onPressed: () {
                showDialogSuccess(
                  'ຍົກເລີກ',
                  'ທ່ານຕ້ອງການຍົກເລີກອໍເດີ້ບໍ?',
                  context,
                  showCancelBtn: true,
                  showConfirmBtn: true,
                  btnConfirm: 'ຢືນຢັນ',
                  btnCancel: 'ຍົກເລີກ',
                  onCancel: () {
                    Get.back();
                  },
                  onConfirm: () {
                    Get.back();
                    onUpdateStatus(2);
                  },
                );
              }),
        );
      case 3:
        return Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              buildCustomButton(
                  text: 'ຊຳລະເງິນ',
                  textStyle: TextStyle(fontWeight: FontWeight.bold),
                  onPressed: () => showDialogSuccess(
                        'ການຊຳລະ',
                        'ທ່ານແນ່ໃຈທີ່ຈະຊຳລະບໍ?',
                        context,
                        showCancelBtn: true,
                        showConfirmBtn: true,
                        btnConfirm: 'ຢືນຢັນ',
                        btnCancel: 'ຍົກເລີກ',
                        onCancel: () {
                          Get.back();
                        },
                        onConfirm: () {
                          onGoToPayment;
                        },
                      )),
              SizedBox(height: 10),
              buildCustomButton(
                  text: 'ຍົກເລີກອໍເດີ້',
                  textStyle: TextStyle(fontWeight: FontWeight.bold),
                  backgroundColor: Colors.red.withOpacity(0.8),
                  onPressed: () {
                    showDialogSuccess(
                      'ຍົກເລີກ',
                      'ທ່ານຕ້ອງການຍົກເລີກອໍເດີ້ບໍ?',
                      context,
                      showCancelBtn: true,
                      showConfirmBtn: true,
                      btnConfirm: 'ຢືນຢັນ',
                      btnCancel: 'ຍົກເລີກ',
                      onCancel: () {
                        Get.back();
                      },
                      onConfirm: () {
                        Get.back();
                        onUpdateStatus(2);
                      },
                    );
                  })
            ],
          ),
        );
      case 6:
        return Container(
          padding: const EdgeInsets.all(10),
          child: buildCustomButton(
              text: 'ຮັບສິນຄ້າ',
              textStyle: TextStyle(fontWeight: FontWeight.bold),
              backgroundColor: Colors.green,
              onPressed: () {
                showDialogQuestion(
                  'ຮັບສິນຄ້າ',
                  'ທ່ານໄດ້ຮັບສິນຄ້າແລ້ວບໍ?',
                  context,
                  btnCancel: 'ຍົກເລີກ',
                  btnConfirm: 'ໄດ້ຮັບແລ້ວ',
                  onConfirm: () {
                    Get.back();
                    onUpdateStatus(7);
                  },
                );
              }),
        );
      default:
        return SizedBox.shrink();
    }
  }

  // return SizedBox(
  //   height: Get.height * 0.07,
  //   child: buildCustomButton(
  //       onPressed: onPressed,
  //       text: btnText,
  //       textStyle: TextStyle(
  //           fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
  // );
}
