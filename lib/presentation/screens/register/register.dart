import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:testfile/presentation/screens/home/home.dart';
import 'package:testfile/presentation/screens/login/login.dart';
import 'package:testfile/presentation/widgets/ButtonImage.dart';
import 'package:testfile/presentation/widgets/CustomTopNotification.dart';
import 'package:testfile/presentation/widgets/InputInfor.dart';
import 'package:testfile/services/auth.dart';
import 'package:testfile/theme/text_styles.dart';
import 'package:testfile/utils/navigation_helper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  Map<String, String> errors = {
    'name': '',
    'email': '',
    'password': '',
    'confirm_password': '',
  };


  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  void fetchRegister() async{
    setState(() {
      _isLoading = true;
      errors = {'name': '', 'email': '', 'password': '', 'confirm_password': ''};
    });

    try{
      final authService = AuthService();
      await authService.register(
        nameController.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim(),
        confirmPasswordController.text.trim(),
      );

      CustomTopNotification.show(
        context,
        message: AppLocalizations.of(context)!.registerSuccess,
      );

      NavigationHelper.nextPageRemoveUntil(context, LoginPage());
    }catch(e){
      print(e);
      final errorResponse = jsonDecode(e.toString())['detail'];
      handleError(errorResponse);
    }finally{
      setState(() {
        _isLoading = false;
      });
    }
  }

  void fetchLoginGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
        serverClientId: dotenv.env['CLIENT_ID_GOOGLE']);
    await googleSignIn.signOut();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      print('Dang nhap bi huy!');
      return;
    }

    final GoogleSignInAuthentication googleAuth =
    await googleUser!.authentication;
    final idToken = googleAuth.idToken;

    if (idToken == null) {
      print('Khong lay duoc token id!');
      return;
    }

    try {
      final authService = AuthService();
      await authService.loginGoogle(idToken!);
      NavigationHelper.nextPageReplace(context, HomeScreen());
    } catch (e) {
      CustomTopNotification.show(context, message: AppLocalizations.of(context)!.registerFail, icon: Icons.cancel, color: Colors.red);
      throw Exception(e);
    }
  }

  void handleError(dynamic errorResponse){
    String error = '';
    if(errorResponse is List){
      error = errorResponse[0]['msg'];
      final field = errorResponse[0]['loc'][1];
      setState(() {
        errors[field] = '$error!';
      });
    }else{
      error = errorResponse.toString();
      setState(() {
        errors['confirm_password'] = '$error!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF2567E8),
                Color(0xFF1CE6DA),
              ],
            )
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: IntrinsicHeight(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Màu bóng mờ
                      blurRadius: 10, // Độ mờ của bóng
                      spreadRadius: 2, // Độ lan của bóng
                      offset: Offset(0, 5), // Dịch xuống dưới 5px
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getHeader(),
                            const SizedBox(height: 10,),
                            InputInfor(
                              label: AppLocalizations.of(context)!.name,
                              inputType: TextInputType.text,
                              controller: nameController,
                              textError: errors['name'],
                            ),
                            const SizedBox(height: 10,),
                            InputInfor(
                              label: AppLocalizations.of(context)!.email,
                              inputType: TextInputType.emailAddress,
                              controller: emailController,
                              textError: errors['email'],
                            ),
                            const SizedBox(height: 10,),
                            InputInfor(
                              label: AppLocalizations.of(context)!.password,
                              inputType: TextInputType.visiblePassword,
                              isPassword: true,
                              controller: passwordController,
                              textError: errors['password'],
                            ),
                            const SizedBox(height: 10,),
                            InputInfor(
                              label: AppLocalizations.of(context)!.confirmPassword,
                              inputType: TextInputType.visiblePassword,
                              isPassword: true,
                              controller: confirmPasswordController,
                              textError: errors['confirm_password'],
                            ),
                            const SizedBox(height: 20,),
                            _isLoading
                              ? Center(child: CircularProgressIndicator(),)
                              : ElevatedButton(
                              onPressed: fetchRegister,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF0E70CB),
                                  minimumSize: Size(double.infinity, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  )
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.signUp,
                                style: TextStyle(
                                    fontSize: AppTextStyles.sizeTitle,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Center(
                              child: Text(
                                AppLocalizations.of(context)!.orSignupWith,
                                style: TextStyle(
                                  fontSize: AppTextStyles.sizeContent,
                                  color: Color(0xFF595959),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Wrap(
                        spacing: 20,
                        alignment: WrapAlignment.center,
                        children: [
                          ButtonImage(onPressed: fetchLoginGoogle),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getHeader(){
    return Center(
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.signUp,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                text: "${AppLocalizations.of(context)!.haveAccount} ",
                style: TextStyle(
                  fontSize: AppTextStyles.sizeTitle,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: AppLocalizations.of(context)!.login,
                    style: TextStyle(
                      fontSize: AppTextStyles.sizeTitle,
                      color: Color(0xFF0866FF),
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        NavigationHelper.nextPage(context, LoginPage());
                      },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
