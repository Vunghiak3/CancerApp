import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:testfile/presentation/screens/home/home.dart';
import 'package:testfile/presentation/screens/register/register.dart';
import 'package:testfile/presentation/widgets/InputInfor.dart';
import 'package:testfile/services/auth.dart';
import 'package:testfile/theme/text_styles.dart';
import 'package:testfile/utils/navigation_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Map<String, String> errors = {
    'email': '',
    'password': '',
  };

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  void fetchLogin() async{
    setState(() {
      _isLoading = true;
      errors = {'email': '', 'password': ''};
    });

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    try{
      final authService = AuthService();
      await authService.login(email, password);

      NavigationHelper.nextPageReplace(context, HomeScreen());
    }catch(e){
      final errorResponse = jsonDecode(e.toString())['detail'];
      handleError(errorResponse);
    }finally{
      setState(() {
        _isLoading = false;
      });
    }
  }

  void fetchLoginGoogle() async{
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['email', 'profile'],
      serverClientId: '968583952916-4viga6hcqn696fa3devfo0f7rt05s5p3.apps.googleusercontent.com'
    );
    await googleSignIn.signOut();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if(googleUser == null){
      print('Dang nhap bi huy!');
      return;
    }

    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    final idToken = googleAuth.idToken;

    if(idToken == null){
      print('Khong lay duoc token id!');
      return;
    }

    try {
      final authService = AuthService();
      await authService.loginGoogle(idToken!);
      NavigationHelper.nextPageReplace(context, HomeScreen());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đăng nhập thất bại!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void handleError(dynamic errorResponse){
    String error= '';
    if(errorResponse is List){
      error = errorResponse[0]['msg'];
      final field = errorResponse[0]['loc'][1];
      setState(() {
        errors[field] = '$error!';
      });
    }else{
      error = errorResponse.toString();
      setState(() {
        errors['password'] = '$error!';
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
            )),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 140),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 10),
                    InputInfor(
                      label: AppLocalizations.of(context)!.email,
                      inputType: TextInputType.emailAddress,
                      controller: emailController,
                      textError: errors['email'],
                    ),
                    const SizedBox(height: 20),
                    InputInfor(
                      label: AppLocalizations.of(context)!.password,
                      inputType: TextInputType.visiblePassword,
                      isPassword: true,
                      controller: passwordController,
                      textError: errors['password'],
                    ),
                    const SizedBox(height: 30),
                    _isLoading
                      ? Center(child: CircularProgressIndicator(),)
                      : ElevatedButton(
                      onPressed: fetchLogin,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF0E70CB),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          minimumSize: Size(double.infinity, 50)),
                      child: Text(
                        AppLocalizations.of(context)!.login,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: AppTextStyles.sizeTitle,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      AppLocalizations.of(context)!.orLoginWith,
                      style: TextStyle(
                        fontSize: AppTextStyles.sizeContent,
                        color: Color(0xFF595959),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildSocialButtons(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Text(
            AppLocalizations.of(context)!.login,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "${AppLocalizations.of(context)!.dontHaveAccount} ",
              style: TextStyle(
                fontSize: AppTextStyles.sizeTitle,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: AppLocalizations.of(context)!.signUp,
                  style: TextStyle(
                    fontSize: AppTextStyles.sizeTitle,
                    color: Color(0xFF0866FF),
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      NavigationHelper.nextPage(context, RegisterPage());
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButtons(){
    double sizeLogo = 20;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: fetchLoginGoogle,
          style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFEEEEEE),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))
          ),
          child: Image.asset(
            'assets/imgs/google.png',
            width: sizeLogo,
            height: sizeLogo,
          ),
        ),
        const SizedBox(width: 20,),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFEEEEEE),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))
          ),
          child: Image.asset(
            'assets/imgs/facebook.png',
            width: sizeLogo,
            height: sizeLogo,
          ),
        ),
      ],
    );
  }
}
