import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testfile/presentation/screens/home/home.dart';
import 'package:testfile/presentation/screens/register/register.dart';
import 'package:testfile/presentation/widgets/InputTextField.dart';
import 'package:testfile/theme/text_styles.dart';
import 'package:testfile/utils/navigation_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  double sizeLogo = 20;

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
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 10),
                    _buildInputField(AppLocalizations.of(context)!.email, TextInputType.emailAddress, false),
                    const SizedBox(height: 20),
                    _buildInputField(AppLocalizations.of(context)!.password, TextInputType.visiblePassword, true),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ElevatedButton(
                        onPressed: () {
                          NavigationHelper.nextPageReplace(context, HomeScreen());
                        },
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

  Widget _buildInputField(String label, TextInputType inputType, bool isPassword){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.content,
          ),
          TextField(
            obscureText: isPassword && !_isPasswordVisible,
            style: AppTextStyles.content,
            keyboardType: inputType,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              suffixIcon: isPassword ? IconButton(
                icon: Icon(
                  _isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  size: AppTextStyles.sizeIcon,
                ),
                onPressed: () => setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                }),
              ) : null,
            ),
          )
        ],
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {},
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

void returnPage(BuildContext context) {
  Navigator.pop(context);
}
