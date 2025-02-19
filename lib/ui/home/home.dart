import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testfile/ui/chooseCancer/chooseCancer.dart';
import 'package:testfile/ui/history/history.dart';
import 'package:testfile/ui/message/message.dart';
import 'package:testfile/ui/profile/profile.dart';
import 'package:testfile/ui/welcompage/welcome.dart';

class CancerHomePage extends StatefulWidget {
  const CancerHomePage({super.key});

  @override
  State<CancerHomePage> createState() => _CancerHomePageState();
}

class _CancerHomePageState extends State<CancerHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [
    const HomeTab(),
    const HistoryTab(),
    const ProfileTab(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: _tabs,
      ),
      floatingActionButton: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.indigoAccent,
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(0.3),
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: FloatingActionButton(
          onPressed: ()=> _showImagePickerDialog(context),
          backgroundColor: Colors.transparent,
          elevation: 0, // Tắt bóng mặc định
          shape: const CircleBorder(),
          child: const Icon(Icons.file_upload_outlined, color: Colors.white,),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavigationBar(
        size: size,
        selectedIndex: _selectedIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }

  void _showImagePickerDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text('Chọn ảnh từ'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library, color: Colors.blue),
                  title: const Text('Google Photos'),
                  onTap: () async {
                      File? image = await _pickImageFromGallery();
                      if(image != null){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context)=> ChooseCancerPage(selectedImage: image)
                            )
                        );
                      }
                    },
                ),
                ListTile(
                  leading: const Icon(Icons.image, color: Colors.green),
                  title: const Text('Thư viện'),
                  onTap: () {},
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Thoát')
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
}

class CustomBottomNavigationBar extends StatelessWidget{
  final Size size;
  final int selectedIndex;
  final Function(int) onTabSelected;

  const CustomBottomNavigationBar({
    super.key,
    required this.size,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: size.width,
          height: 80,
          child: Stack(
            children: [
              CustomPaint(
                size: Size(size.width, 80),
                painter: BNBCustomPainter(),
              ),
              Container(
                width: size.width,
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(Icons.home, "Home", 0),
                    IconButton(
                        onPressed: (){
                          nextPage(context, MessageTab());
                          }, 
                        icon: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.message_outlined, color: Colors.grey,),
                            Text(
                              'Chat',
                              style: TextStyle(
                                  color: Colors.grey
                              ),
                            )
                          ],
                        )
                    ),
                    SizedBox(width: size.width * 0.10),
                    _buildNavItem(Icons.history, "History", 1),
                    _buildNavItem(Icons.person_outline, "Profile", 2),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildNavItem(IconData icon, String title, int index) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? Colors.blue : Colors.grey),
          Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Paint borderPaint = Paint()
      ..color = Colors.black // Màu viền
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.40; // Độ dày viền

    Path path = Path()..moveTo(0, 20);
    path.arcToPoint(Offset(20, 0), radius: Radius.circular(20.0), clockwise: true);

    path.lineTo(size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.42, 20);

    path.arcToPoint(
      Offset(size.width * 0.58, 20),
      radius: Radius.circular(40.0),
      clockwise: false,
    );

    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);

    path.lineTo(size.width - 20, 0);
    path.arcToPoint(Offset(size.width, 20), radius: Radius.circular(20.0), clockwise: true);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    // Vẽ bóng
    canvas.drawShadow(path, Colors.black, -1.0, true);

    // Vẽ nền
    canvas.drawPath(path, paint);

    // Vẽ viền
    // canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}


class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

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
              'Curely',
              style: TextStyle(
                color: Color(0xFF0E70CB),
                fontSize: 44,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic
              ),
            ),
            SizedBox(width: 10,),
            Icon(Icons.camera, color: Color(0xFF0E70CB), size: 40,)
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}


