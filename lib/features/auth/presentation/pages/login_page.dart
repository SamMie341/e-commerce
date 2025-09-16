import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/widgets/customButton.dart';
import 'package:e_commerce/features/auth/presentation/controllers/login_controller.dart';
import 'package:e_commerce/features/auth/presentation/widget/textformfieldLogin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = Get.find<LoginController>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final rememberMe = false.obs;
  bool isShow = true;

  @override
  void initState() {
    super.initState();
    loadSavedEmpCode();
  }

  // โหลด empCode ที่เก็บไว้
  Future<void> loadSavedEmpCode() async {
    final savedEmpCode = await controller.getSavedusername();
    if (savedEmpCode != null && savedEmpCode.isNotEmpty) {
      usernameController.text = savedEmpCode;
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Obx(
          () => controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: HexColor('#00268E'),
                    // gradient: LinearGradient(
                    //   begin: Alignment.topCenter,
                    //   end: Alignment.bottomCenter,
                    //   colors: [
                    //     HexColor('#3465D8'),
                    //     HexColor('#00268E'),
                    //   ],
                    // ),
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
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black45,
                                spreadRadius: 0.1,
                                blurRadius: 7,
                                offset: Offset(3, 6),
                              )
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
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
                            Text(
                              'ໄອດີຜູ້ໃຊ້',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            buildTextFormField(
                              context,
                              usernameController,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'ລະຫັດຜ່ານ',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            buildTextFormFieldPassword(
                              context,
                              passwordController,
                              () {
                                setState(() {
                                  isShow = !isShow;
                                });
                              },
                              Icon(isShow
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined),
                              isShow,
                            ),
                            Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Transform.scale(
                                      scale: 1.4,
                                      child: Checkbox(
                                        checkColor: Colors.white,
                                        activeColor: HexColor('#00268E'),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        side: BorderSide(
                                          color: HexColor('#979797'),
                                        ),
                                        value: rememberMe.value,
                                        onChanged: (value) =>
                                            rememberMe.value = value!,
                                      ),
                                    ),
                                    Text(
                                      'ຈື່ຜູ້ໃຊ້ ແລະ ລະຫັດຜ່ານ',
                                      style:
                                          TextStyle(color: HexColor('#949494')),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    'ລືມລະຫັດຜ່ານ?',
                                    style: TextStyle(
                                      color: HexColor('#00268E'),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            buildCustomButton(
                              backgroundColor: HexColor('#5381EC'),
                              text: 'ເຂົ້າສູ່ລະບົບ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              onPressed: () {
                                controller.login(usernameController.text,
                                    passwordController.text, rememberMe.value);
                              },
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
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12),
                                  child: Text(
                                    'ຫຼື ດຳເນີນການຜ່ານ',
                                    style:
                                        TextStyle(color: HexColor('#979797')),
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
                      )
                    ],
                  ),
                ),
        ));
  }
}
