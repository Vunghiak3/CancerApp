import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:testfile/ui/login/login.dart';
import 'package:testfile/ui/welcompage/welcome.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              margin: EdgeInsets.symmetric(vertical: 70),
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
                    IconButton(
                      onPressed: ()=>returnPage(context),
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeader(),
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
                              nextPage(context, LoginPage());
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
                                  fontSize: 20,
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
                                fontSize: 15,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                fontSize: 18,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: AppLocalizations.of(context)!.login,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF0866FF),
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      nextPage(context, LoginPage());
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputField(String label, TextInputType inputType, bool isPassword){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextField(
          obscureText: isPassword && !_isPasswordVisible,
          keyboardType: inputType,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            suffixIcon: isPassword ? IconButton(
              icon: Icon(
                _isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
