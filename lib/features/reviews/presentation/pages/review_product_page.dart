import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:e_commerce/core/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';

class ReviewProductPage extends StatefulWidget {
  const ReviewProductPage({super.key});

  @override
  State<ReviewProductPage> createState() => _ReviewProductPageState();
}

class _ReviewProductPageState extends State<ReviewProductPage> {
  int _rating = 5;
  final TextEditingController _reviewController = TextEditingController();
  final List<String> _selectedImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      appBar: buildAppBarCustom(context, 'ຣີວິວສິນຄ້າ'),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Card(
                color: Colors.white,
                child: Row(
                  children: [
                    CachedNetworkImage(
                      height: 100,
                      imageUrl: '',
                      errorWidget: (context, url, error) =>
                          Icon(Icons.image_outlined, size: 100),
                    ),
                    Expanded(
                      child: Column(
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
                          SizedBox(height: 10),
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
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(
                                  'ສັ່ງຊື້ວັນທີ: 22/08/2025',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            ...List.generate(5, (index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _rating = index + 1;
                                  });
                                },
                                child: Icon(
                                  Icons.star_rounded,
                                  color: index < _rating
                                      ? Colors.amber
                                      : Colors.grey[300],
                                  size: 28,
                                ),
                              );
                            }),
                            SizedBox(width: 10),
                            Text('$_rating ດາວ'),
                          ]),
                      SizedBox(height: 10),
                      Text(
                        'ຄຳອະທິບາຍສິນຄ້າ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey[300]!, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          controller: _reviewController,
                          cursorColor: Colors.grey[600],
                          maxLength: 500,
                          maxLines: 8,
                          decoration: InputDecoration(
                            hintText: 'ປ້ອນຄຳອະທິບາຍສິນຄ້າ......',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(16),
                            counterStyle: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      // Text(
                      //   'ອັບໂຫຼດຮູບພາບ',
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.w600,
                      //     color: Colors.black87,
                      //   ),
                      // ),
                      // SizedBox(height: 12),
                      // Row(
                      //   children: [
                      //     // Upload Area
                      //     Expanded(
                      //       flex: 2,
                      //       child: GestureDetector(
                      //         onTap: _showImagePickerOptions,
                      //         child: DottedBorder(
                      //           borderType: BorderType.RRect,
                      //           radius: Radius.circular(8),
                      //           dashPattern: [8, 4],
                      //           strokeWidth: 2,
                      //           color: Colors.blue,
                      //           child: SizedBox(
                      //             height: 120,
                      //             width: double.infinity,
                      //             child: Column(
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 Icon(
                      //                   Icons.image,
                      //                   size: 40,
                      //                   color: Colors.blue,
                      //                 ),
                      //                 SizedBox(height: 8),
                      //                 Text(
                      //                   'ອັບໂຫຼດຮູບ',
                      //                   style: TextStyle(
                      //                     color: Colors.blue,
                      //                     fontSize: 14,
                      //                     fontWeight: FontWeight.w500,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(height: 12),
                      Row(
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll(Colors.white),
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1,
                                            color: Colors.grey,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5)))),
                              onPressed: () {},
                              child: Text(
                                'ຍົກເລີກ',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              )),
                          SizedBox(width: 12),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll(Colors.blueAccent),
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1,
                                            color: Colors.blueAccent,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5)))),
                              onPressed: () {},
                              child: Text(
                                'ຢືນຢັນຣີວິວ',
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      )
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('เลือกจากแกลเลอรี'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromGallery();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('ถ่ายรูป'),
                onTap: () {
                  Navigator.pop(context);
                  _takePicture();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _pickImageFromGallery() {
    // Implementation for picking image from gallery
    print('เลือกรูปจากแกลเลอรี');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('เลือกรูปจากแกลเลอรี')),
    );
  }

  void _takePicture() {
    // Implementation for taking picture with camera
    print('ถ่ายรูปด้วยกล้อง');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('เปิดกล้องถ่ายรูป')),
    );
  }
}
