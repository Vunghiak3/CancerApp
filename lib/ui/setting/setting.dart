import 'package:flutter/material.dart';
import 'package:testfile/ui/changelanguage/changelanguage.dart';
import 'package:testfile/ui/welcompage/welcome.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Setting'),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                margin: EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  children: [
                    ElevatedButton(
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)
                          ),
                          backgroundColor: Colors.white,
                          elevation: 0,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF2F2FB),
                                  shape: BoxShape.circle,
                                ),
                                margin: EdgeInsets.only(right: 20),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.person_outline,
                                    color: Color(0xFF0601B4),
                                    size: 30,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Saved Beneficiary',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18
                                    ),
                                  ),
                                  Text(
                                    'Manage your saved account',
                                    style: TextStyle(
                                        color: Color(0xFFABABAB)
                                    ),
                                  )
                                ],
                              ),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios_rounded, color: Colors.black,)
                            ],
                          ),
                        )
                    ),
                    ElevatedButton(
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)
                          ),
                          backgroundColor: Colors.white,
                          elevation: 0,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF2F2FB),
                                  shape: BoxShape.circle,
                                ),
                                margin: EdgeInsets.only(right: 20),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.delete_outline,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Delete account',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 18
                                      ),
                                    ),
                                    Text(
                                      'Permanently delete your account and data.',
                                      style: TextStyle(
                                          color: Color(0xFFABABAB)
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios_rounded, color: Colors.black,)
                            ],
                          ),
                        )
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'More',
                    style: TextStyle(
                        color: Color(0xff181D27),
                      fontSize: 18
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                margin: EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  children: [
                    ElevatedButton(
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)
                          ),
                          backgroundColor: Colors.white,
                          elevation: 0,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF2F2FB),
                                  shape: BoxShape.circle,
                                ),
                                margin: EdgeInsets.only(right: 20),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.notifications_none_outlined,
                                    color: Color(0xFF0601B4),
                                    size: 30,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Help & Support',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios_rounded, color: Colors.black,)
                            ],
                          ),
                        )
                    ),
                    ElevatedButton(
                        onPressed: (){
                          nextPage(context, ChangeLanguagePage());
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)
                          ),
                          backgroundColor: Colors.white,
                          elevation: 0,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF2F2FB),
                                  shape: BoxShape.circle,
                                ),
                                margin: EdgeInsets.only(right: 20),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.delete_outline,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Change Language',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios_rounded, color: Colors.black,)
                            ],
                          ),
                        )
                    ),
                    ElevatedButton(
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)
                          ),
                          backgroundColor: Colors.white,
                          elevation: 0,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF2F2FB),
                                  shape: BoxShape.circle,
                                ),
                                margin: EdgeInsets.only(right: 20),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.favorite_border_outlined,
                                    color: Color(0xFF0601B4),
                                    size: 30,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'About App',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios_rounded, color: Colors.black,)
                            ],
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
