import 'package:flutter/material.dart';
import 'package:testfile/presentation/screens/changeLanguage/changelanguage.dart';
import 'package:testfile/presentation/screens/login/login.dart';
import 'package:testfile/presentation/widgets/CustomTopNotification.dart';
import 'package:testfile/presentation/widgets/MenuWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testfile/services/auth.dart';
import 'package:testfile/theme/text_styles.dart';
import 'package:testfile/utils/navigation_helper.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  void fetchDeleteAccount(BuildContext context) async {
    try {
      String idToken = await AuthService().getIdToken();
      await AuthService().deleteAccount(idToken);
      NavigationHelper.nextPageRemoveUntil(context, LoginPage());
      CustomTopNotification.show(
        context,
        message: AppLocalizations.of(context)!.deleteSuccess,
      );
    } catch (e) {
      CustomTopNotification.show(
        context,
        message: AppLocalizations.of(context)!.deletionFailed,
        color: Colors.red,
        icon: Icons.cancel
      );
      throw Exception(e);
    }
  }

  void showDeleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text(
              AppLocalizations.of(context)!.confirm,
              style: AppTextStyles.title,
            ),
            content: Text(
              AppLocalizations.of(context)!.desConfirmDeleteAccount,
              style: AppTextStyles.content,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop(); // Đóng dialog
                },
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                  style: AppTextStyles.cancel,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  fetchDeleteAccount(context);
                },
                child: Text(
                    AppLocalizations.of(context)!.delete,
                    style: AppTextStyles.delete
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Transform.translate(
          offset: Offset(-20, 0),
          child: Text(
            AppLocalizations.of(context)!.setting,
            style: AppTextStyles.title,
          ),
        ),
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
              size: AppTextStyles.sizeIconSmall,
            )),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
            child: Column(
              children: [
                MenuWidget(items: [
                  MenuItem(
                      text: AppLocalizations.of(context)!.deleteAccount,
                      subText: AppLocalizations.of(context)!.desDeleteAccount,
                      icon: Icons.delete_outline_rounded,
                      colorIcon: Colors.red,
                      onTap: () {
                        showDeleteDialog(context);
                      }),
                ]),
                const SizedBox(
                  height: 30,
                ),
                MenuWidget(title: AppLocalizations.of(context)!.more, items: [
                  MenuItem(
                      text: AppLocalizations.of(context)!.changeLanguage,
                      icon: Icons.language_rounded,
                      colorIcon: Colors.black,
                      onTap: () {
                        NavigationHelper.nextPage(
                            context, ChangeLanguagePage());
                      }),
                  MenuItem(
                      text: AppLocalizations.of(context)!.aboutApp,
                      icon: Icons.favorite_border_outlined,
                      onTap: () {}),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
