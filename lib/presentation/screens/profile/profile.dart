import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:testfile/presentation/screens/changePassword/changePassword.dart';
import 'package:testfile/presentation/screens/editprofile/editprofile.dart';
import 'package:testfile/presentation/screens/login/login.dart';
import 'package:testfile/presentation/screens/setting/setting.dart';
import 'package:testfile/presentation/widgets/CustomTopNotification.dart';
import 'package:testfile/presentation/widgets/ImagePickerHelper.dart';
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
  bool isUpdatingPicture = false;

  @override
  void initState() {
    super.initState();
    _userFuture = loadUser();
  }

  Future<Map<String, dynamic>> loadUser() async {
    final userString = await AuthService().getUser();
    return jsonDecode(userString!);
  }

  void fetchLogout() async {
    try {
      String idToken = await AuthService().getIdToken();
      await AuthService().logout(idToken);
      NavigationHelper.nextPageRemoveUntil(context, LoginPage());
    } catch (e) {
      throw Exception(e);
    }
  }

  void fetchUpdateProfilePicture(BuildContext context) async{
    try {
      ImagePickerHelper.showImagePickerDialog(
        context,
        (image) async {
          setState(() => isUpdatingPicture = true);
          await UserService().updateProfilePicture(image);
          setState(() {
            _userFuture = loadUser();
            isUpdatingPicture = false;
          });
          CustomTopNotification.show(context, message: AppLocalizations.of(context)!.updatePhotoSuccess);
        },
      );
    } catch (e) {
      CustomTopNotification.show(context, message: AppLocalizations.of(context)!.updatePhotoFail, color: Colors.red);
      throw Exception(e);
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

  PreferredSizeWidget getAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
            onPressed: () {
              NavigationHelper.nextPage(context, SettingPage());
            },
            icon: Icon(
              Icons.settings,
              color: Colors.black,
              size: 24,
            ))
      ],
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
          child: Column(
            children: [
              getUser(),
              const SizedBox(
                height: 30,
              ),
              MenuWidget(items: [
                MenuItem(
                    text: AppLocalizations.of(context)!.myAccount,
                    subText: AppLocalizations.of(context)!.desMyAccount,
                    icon: Icons.person_outline_rounded,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfilePage()),
                      ).then((_) {
                        setState(() {
                          _userFuture = loadUser();
                        });
                      });

                    }),
                MenuItem(
                    text: AppLocalizations.of(context)!.changePassword,
                    subText: AppLocalizations.of(context)!.desPassword,
                    icon: Icons.key_rounded,
                    onTap: () {
                      NavigationHelper.nextPage(context, ChangePasswordPage());
                    }),
                MenuItem(
                    text: AppLocalizations.of(context)!.logout,
                    subText: AppLocalizations.of(context)!.desLogout,
                    icon: Icons.logout,
                    colorIcon: Colors.red,
                    onTap: fetchLogout),
              ])
            ],
          ),
        ),
      ),
    );
  }

  Widget getUser() {
    return FutureBuilder<Map<String, dynamic>>(
      future: _userFuture,
      builder: (context, snapshot) {
        if (isUpdatingPicture || snapshot.connectionState == ConnectionState.waiting) {
          return shimmderBox();
        }

        if (snapshot.hasError) {
          return Text(AppLocalizations.of(context)!.errorLoadingUserInfo);
        }

        final userData = snapshot.data!;
        return Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: (userData['profilePicture'] != null &&
                            userData['profilePicture'].isNotEmpty)
                        ? Image.network(
                            userData['profilePicture'],
                            width: 110,
                            height: 110,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/imgs/imageprofile.png',
                                width: 110,
                                height: 110,
                                fit: BoxFit.cover,
                              );
                            },
                          )
                        : Image.asset(
                            'assets/imgs/imageprofile.png',
                            width: 110,
                            height: 110,
                            fit: BoxFit.cover,
                          )),
                Positioned(
                  bottom: -15,
                  right: -15,
                  child: ElevatedButton(
                    onPressed: () => fetchUpdateProfilePicture(context),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(0),
                      backgroundColor: Color(0xFFD9D9D9),
                      minimumSize: Size(45, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: Icon(Icons.camera_alt_rounded,
                        color: Colors.black, size: 30),
                  ),
                )
              ],
            ),
            const SizedBox(width: 30),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userData['nickName'] ?? userData['name'] ?? 'Unknown',
                    style: const TextStyle(
                      fontSize: AppTextStyles.sizeTitle,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    maskEmail(userData['email']) ?? '',
                    style: TextStyle(
                      fontSize: AppTextStyles.sizeContent,
                      color: Colors.grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    userData['dob'] != null ? DateFormat('dd-MM-yyyy').format(DateTime.parse(userData['dob'])) : '',
                    style: TextStyle(
                      fontSize: AppTextStyles.sizeContent,
                      color: Colors.grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  String maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email; // email không hợp lệ

    String name = parts[0];
    String domain = parts[1];

    if (name.length <= 4) {
      return '${name[0]}***@$domain';
    }

    String firstTwo = name.substring(0, 2);
    String lastTwo = name.substring(name.length - 2);
    String masked = '*' * (name.length - 4);

    return '$firstTwo$masked$lastTwo@$domain';
  }


  Widget shimmderBox() {
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
