import 'package:flutter/material.dart';
import 'package:testfile/ui/changelanguage/changelanguage.dart';
import 'package:testfile/ui/welcompage/welcome.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

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
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
        elevation: 0,
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 18,)
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
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
                  margin: const EdgeInsets.symmetric(vertical: 40),
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
                                      AppLocalizations.of(context)!.savedBeneficiary,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.desSavedBeneficiary,
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
                                        AppLocalizations.of(context)!.deleteAccount,
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 18
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.desDeleteAccount,
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
                      AppLocalizations.of(context)!.more,
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
                                      AppLocalizations.of(context)!.helpSupport,
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
                                        AppLocalizations.of(context)!.changeLanguage,
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
                                      AppLocalizations.of(context)!.aboutApp,
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
      ),
    );
  }
}
