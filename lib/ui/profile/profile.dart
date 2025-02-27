import 'package:flutter/material.dart';
import 'package:testfile/ui/editprofile/editprofile.dart';
import 'package:testfile/ui/premium/premium.dart';
import 'package:testfile/ui/setting/setting.dart';
import 'package:testfile/ui/welcompage/welcome.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.profile,
        ),
        actions: [
          IconButton(
              onPressed: (){
                nextPage(context, SettingPage());
              },
              icon: Icon(Icons.settings)
          )
        ],
        leading: IconButton(
            onPressed: (){},
            icon: Icon(Icons.menu)
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
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
                        onPressed: (){
                          nextPage(context, EditProfilePage());
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
                                    Icons.person_outline,
                                    color: Color(0xFF0601B4),
                                    size: 30,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.myAccount,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.desMyAccount,
                                      style: TextStyle(
                                        color: Color(0xFFABABAB)
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Spacer(),
                              const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black,)
                            ],
                          ),
                        )
                    ),
                    ElevatedButton(
                        onPressed: (){
                          nextPage(context, PremiumPage());
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
                                    Icons.workspace_premium,
                                    color: Color(0xFFFF00C8),
                                    size: 30,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.premiumPlans,
                                      style: TextStyle(
                                        color: Color(0xFFFF00C8),
                                        fontSize: 18
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.desPremiumPlans,
                                      style: TextStyle(
                                        color: Color(0xFFABABAB)
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              ),
                              const Spacer(),
                              const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black,)
                            ],
                          ),
                        )
                    ),
                    ElevatedButton(
                        onPressed: (){
                          nextPage(context, WelcomePage());
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
                                margin: EdgeInsets.only(right: 10),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.logout, color: Color(0xFF0601B4), size: 30,),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.logout,
                                      style: TextStyle(
                                        color: Color(0xff555555),
                                        fontSize: 18
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.desLogout,
                                      style: TextStyle(
                                        color: Color(0xFFABABAB)
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Spacer(),
                              const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black,)
                            ],
                          ),
                        )
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
