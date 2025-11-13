import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/widgets/customButton.dart';
import 'package:e_commerce/features/auth/presentation/controllers/login_controller.dart';
import 'package:e_commerce/features/auth/presentation/widget/textformfieldLogin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = Get.find<LoginController>();

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
            tileMode: TileMode.repeated,
            transform: GradientRotation(90 / 45),
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
                  color: Colors.black26,
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
                            controller.isShow.value = !controller.isShow.value;
                          },
                          Icon(controller.isShow.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined),
                          controller.isShow,
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
                                fontWeight: FontWeight.bold,
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
