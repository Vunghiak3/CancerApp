import 'package:flutter/material.dart';
import 'package:testfile/presentation/widgets/MenuWidget.dart';
import 'package:testfile/ui/changelanguage/changelanguage.dart';
import 'package:testfile/ui/welcompage/welcome.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testfile/utils/navigation_helper.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    double sizeIcon = 25;

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
                // Container(
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(5),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.black.withOpacity(0.2),
                //         blurRadius: 10,
                //         spreadRadius: 2,
                //         offset: Offset(0, 4),
                //       ),
                //     ],
                //   ),
                //   margin: const EdgeInsets.symmetric(vertical: 40),
                //   child: Column(
                //     children: [
                //       ElevatedButton(
                //           onPressed: (){},
                //           style: ElevatedButton.styleFrom(
                //             shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(0)
                //             ),
                //             backgroundColor: Colors.white,
                //             elevation: 0,
                //           ),
                //           child: Padding(
                //             padding: const EdgeInsets.symmetric(vertical: 20.0),
                //             child: Row(
                //               children: [
                //                 Container(
                //                   decoration: BoxDecoration(
                //                     color: Color(0xFFF2F2FB),
                //                     shape: BoxShape.circle,
                //                   ),
                //                   margin: EdgeInsets.only(right: 20),
                //                   child: Padding(
                //                     padding: const EdgeInsets.all(8.0),
                //                     child: Icon(
                //                       Icons.person_outline,
                //                       color: Color(0xFF0601B4),
                //                       size: sizeIcon,
                //                     ),
                //                   ),
                //                 ),
                //                 Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     Text(
                //                       AppLocalizations.of(context)!.savedBeneficiary,
                //                       style: TextStyle(
                //                           color: Colors.black,
                //                           fontSize: 18
                //                       ),
                //                     ),
                //                     Text(
                //                       AppLocalizations.of(context)!.desSavedBeneficiary,
                //                       style: TextStyle(
                //                           color: Color(0xFFABABAB)
                //                       ),
                //                     )
                //                   ],
                //                 ),
                //                 Spacer(),
                //                 Icon(Icons.arrow_forward_ios_rounded, color: Colors.black,)
                //               ],
                //             ),
                //           )
                //       ),
                //       ElevatedButton(
                //           onPressed: (){},
                //           style: ElevatedButton.styleFrom(
                //             shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(0)
                //             ),
                //             backgroundColor: Colors.white,
                //             elevation: 0,
                //           ),
                //           child: Padding(
                //             padding: const EdgeInsets.symmetric(vertical: 20.0),
                //             child: Row(
                //               children: [
                //                 Container(
                //                   decoration: BoxDecoration(
                //                     color: Color(0xFFF2F2FB),
                //                     shape: BoxShape.circle,
                //                   ),
                //                   margin: EdgeInsets.only(right: 20),
                //                   child: Padding(
                //                     padding: const EdgeInsets.all(8.0),
                //                     child: Icon(
                //                       Icons.delete_outline,
                //                       color: Colors.red,
                //                       size: sizeIcon,
                //                     ),
                //                   ),
                //                 ),
                //                 Expanded(
                //                   flex: 7,
                //                   child: Column(
                //                     crossAxisAlignment: CrossAxisAlignment.start,
                //                     children: [
                //                       Text(
                //                         AppLocalizations.of(context)!.deleteAccount,
                //                         style: TextStyle(
                //                             color: Colors.red,
                //                             fontSize: 18
                //                         ),
                //                       ),
                //                       Text(
                //                         AppLocalizations.of(context)!.desDeleteAccount,
                //                         style: TextStyle(
                //                             color: Color(0xFFABABAB)
                //                         ),
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //                 Spacer(),
                //                 Icon(Icons.arrow_forward_ios_rounded, color: Colors.black,)
                //               ],
                //             ),
                //           )
                //       ),
                //     ],
                //   ),
                // ),
                MenuWidget(
                    items: [
                      MenuItem(
                          text: AppLocalizations.of(context)!.savedBeneficiary,
                          subText: AppLocalizations.of(context)!.desSavedBeneficiary,
                          icon: Icons.person_outline_rounded,
                          onTap: (){}
                      ),
                      MenuItem(
                          text: AppLocalizations.of(context)!.deleteAccount,
                          subText: AppLocalizations.of(context)!.desDeleteAccount,
                          icon: Icons.delete_outline_rounded,
                          colorIcon: Colors.red,
                          onTap: (){}
                      ),
                    ]
                ),
                const SizedBox(height: 30,),
                MenuWidget(
                    title: AppLocalizations.of(context)!.more,
                    items: [
                      MenuItem(
                          text: AppLocalizations.of(context)!.helpSupport,
                          icon: Icons.notifications_none_outlined,
                          onTap: (){}
                      ),
                      MenuItem(
                          text: AppLocalizations.of(context)!.changeLanguage,
                          icon: Icons.language_rounded,
                          colorIcon: Colors.black,
                          onTap: (){
                            NavigationHelper.nextPage(context, ChangeLanguagePage());
                          }
                      ),
                      MenuItem(
                          text: AppLocalizations.of(context)!.aboutApp,
                          icon: Icons.favorite_border_outlined,
                          onTap: (){}
                      ),
                    ]
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
