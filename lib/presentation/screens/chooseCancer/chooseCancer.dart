import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testfile/presentation/screens/home/home.dart';
import 'package:testfile/presentation/screens/result/result.dart';
import 'package:testfile/theme/text_styles.dart';
import 'package:testfile/utils/navigation_helper.dart';

class ChooseCancerPage extends StatefulWidget {
  final File selectedImage;

  const ChooseCancerPage({super.key, required this.selectedImage});

  @override
  State<ChooseCancerPage> createState() => _ChooseCancerPageState();
}

class _ChooseCancerPageState extends State<ChooseCancerPage> {
  int _selectedIndex = -1;
  late File _selectedImage;

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.selectedImage;
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> _cancer = [
      {
        "img": "https://via.placeholder.com/110",
        "title": AppLocalizations.of(context)!.brainCancer,
      },
      {
        "img": "https://via.placeholder.com/110",
        "title": AppLocalizations.of(context)!.kidneyCancer,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            AppLocalizations.of(context)!.selectCancerType,
            style: AppTextStyles.title,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
            size: AppTextStyles.sizeIconSmall,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              NavigationHelper.nextPageRemoveUntil(context, HomeScreen());
            },
            icon: Icon(
              Icons.home_rounded,
              color: Colors.black,
              size: AppTextStyles.sizeIcon,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  _selectedImage,
                  fit: BoxFit.cover,
                  height: 350,
                  width: double.infinity,
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () async {
                File? image = await _pickImageFromGallery();
                if (image != null) {
                  setState(() {
                    _selectedImage = image;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Color(0xFF0E70CB),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Color(0xFF0E70CB)),
                ),
              ),
              icon: Icon(
                Icons.photo_library_outlined,
                color: Color(0xFF0E70CB),
                size: AppTextStyles.sizeIconSmall,
              ),
              label: Text(
                AppLocalizations.of(context)!.selectAnotherPhoto,
                style: TextStyle(
                  fontSize: AppTextStyles.sizeContent,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.selectDiseaseType,
                  style: TextStyle(
                    fontSize: AppTextStyles.sizeTitle,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0E70CB),
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _cancer.length,
              itemBuilder: (context, index) {
                bool isSelected = index == _selectedIndex;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xffe7f1fa) : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                      border: Border.all(
                        color:
                            isSelected ? Color(0xFF0E70CB) : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        _cancer[index]["title"]!,
                        style: TextStyle(
                          fontSize: AppTextStyles.sizeContent,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Icon(
                        isSelected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        color: isSelected ? Color(0xFF0E70CB) : Colors.grey,
                        size: AppTextStyles.sizeIconSmall,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectedIndex != -1
                  ? () {
                      // Instead of directly using the selected cancer type,
                      // we send the image to the API for prediction.
                      checkCancer(_selectedImage);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0E70CB),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.diagnosis,
                style: TextStyle(fontSize: AppTextStyles.sizeContent),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<File?> _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage != null) {
      return File(returnImage.path);
    }
    return null;
  }

  Future<void> checkCancer(File image) async {
    // Show a loading indicator while waiting for API response
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try {
      var uri = Uri.parse("http://127.0.0.1:8000/cnn/predict");
      var request = http.MultipartRequest('POST', uri);
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
      var response = await request.send();

      // Dismiss the loading indicator
      Navigator.of(context).pop();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(responseData);
        String prediction = jsonResponse["prediction"];
        NavigationHelper.nextPage(
            context, ResultPage(image: image, cancer: prediction));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("API Error: ${response.reasonPhrase}")),
        );
      }
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }
}
