import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/utils/constant.dart';
import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/widgets/appbar_widget.dart';
import 'package:e_commerce/features/profile/presentation/controller/profile_controller.dart';
import 'package:e_commerce/features/profile/presentation/pages/open_shop.dart';
import 'package:e_commerce/features/reviews/presentation/controller/review_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final controller = Get.find<ProfileController>();
  final reviewController = Get.find<ReviewDetailController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      appBar: buildAppBarProfile(context),
      body: SingleChildScrollView(
        child: Obx(() {
          final user = controller.profile.value;
          if (user == null) {
            return Center(
              child: Text('No User Data'),
            );
          }
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  bottom: 20,
                  left: 10,
                  // right: 10,
                ),
                decoration: BoxDecoration(
                  color: HexColor('#537BEC'),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ບັນຊີຜູ້ໃຊ້',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                        if (controller.hasShop.value == false)
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(10),
                                )),
                            child: Center(
                              child: TextButton.icon(
                                  icon: Icon(
                                    Icons.shopping_bag_outlined,
                                    size: 22,
                                    color: primaryColor,
                                  ),
                                  onPressed: () {
                                    Get.to(const OpenShop());
                                  },
                                  label: Text(
                                    'ເປີດຮ້ານຄ້າ',
                                    style:
                                        TextStyle(color: HexColor('#537BEC')),
                                  )),
                            ),
                          )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: CachedNetworkImageProvider(
                            '$apiUrl/upload/user/${user.userimg}',
                            errorListener: (p0) => Icon(Icons.person_outline),
                          ),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                minimumSize:
                                    WidgetStatePropertyAll(Size(90, 90)),
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.transparent),
                                shadowColor:
                                    WidgetStatePropertyAll(Colors.transparent),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => Scaffold(
                                              // backgroundColor: Colors.transparent,
                                              body: Dismissible(
                                                key: const Key("photoView"),
                                                direction:
                                                    DismissDirection.down,
                                                onDismissed: (_) =>
                                                    Navigator.pop(context),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height,
                                                  color: Colors.white,
                                                  child: Center(
                                                    child: PhotoView(
                                                      imageProvider:
                                                          CachedNetworkImageProvider(
                                                        '$apiUrl/upload/user/${user.userimg}',
                                                        errorListener: (p0) =>
                                                            Icon(Icons
                                                                .person_outline),
                                                      ),
                                                      errorBuilder: (context,
                                                              error,
                                                              stackTrace) =>
                                                          Icon(Icons
                                                              .person_outline),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )));
                              },
                              child: Text('')),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.firstname + ' ' + user.lastname,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'ລະຫັດພະນັກງານ: ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  user.code,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Obx(() {
                    final itemReviewCount =
                        reviewController.reviewDetailList.length;

                    return Column(
                      children: [
                        ...itemsList(
                            'ປະຫວັດການສັ່ງຊື່', 'ທ່ານມີ 12 ຄຳສັ່ງຊື້', '/'),
                        ...itemsList('ຈຸດຮັບສິນຄ້າ', 'ມີ 3 ຈຸດຮັບສິນຄ້າ', '/'),
                        ...itemsList('ໂຄ໊ດຮັບສິນຄ້າ',
                            'ທ່ານມີສ່ວນຫຼຸດພິເສດຈາກຮ້ານຄ້າ', '/'),
                        ...itemsList(
                            'ຣີວິວສິນຄ້າ', '$itemReviewCount', 'review'),
                        ListTile(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.white,
                                    elevation: 5,
                                    shadowColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    icon: Icon(
                                      Icons.warning_amber_rounded,
                                      size: 34,
                                    ),
                                    iconColor: Colors.amberAccent,
                                    title: Text(
                                      'ອອກຈາກລະບົບ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    content: Text(
                                      'ທ່ານຕ້ອງການອອກຈາກລະບົບບໍ?',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'ຍົກເລີກ',
                                            style:
                                                TextStyle(color: Colors.green),
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            controller.logout();
                                          },
                                          child: Text(
                                            'ຕົກລົງ',
                                            style: TextStyle(color: Colors.red),
                                          ))
                                    ],
                                  );
                                });
                          },
                          title: Text(
                            'ອອກຈາກລະບົບ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                            ),
                          ),
                          trailing: Icon(
                            Icons.logout,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    );
                  }))
            ],
          );
        }),
      ),
    );
  }

  List<Widget> itemsList(String title, String subtitle, String route) {
    return [
      ListTile(
        internalAddSemanticForOnTap: true,
        onTap: () {
          Get.toNamed(route);
        },
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios_rounded),
        subtitle: Text(subtitle),
      ),
    ];
  }
}
