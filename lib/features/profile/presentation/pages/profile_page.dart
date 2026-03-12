import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/utils/constant.dart';
import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/core/widgets/appbar_widget.dart';
import 'package:e_commerce/features/profile/presentation/controller/profile_controller.dart';
import 'package:e_commerce/features/profile/presentation/pages/open_shop.dart';
import 'package:e_commerce/features/reviews/presentation/controller/review_by_product_controller.dart';
import 'package:e_commerce/features/reviews/presentation/controller/review_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final controller = Get.find<ProfileController>();
  final reviewController = Get.find<ReviewDetailController>();
  final reviewByProduct = Get.find<ReviewByProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      appBar: buildAppBarProfile(
        context,
        action: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: () {
                  controller.fetchShopStatus();
                  controller.fetchProfile();
                },
                icon: Icon(Icons.refresh_rounded)),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.fetchShopStatus();
          controller.fetchProfile();
        },
        child: SingleChildScrollView(
          child: Obx(() {
            final user = controller.profile.value;
            if (controller.isLoadingProfile.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (user == null) {
              return Center(
                child: Text('ເກີດຂໍ້ຜິດພາດ'),
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
                          else
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
                                    onPressed: null,
                                    label: Text(
                                      user.shop.name ?? '',
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
                                  backgroundColor: WidgetStatePropertyAll(
                                      Colors.transparent),
                                  shadowColor: WidgetStatePropertyAll(
                                      Colors.transparent),
                                ),
                                onPressed: () {
                                  Get.dialog(Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () => Get.back(),
                                        child: Container(
                                          color: Colors.black87,
                                        ),
                                      ),
                                      Center(
                                        child: InteractiveViewer(
                                            panEnabled: true,
                                            boundaryMargin:
                                                const EdgeInsets.all(20),
                                            minScale: 0.5,
                                            maxScale: 4,
                                            child: Container(
                                              constraints: BoxConstraints(
                                                maxHeight: Get.height * 0.8,
                                                maxWidth: Get.width * 0.95,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  '$apiUrl/upload/user/${user.userimg}',
                                                  fit: BoxFit.contain,
                                                  loadingBuilder: (context,
                                                      child, loadingProgress) {
                                                    if (loadingProgress ==
                                                        null) {
                                                      return child;
                                                    }
                                                    return SizedBox(
                                                      height: 200,
                                                      width: 200,
                                                      child: Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          value: loadingProgress
                                                                      .expectedTotalBytes !=
                                                                  null
                                                              ? loadingProgress
                                                                      .cumulativeBytesLoaded /
                                                                  loadingProgress
                                                                      .expectedTotalBytes!
                                                              : null,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return const Padding(
                                                      padding:
                                                          EdgeInsets.all(20),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .broken_image_rounded,
                                                            size: 50,
                                                            color: Colors.grey,
                                                          ),
                                                          Text(
                                                            'ໂຫຼດຮູບບໍ່ໄດ້',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontSize: 14),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            )),
                                      ),
                                      Positioned(
                                          top: 40,
                                          right: 20,
                                          child: Material(
                                            color: Colors.transparent,
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 30,
                                              ),
                                              onPressed: () => Get.back(),
                                            ),
                                          ))
                                    ],
                                  ));

                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (_) =>
                                  //         Scaffold(
                                  //               // backgroundColor: Colors.transparent,
                                  //               body: Dismissible(
                                  //                 key: const Key("photoView"),
                                  //                 direction:
                                  //                     DismissDirection.down,
                                  //                 onDismissed: (_) =>
                                  //                     Navigator.pop(context),
                                  //                 child: Container(
                                  //                   width: MediaQuery.of(context)
                                  //                       .size
                                  //                       .width,
                                  //                   height: MediaQuery.of(context)
                                  //                       .size
                                  //                       .height,
                                  //                   color: Colors.white,
                                  //                   child: Center(
                                  //                     child: PhotoView(
                                  //                       imageProvider:
                                  //                           CachedNetworkImageProvider(
                                  //                         '$apiUrl/upload/user/${user.userimg}',
                                  //                         errorListener: (p0) =>
                                  //                             Icon(Icons
                                  //                                 .person_outline),
                                  //                       ),
                                  //                       errorBuilder: (context,
                                  //                               error,
                                  //                               stackTrace) =>
                                  //                           Icon(Icons
                                  //                               .person_outline),
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             )));
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
                              title: 'ປະຫວັດການສັ່ງຊື່',
                              subtitle: '',
                              route: '/buyHistory'),
                          ...itemsList(
                            title: 'ຣີວິວສິນຄ້າ',
                            subtitle: 'ທ່ານມີ $itemReviewCount ລາຍການຣີວິວ',
                            route: '/review',
                            // notification: reviewByProduct.unreadCount.value > 0
                            //     ? Container(
                            //         padding: const EdgeInsets.all(6),
                            //         decoration: const BoxDecoration(
                            //           color: Colors.red,
                            //           shape: BoxShape.circle,
                            //         ),
                            //         constraints: const BoxConstraints(
                            //           minWidth: 20,
                            //           minHeight: 20,
                            //         ),
                            //         child: Center(
                            //           child: Text(
                            //             '${reviewByProduct.unreadCount.value}',
                            //             style: const TextStyle(
                            //               color: Colors.white,
                            //               fontSize: 12,
                            //               fontWeight: FontWeight.bold,
                            //             ),
                            //           ),
                            //         ),
                            //       )
                            //     : const SizedBox.shrink(),
                          ),
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
                                              style: TextStyle(
                                                  color: Colors.green),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              controller.logout();
                                            },
                                            child: Text(
                                              'ຕົກລົງ',
                                              style:
                                                  TextStyle(color: Colors.red),
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
      ),
    );
  }

  List<Widget> itemsList(
      {String? title, String? subtitle, String? route, Widget? notification}) {
    return [
      ListTile(
        internalAddSemanticForOnTap: true,
        onTap: () {
          Get.toNamed(route ?? '');
        },
        title: Text(
          title ?? '',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: SizedBox(
          height: 60,
          child: Stack(
            alignment: Alignment.centerRight,
            clipBehavior: Clip.none,
            children: [
              Icon(Icons.arrow_forward_ios_rounded),
              if (notification != null)
                Positioned(right: 25, top: -5, child: notification)
            ],
          ),
        ),
        subtitle:
            (subtitle != null && subtitle.isNotEmpty) ? Text(subtitle) : null,
      ),
    ];
  }
}
