import 'package:flutter/material.dart';
import 'package:testfile/presentation/widgets/MenuWidget.dart';
import 'package:testfile/ui/changePassword/changePassword.dart';
import 'package:testfile/ui/editprofile/editprofile.dart';
import 'package:testfile/ui/login/login.dart';
import 'package:testfile/ui/setting/setting.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testfile/utils/navigation_helper.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: (){
                NavigationHelper.nextPage(context, SettingPage());
              },
              icon: Icon(Icons.settings, color: Colors.black)
          )
        ],
      ),
      body: SingleChildScrollView(
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
                              onPressed: (){},
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
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.free,
                          style: const TextStyle(
                              color: Color(0xFF5E5E5E),
                              fontSize: 16
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
                          onTap: (){
                            NavigationHelper.nextPageRemoveUntil(context, LoginPage());
                          }
                      ),
                    ]
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
