import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testfile/ui/chooseCancer/chooseCancer.dart';
import 'package:testfile/ui/history/history.dart';
import 'package:testfile/ui/message/message.dart';
import 'package:testfile/ui/profile/profile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testfile/utils/navigation_helper.dart';

// class CancerHomePage extends StatefulWidget {
//   const CancerHomePage({super.key});
//
//   @override
//   State<CancerHomePage> createState() => _CancerHomePageState();
// }
//
// class _CancerHomePageState extends State<CancerHomePage> {
//   int _selectedIndex = 0;
//
//   final List<Widget> _tabs = [
//     const HomeTab(),
//     const HistoryTab(),
//     const ProfileTab(),
//   ];
//
//   void _onTabSelected(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: _tabs,
//       ),
//       floatingActionButton: Container(
//         width: 60,
//         height: 60,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: Colors.indigoAccent,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.purple.withOpacity(0.3),
//               blurRadius: 5,
//               spreadRadius: 1,
//               offset: Offset(0, 4),
//             )
//           ],
//         ),
//         child: FloatingActionButton(
//           onPressed: ()=> _showImagePickerDialog(context),
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           shape: const CircleBorder(),
//           child: const Icon(Icons.file_upload_outlined, color: Colors.white,),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: CustomBottomNavigationBar(
//         size: size,
//         selectedIndex: _selectedIndex,
//         onTabSelected: _onTabSelected,
//       ),
//     );
//   }
//
//   void _showImagePickerDialog(BuildContext context){
//     showDialog(
//         context: context,
//         builder: (BuildContext context){
//           return AlertDialog(
//             title: Text(
//                 AppLocalizations.of(context)!.selectPhotoFrom,
//               style: TextStyle(
//                   fontSize: 20
//               ),
//             ),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 ListTile(
//                   leading: const Icon(Icons.photo_library, color: Colors.blue),
//                   title: Text(AppLocalizations.of(context)!.googlePhotos),
//                   onTap: () async {
//                       File? image = await _pickImageFromGallery();
//                       if(image != null){
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context)=> ChooseCancerPage(selectedImage: image)
//                             )
//                         );
//                       }
//                     },
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.image, color: Colors.green),
//                   title: Text(AppLocalizations.of(context)!.libary),
//                   onTap: () {},
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: Text(
//                     AppLocalizations.of(context)!.cancel,
//                   )
//               )
//             ],
//           );
//         }
//     );
//   }
//
//   Future _pickImageFromGallery() async{
//     final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);
//
//     if (returnImage != null) {
//       return File(returnImage.path);
//     }
//     return null;
//   }
// }
//
// class CustomBottomNavigationBar extends StatelessWidget{
//   final Size size;
//   final int selectedIndex;
//   final Function(int) onTabSelected;
//
//   const CustomBottomNavigationBar({
//     super.key,
//     required this.size,
//     required this.selectedIndex,
//     required this.onTabSelected,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         SizedBox(
//           width: size.width,
//           height: 80,
//           child: Stack(
//             children: [
//               CustomPaint(
//                 size: Size(size.width, 80),
//                 painter: BNBCustomPainter(),
//               ),
//               SizedBox(
//                 width: size.width,
//                 height: 80,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     _buildNavItem(Icons.home, AppLocalizations.of(context)!.home, 0),
//                     IconButton(
//                         onPressed: (){
//                           nextPage(context, MessageTab());
//                           },
//                         icon: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Icon(Icons.message_outlined, color: Colors.grey,),
//                             Text(
//                               AppLocalizations.of(context)!.chat,
//                               style: TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 12
//                               ),
//                             )
//                           ],
//                         )
//                     ),
//                     SizedBox(width: size.width * 0.10),
//                     _buildNavItem(Icons.history, AppLocalizations.of(context)!.history, 1),
//                     _buildNavItem(Icons.person_outline, AppLocalizations.of(context)!.profile, 2),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         )
//       ],
//     );
//   }
//
//   Widget _buildNavItem(IconData icon, String title, int index) {
//     bool isSelected = selectedIndex == index;
//     return GestureDetector(
//       onTap: () => onTabSelected(index),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, color: isSelected ? Color(0xFF0E70CB) : Colors.grey),
//           Text(
//             title,
//             style: TextStyle(
//               color: isSelected ? Color(0xFF0E70CB) : Colors.grey,
//               fontSize: 12,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class BNBCustomPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.fill;
//
//     Paint borderPaint = Paint()
//       ..color = Colors.black
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 0.40;
//
//     Path path = Path()..moveTo(0, 20);
//     path.arcToPoint(Offset(20, 0), radius: Radius.circular(20.0), clockwise: true);
//
//     path.lineTo(size.width * 0.35, 0);
//     path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.42, 20);
//
//     path.arcToPoint(
//       Offset(size.width * 0.58, 20),
//       radius: Radius.circular(40.0),
//       clockwise: false,
//     );
//
//     path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
//
//     path.lineTo(size.width - 20, 0);
//     path.arcToPoint(Offset(size.width, 20), radius: Radius.circular(20.0), clockwise: true);
//
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     path.close();
//
//     canvas.drawShadow(path, Colors.black, -1.0, true);
//
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }

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
      _showImagePickerDialog(context);
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
          iconSize: 23,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
                icon: _selectedIndex == 0 ? Icon(Icons.home_rounded) : Icon(Icons.home_outlined),
                label: AppLocalizations.of(context)!.home
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.message_outlined),
                label: AppLocalizations.of(context)!.chat
            ),BottomNavigationBarItem(
                icon: Icon(Icons.file_upload_rounded),
                label: AppLocalizations.of(context)!.diagnose
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.history_rounded),
                label: AppLocalizations.of(context)!.history
            ),
            BottomNavigationBarItem(
                icon: _selectedIndex == _tabs.length - 1 ? Icon(Icons.person_rounded) :Icon(Icons.person_outline),
                label: AppLocalizations.of(context)!.profile
            ),
          ],
        ),
      ),
    );
  }

  void _showImagePickerDialog(BuildContext context){
    int previousIndex = _selectedIndex;

    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              AppLocalizations.of(context)!.selectPhotoFrom,
              style: TextStyle(
                  fontSize: 20
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library, color: Colors.blue),
                  title: Text(AppLocalizations.of(context)!.googlePhotos),
                  onTap: () async {
                      File? image = await _pickImageFromGallery();
                      if(image != null){
                        NavigationHelper.nextPage(context, ChooseCancerPage(selectedImage: image));
                      }
                    },
                ),
                ListTile(
                  leading: const Icon(Icons.image, color: Colors.green),
                  title: Text(AppLocalizations.of(context)!.libary),
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
            Image.asset('assets/imgs/logowelcome2.png', color: Color(0xFF0E70CB), width: 50, height: 50,)
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}


