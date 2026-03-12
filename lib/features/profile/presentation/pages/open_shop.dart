// import 'dart:ui';

// import 'package:e_commerce/core/utils/convert_color.dart';
// import 'package:e_commerce/core/widgets/appbar_widget.dart';
// import 'package:e_commerce/features/profile/presentation/controller/profile_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class OpenShop extends GetView<ProfileController> {
//   const OpenShop({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: buildAppBarCustom(context, 'ເປີດຮ້ານຄ້າ'),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(width: 0),
//               color: Colors.white),
//           padding: const EdgeInsets.all(15),
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
//             child: Form(
//               key: controller.formKey,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextFormField(
//                     controller: controller.nameController,
//                     validator: (value) {
//                       if (value == null || value.trim().isEmpty) {
//                         return 'ກະລຸນາໃສ່ຊື່ຮ້ານ';
//                       }
//                       return null;
//                     },
//                     onTapUpOutside: (event) {
//                       FocusScope.of(context).unfocus();
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'ຊື່ຮ້ານຄ້າ',
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10)),
//                     ),
//                   ),
//                   SizedBox(height: 12),
//                   TextFormField(
//                     controller: controller.telController,
//                     validator: (value) {
//                       if (value == null || value.trim().isEmpty) {
//                         return 'ກະລຸນາໃສ່ເບີໂທ';
//                       }
//                       return null;
//                     },
//                     onTapUpOutside: (event) {
//                       FocusScope.of(context).unfocus();
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'ເບີໂທ',
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10)),
//                     ),
//                   ),
//                   SizedBox(height: 15),
//                   ElevatedButton(
//                       // style: ,
//                       onPressed: () {
//                         if (controller.formKey.currentState!.validate()) {
//                           controller.requestShop(controller.nameController.text,
//                               controller.telController.text);
//                         }
//                       },
//                       child: Text(
//                         'ສົ່ງຄຳຂໍເປີດຮ້ານຄ້າ',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ))
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/widgets/appbar_widget.dart';
import 'package:e_commerce/features/profile/presentation/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OpenShop extends GetView<ProfileController> {
  const OpenShop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // พื้นหลังสีฟ้าอ่อน
      backgroundColor: Colors.blue.shade50,
      appBar: buildAppBarCustom(context, 'ເປີດຮ້ານຄ້າ'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: 5,
                    offset: const Offset(0, 5),
                  )
                ]),
            padding: const EdgeInsets.all(24),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ไอคอนตกแต่งส่วนหัว
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.blue.shade100,
                    child: Icon(Icons.storefront_rounded,
                        size: 35, color: Colors.blue.shade700),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'ລົງທະບຽນເປີດຮ້ານຄ້າ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  const SizedBox(height: 25),
                  // ช่องกรอกชื่อร้านค้า
                  TextFormField(
                    controller: controller.nameController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'ກະລຸນາໃສ່ຊື່ຮ້ານຄ້າ';
                      }
                      return null;
                    },
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    decoration: InputDecoration(
                      labelText: 'ຊື່ຮ້ານຄ້າ',
                      labelStyle: TextStyle(color: Colors.blue.shade700),
                      prefixIcon: Icon(Icons.store_outlined,
                          color: Colors.blue.shade400),
                      filled: true,
                      fillColor: Colors.blue.shade50.withOpacity(0.5),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.blue.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Colors.blue.shade600, width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // ช่องกรอกเบอร์โทร
                  TextFormField(
                    controller: controller.telController,
                    keyboardType: TextInputType.phone, // ให้ขึ้นคีย์บอร์ดตัวเลข
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'ກະລຸນາໃສ່ເບີໂທ';
                      }
                      return null;
                    },
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    decoration: InputDecoration(
                      labelText: 'ເບີໂທ',
                      labelStyle: TextStyle(color: Colors.blue.shade700),
                      prefixIcon: Icon(Icons.phone_iphone_rounded,
                          color: Colors.blue.shade400),
                      filled: true,
                      fillColor: Colors.blue.shade50.withOpacity(0.5),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.blue.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Colors.blue.shade600, width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // ปุ่มกดยืนยันสีฟ้า
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 2,
                      minimumSize:
                          const Size.fromHeight(55), // ปรับให้กว้างเต็มกรอบ
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.requestShop(controller.nameController.text,
                            controller.telController.text);
                      }
                    },
                    child: const Text(
                      'ສົ່ງຄຳຂໍເປີດຮ້ານຄ້າ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
