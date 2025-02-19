import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testfile/ui/result/result.dart';

class ChooseCancerPage extends StatefulWidget {
  final File selectedImage;

  const ChooseCancerPage({super.key, required this.selectedImage});

  @override
  State<ChooseCancerPage> createState() => _ChooseCancerPageState();
}

class _ChooseCancerPageState extends State<ChooseCancerPage> {
  int _selectedIndex = 0;
  late File _selectedImage;

  final List<Map<String, String>> _cancer = [
    {
      "img": "https://via.placeholder.com/110",
      "title": "Cancer Brain",
    },
    {
      "img": "https://via.placeholder.com/110",
      "title": "Cancer Kidney",
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.selectedImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cancer'),
      ),
      body: Column(
        children: [
          _selectedImage != null
              ? Image.file(
              _selectedImage,
              fit: BoxFit.contain
          )
              : Icon(Icons.image, size: 100, color: Colors.grey),
          ElevatedButton(
              onPressed: () async {
                File? image = await _pickImageFromGallery();

                if (image != null) {
                  setState(() {
                    _selectedImage = image;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                side: BorderSide(color: Colors.grey.shade300),
              ),
              child: Text(
                'Chọn ảnh khác',
                style: TextStyle(
                    color: Colors.black
                ),
              )
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _cancer.length,
              itemBuilder: (context, index){
                bool isSelected = index == _selectedIndex;
                return GestureDetector(
                    onTap: (){
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          child: ElevatedButton(
                              onPressed: (){
                                checkCancer(_cancer[index]["title"]!, _selectedImage);
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                side: BorderSide(color: Colors.grey.shade300),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        _cancer[index]["img"] ?? "https://via.placeholder.com/110",
                                        width:30,
                                        height: 30,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            width: 30,
                                            height: 30,
                                            color: Colors.grey.shade300,
                                            child: Icon(Icons.image_not_supported, size: 20, color: Colors.grey),
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Text(
                                      _cancer[index]["title"]?? "Unknow",
                                      style: TextStyle(
                                          color: Colors.black
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(Icons.arrow_forward_ios_rounded, color: Colors.black,)
                                  ],
                                ),
                              )
                          ),
                        ),
                      ],
                    )
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Future _pickImageFromGallery() async{
    final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnImage != null) {
      return File(returnImage.path);
    }
    return null;
  }

  void checkCancer(String cancer, File image){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResultPage(cancer: cancer, image: image)
        )
    );
  }
}



