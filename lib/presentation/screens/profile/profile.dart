import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:testfile/presentation/screens/changePassword/changePassword.dart';
import 'package:testfile/presentation/screens/editprofile/editprofile.dart';
import 'package:testfile/presentation/screens/login/login.dart';
import 'package:testfile/presentation/screens/setting/setting.dart';
import 'package:testfile/presentation/widgets/MenuWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testfile/services/auth.dart';
import 'package:testfile/services/user.dart';
import 'package:testfile/utils/navigation_helper.dart';
import 'package:testfile/theme/text_styles.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Map<String, dynamic>> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = loadUser();
  }

  Future<Map<String, dynamic>> fetchUser() async {
    try {
      String idToken = await AuthService().getIdToken();

      final res = await UserService().getUser(idToken);
      return res;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>?> getUserFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('user');
    if (userString != null) {
      return jsonDecode(userString);
    }
    return null;
  }

  Future<Map<String, dynamic>> loadUser() async {
    final localUser = await getUserFromStorage();
    if (localUser != null) {
      print(localUser);
      return localUser;
    } else {
      final fetchedUser = await fetchUser();
      UserService().saveUserToStorage(fetchedUser);
      return fetchedUser;
    }
  }

  void fetchLogout() async{
    try {
      String idToken = await AuthService().getIdToken();
      print(idToken);
      await AuthService().logout(idToken);
      print(idToken);
      NavigationHelper.nextPageRemoveUntil(context, LoginPage());
    } catch (e) {
      print('Logout failed: $e');
    }
  }

  void getIdToken() async{
    String idToken = await AuthService().getIdToken();
    final user = await AuthService().getUser();
    print(idToken);
    print(user);
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
              getUserBox(),
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
                        onTap: fetchLogout
                    ),
                  ]
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getUserBox(){
    return FutureBuilder<Map<String, dynamic>>(
      future: _userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return shimmderBox();
        }

        if (snapshot.hasError) {
          return Text("Lỗi tải thông tin người dùng");
        }

        final userData = snapshot.data!;
        return Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    userData['profilePicture'] ?? '',
                    width: 110,
                    height: 110,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrack) {
                      return Image.asset(
                        'assets/imgs/placeholder.png',
                        width: 110,
                        height: 110,
                        fit: BoxFit.cover,
                      );
                    },
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
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: Icon(Icons.camera_alt_rounded, color: Colors.black, size: 30),
                  ),
                )
              ],
            ),
            const SizedBox(width: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userData['nickName'] ?? userData['name'] ?? 'Unknown',
                  style: const TextStyle(
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
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget shimmderBox(){
   return Shimmer.fromColors(
     baseColor: Colors.grey.shade300,
     highlightColor: Colors.grey.shade100,
     child: Row(
       children: [
         Container(
           width: 110,
           height: 110,
           decoration: BoxDecoration(
             color: Colors.white,
             borderRadius: BorderRadius.circular(30),
           ),
         ),
         const SizedBox(width: 30),
         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Container(
               width: 120,
               height: 20,
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(8),
               ),
             ),
             const SizedBox(height: 10),
             Container(
               width: 80,
               height: 16,
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(8),
               ),
             ),
           ],
         )
       ],
     ),
   );
 }
}
