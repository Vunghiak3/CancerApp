import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:testfile/presentation/screens/changePassword/changePassword.dart';
import 'package:testfile/presentation/screens/editprofile/editprofile.dart';
import 'package:testfile/presentation/screens/login/login.dart';
import 'package:testfile/presentation/screens/setting/setting.dart';
import 'package:testfile/presentation/widgets/MenuWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testfile/services/auth.dart';
import 'package:testfile/utils/navigation_helper.dart';
import 'package:testfile/theme/text_styles.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<String?> getIdToken() async {
    String? userJson = await AuthService().getUser();

    Map<String, dynamic> user = jsonDecode(userJson!);
    print('Response: ${user}');
  }

  void logout() async{
    try {
      await AuthService().logout();
      NavigationHelper.nextPageRemoveUntil(context, LoginPage());
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Logout failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  PreferredSizeWidget getAppBar(){
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
            onPressed: (){
              NavigationHelper.nextPage(context, SettingPage());
            },
            icon: Icon(Icons.settings, color: Colors.black, size: 24,)
        )
      ],
    );
  }

  Widget getBody(){
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
          child: Column(
            children: [
              Row(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3ptSvyhlI6mkEM1kkVUlqP15QN4_8MHg5uA&s",
                          width: 110,
                          height: 110,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: -15,
                        right: -15,
                        child: ElevatedButton(
                            onPressed: getIdToken,
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(0),
                                backgroundColor: Color(0xFFD9D9D9),
                                minimumSize: Size(45, 45),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)
                                )
                            ),
                            child: Icon(Icons.camera_alt_rounded, color: Colors.black, size: 30,)
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 30,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "John Doe",
                        style: TextStyle(
                          fontSize: AppTextStyles.sizeTitle,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.free,
                        style: TextStyle(
                          fontSize: AppTextStyles.sizeContent,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 30,),
              MenuWidget(
                  items: [
                    MenuItem(
                        text: AppLocalizations.of(context)!.myAccount,
                        subText: AppLocalizations.of(context)!.desMyAccount,
                        icon: Icons.person_outline_rounded,
                        onTap: (){
                          NavigationHelper.nextPage(context, EditProfilePage());
                        }
                    ),
                    MenuItem(
                        text: AppLocalizations.of(context)!.changePassword,
                        subText: AppLocalizations.of(context)!.desPassword,
                        icon: Icons.key_rounded,
                        onTap: (){
                          NavigationHelper.nextPage(context, ChangePasswordPage());
                        }
                    ),
                    MenuItem(
                        text: AppLocalizations.of(context)!.logout,
                        subText: AppLocalizations.of(context)!.desLogout,
                        icon: Icons.logout,
                        colorIcon: Colors.red,
                        onTap: logout
                    ),
                  ]
              )
            ],
          ),
        ),
      ),
    );
  }
}
