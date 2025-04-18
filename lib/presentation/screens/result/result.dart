import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testfile/presentation/screens/home/home.dart';
import 'package:testfile/theme/text_styles.dart';
import 'package:testfile/utils/navigation_helper.dart';

class ResultPage extends StatefulWidget {
  final File image;
  final String cancer;

  const ResultPage({super.key, required this.image, required this.cancer});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late File _image;
  late String _cancer;

  @override
  void initState() {
    super.initState();
    _image = widget.image;
    _cancer = widget.cancer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){Navigator.pop(context);},
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: AppTextStyles.sizeIconSmall,)
        ),
        actions: [
          IconButton(
              onPressed: (){
                NavigationHelper.nextPageRemoveUntil(context, HomeScreen());
              },
              icon: Icon(Icons.home_rounded, color: Colors.black, size: AppTextStyles.sizeIcon,)
          )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.file(
                      _image,
                      width: double.infinity,
                      height: 350,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    _cancer,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Giải pháp:",
                          style: AppTextStyles.title,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "• Tư vấn bác sĩ chuyên khoa.\n"
                              "• Làm xét nghiệm chuyên sâu.\n"
                              "• Tuân thủ phác đồ điều trị.",
                          style: AppTextStyles.content,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 80),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.askAi,
                    style: TextStyle(fontSize: AppTextStyles.sizeContent, color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.send, color: Colors.white, size: AppTextStyles.sizeIconSmall,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
