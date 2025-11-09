import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final controller = PageController();

  final items = List.generate(
    3,
    (index) => Container(
      decoration: BoxDecoration(
          color: HexColor('#00268E'),
          image: DecorationImage(image: AssetImage('images/1.png'))),
      child: SizedBox(
        height: 280,
        child: Center(
          child: Image.asset('assets/images/1.png'),
        ),
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args != null && args['goToLast'] == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.jumpToPage(items.length - 1);
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        resizeToAvoidBottomInset: false,
        backgroundColor: HexColor('#00268E'),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: controller,
                children: [
                  buildPage('assets/images/1.png', 'ສູນລວມສິນຄ້າ',
                      'ລວມທຸກຮ້ານຄ້າໃນ ລັດວິສາຫະກິດໄຟຟ້າລາວ ຢູ່ໃນທີ່ນີ້ ທີ່ດຽວຊ່ວຍເພີ່ມຄວາມສະດວກສະບາຍໃນການເລືອກຊື້ສິນຄ້າຂອງທ່ານ.'),
                  buildPage('assets/images/2.png', 'ລົງທະບຽນ',
                      'ກະລຸນາລົງທະບຽນ ເຂົ້າໃຊ້ງານລະບົບເພື່ອຄວາມສະດວກສະບາຍໃນການສັ່ງຊື້ສິນຄ້າ ແລະ ຕິດຕາມສະຖານະການນຳສົ່ງສິນຄ້າ.'),
                  // LoginPage(),
                  buildPage('assets/images/3.png', 'ລົງທະບຽນສຳເລັດ',
                      'ສິນຄ້າຫຼາຍລາຍການລໍຖ້າໃຫ້ທ່ານໄດ້ຊົມໃຊ້, ຊ໊ອບເລີຍຕອນນີ້ທີ່ ແອັບຕະຫຼາດນັດໄຟຟ້າລາວ ຂອງພວກເຮົາ'),
                ],
              ),
            ),
            // SizedBox(height: 15),
            Column(
              children: [
                SmoothPageIndicator(
                  controller: controller,
                  count: items.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: 12,
                    dotWidth: 18,
                    activeDotColor: Colors.white,
                    dotColor: Colors.grey.shade400,
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 40,
                    right: 40,
                  ),
                  child: buildCustomButton(
                    onPressed: () {
                      if (controller.page == items.length - 2) {
                        Get.toNamed('/login');
                      } else if (controller.page == items.length - 1) {
                        Get.toNamed('/home');
                      } else {
                        controller.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      }
                    },
                    text: 'ຖັດໄປ',
                    backgroundColor: HexColor('#FEFEFE'),
                    textStyle: TextStyle(
                      color: HexColor('#01258D'),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
          ],
        ));
  }

  Widget buildPage(String imagePath, String title, String content) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      HexColor('#3465D8'),
                      HexColor('#00268E'),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  imagePath,
                )),
            SizedBox(height: 30),
            Text(
              title,
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                content,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
