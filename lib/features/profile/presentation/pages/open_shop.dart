import 'dart:ui';

import 'package:e_commerce/core/widgets/appbar_widget.dart';
import 'package:e_commerce/features/profile/presentation/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OpenShop extends GetView<ProfileController> {
  const OpenShop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarCustom(context, 'ເປີດຮ້ານຄ້າ'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 0),
              color: Colors.transparent),
          padding: const EdgeInsets.all(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 3),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: controller.nameController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'ກະລຸນາໃສ່ຊື່ຮ້ານ';
                      }
                      return null;
                    },
                    onTapUpOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    decoration: InputDecoration(
                      labelText: 'ຊື່ຮ້ານຄ້າ',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: controller.telController,
                    onTapUpOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    decoration: InputDecoration(
                      labelText: 'ເບີໂທ',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                      // style: ,
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          controller.requestShop(controller.nameController.text,
                              controller.telController.text);
                        }
                      },
                      child: Text('ສົ່ງຄຳຂໍເປີດຮ້ານຄ້າ'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
