import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/widgets/customButton.dart';
import 'package:e_commerce/features/auth/presentation/controllers/login_controller.dart';
import 'package:e_commerce/features/auth/presentation/widget/textformfieldLogin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({super.key});

  final RxBool isShow = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        decoration: BoxDecoration(
          // color: HexColor('#00268E'),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              HexColor('#3465D8'),
              HexColor('#00268E'),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 30,
              ),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  spreadRadius: 0.1,
                  blurRadius: 7,
                  offset: Offset(3, 6),
                )
              ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Icon(Icons.image, size: 80)),
                    Center(
                        child: Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    )),
                    buildTextFormField(
                      context,
                      controller.usernameController,
                      (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'ກະລຸນາໃສ່ໄອດີຜູ້ໃຊ້';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    Obx(
                      () => buildTextFormFieldPassword(
                          context,
                          controller.passwordController,
                          () {
                            isShow.value = !isShow.value;
                          },
                          Icon(isShow.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined),
                          isShow,
                          (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'ກະລຸນາໃສ່ລະຫັດຜ່ານ';
                            }
                            return null;
                          }),
                    ),
                    Obx(
                      () => Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Transform.scale(
                                scale: 1.4,
                                child: Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    side: BorderSide(
                                      color: HexColor('#979797'),
                                    ),
                                    value: controller.rememberMes.value,
                                    onChanged: (value) {
                                      print(value);
                                      controller.rememberMes.value = value!;
                                    }),
                              ),
                              Text(
                                'ຈື່ຜູ້ໃຊ້ ແລະ ລະຫັດຜ່ານ',
                                style: TextStyle(color: HexColor('#949494')),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              'ລືມລະຫັດຜ່ານ?',
                              style: TextStyle(
                                color: primaryColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Obx(
                      () => controller.isLoading.value
                          ? Center(child: CircularProgressIndicator())
                          : buildCustomButton(
                              backgroundColor: primaryColor,
                              text: 'ເຂົ້າສູ່ລະບົບ',
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              onPressed: () {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  controller.login(
                                      controller.usernameController.text,
                                      controller.passwordController.text,
                                      controller.rememberMes.value);
                                }
                              },
                            ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            // thickness: 0.5,
                            color: HexColor('#979797'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: Text(
                            'ຫຼື ດຳເນີນການຜ່ານ',
                            style: TextStyle(color: HexColor('#979797')),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            // thickness: 0.5,
                            color: HexColor('#979797'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Image.asset(
                            'assets/icons/facebook.png',
                            height: 40,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Image.asset(
                            'assets/icons/google.png',
                            height: 42,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Image.asset(
                            'assets/icons/apple.png',
                            height: 42,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('ທ່ານໄດ້ສະໝັກ Account ແລ້ວ ຫຼື ຍັງ?'),
                        InkWell(
                          child: Text(
                            ' ລົງທະບຽນໃໝ່',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
