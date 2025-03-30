import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testfile/presentation/screens/chooseCancer/chooseCancer.dart';
import 'package:testfile/presentation/screens/history/history.dart';
import 'package:testfile/presentation/screens/message/message.dart';
import 'package:testfile/presentation/screens/profile/profile.dart';
import 'package:testfile/theme/text_styles.dart';
import 'package:testfile/utils/navigation_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _tabs = [
    HomePage(),
    Container(),
    Container(),
    HistoryPage(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    if (index == 1) {
      NavigationHelper.nextPage(context, MessagePage());
    } else if (index == 2) {
      _showImagePickerDialog();
    } else if (index < _tabs.length) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_selectedIndex],
      bottomNavigationBar: Container(
        height: 75,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFF0E70CB),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          iconSize: AppTextStyles.sizeIcon,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
                icon: _selectedIndex == 0 ? Icon(Icons.home_rounded,) : Icon(Icons.home_outlined,),
                label: AppLocalizations.of(context)!.home
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.message_outlined,),
                label: AppLocalizations.of(context)!.chat
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.file_upload_rounded, color: Colors.red,),
                label: AppLocalizations.of(context)!.diagnose,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.history_rounded,),
                label: AppLocalizations.of(context)!.history
            ),
            BottomNavigationBarItem(
                icon: _selectedIndex == _tabs.length - 1 ? Icon(Icons.person_rounded,) :Icon(Icons.person_outline,),
                label: AppLocalizations.of(context)!.profile
            ),
          ],
        ),
      ),
    );
  }

  void _showImagePickerDialog(){
    int previousIndex = _selectedIndex;

    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              AppLocalizations.of(context)!.selectPhotoFrom,
              style: AppTextStyles.title,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library, color: Colors.blue),
                  title: Text(AppLocalizations.of(context)!.googlePhotos, style: AppTextStyles.content,),
                  onTap: () async {
                      File? image = await _pickImageFromGallery();
                      if(image != null){
                        NavigationHelper.nextPage(context, ChooseCancerPage(selectedImage: image));
                      }
                    },
                ),
                ListTile(
                  leading: const Icon(Icons.image, color: Colors.green),
                  title: Text(AppLocalizations.of(context)!.libary, style: AppTextStyles.content,),
                  onTap: () async {
                    File? image = await _pickImageFromFiles();
                    if(image != null){
                      NavigationHelper.nextPage(context, ChooseCancerPage(selectedImage: image));
                    }
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedIndex = previousIndex;
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.cancel,
                    style: AppTextStyles.cancel,
                  )
              )
            ],
          );
        }
    );
  }

  Future _pickImageFromGallery() async{
    final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnImage != null) {
      return File(returnImage.path);
    }
    return null;
  }

  Future<File?> _pickImageFromFiles() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      // type: FileType.image,  // Chỉ cho phép chọn ảnh
    );

    if (result != null) {
      return File(result.files.single.path!);
    }
    return null;
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.welcomeTitle,
              style: TextStyle(
                color: Color(0xFF0E70CB),
                fontSize: 44,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic
              ),
            ),
            const SizedBox(width: 10,),
            Image.asset('assets/imgs/logowelcome2.png', color: Color(0xFF0E70CB), width: 48, height: 48,)
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}


