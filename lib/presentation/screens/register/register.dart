import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testfile/presentation/screens/login/login.dart';
import 'package:testfile/theme/text_styles.dart';
import 'package:testfile/utils/navigation_helper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
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
            )
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 90),
              width: double.infinity,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeader(),
                          const SizedBox(height: 10,),
                          _buildInputField(AppLocalizations.of(context)!.name, TextInputType.text, false),
                          const SizedBox(height: 10,),
                          _buildInputField(AppLocalizations.of(context)!.email, TextInputType.emailAddress, false),
                          const SizedBox(height: 10,),
                          _buildInputField(AppLocalizations.of(context)!.password, TextInputType.visiblePassword, true),
                          const SizedBox(height: 10,),
                          _buildInputField(AppLocalizations.of(context)!.confirmPassword, TextInputType.visiblePassword, true),
                          const SizedBox(height: 20,),
                          ElevatedButton(
                            onPressed: (){
                              NavigationHelper.nextPageRemoveUntil(context, LoginPage());
                            },
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
                          const SizedBox(height: 20,),
                        ],
                      ),
                    ),
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

  Widget _buildInputField(String label, TextInputType inputType, bool isPassword){
    return Column(
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
                  borderRadius: BorderRadius.circular(10))),
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
                  borderRadius: BorderRadius.circular(10))),
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
