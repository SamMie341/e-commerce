import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      appBar: buildAppBarCustom(
        context,
        'ລາຍການຣີວິວ',
      ),
      body: Container(
          padding: EdgeInsets.all(12),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (_, index) {
                return Card(
                  elevation: 4,
                  shadowColor: Colors.black,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        height: 100,
                        imageUrl: 'imageUrl',
                        errorWidget: (context, url, error) =>
                            Icon(Icons.image_outlined, size: 100),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ນ້ຳໝາກກ້ຽງ Sun magic 100%',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Range: ',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    'ນ້ຳໝາກກ້ຽງ',
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          right: 10,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ສັ່ງຊື່ວັນທີ: ',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 30),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll(Colors.red),
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ))),
                              onPressed: () {
                                Get.toNamed('reviewProduct');
                              },
                              child: Text(
                                'ຣີວິວ',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              })),
    );
  }
}
