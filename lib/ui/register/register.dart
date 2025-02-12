import 'package:flutter/material.dart';
import 'package:testfile/ui/login/login.dart';
import 'package:testfile/ui/welcompage/welcome.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

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
                          Text(
                            "Sign up",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Already have an account?',
                                style: TextStyle(
                                    fontSize: 18
                                ),
                              ),
                              TextButton(
                                onPressed: (){
                                  nextPage(context, LoginPage());
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Color(0xFF0866FF),
                                      fontSize: 18
                                  ),
                                ),
                              )
                            ],
                          ),
                          Text('Name'),
                          TextField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text('Email'),
                          TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10,),

                          Text('Password'),
                          TextField(
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                  onPressed: ()=> setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  }),
                                  icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off,),
                              )
                            ),
                          ),
                          SizedBox(height: 10,),

                          Text('Confirm Password'),
                          TextField(
                            obscureText: !_isConfirmPasswordVisible,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                  onPressed: ()=> setState(() {
                                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                                  }),
                                  icon: Icon(_isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off)
                              )
                            ),
                          ),
                          SizedBox(height: 20,),
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
                              'Sign up',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Center(
                            child: Text(
                              'or sign up with',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF595959),
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: (){},
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(90, 50),
                              backgroundColor: Color(0xFFEEEEEE),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                          child: const Icon(Icons.grade_outlined),
                        ),ElevatedButton(
                          onPressed: (){},
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(90, 50),
                              backgroundColor: Color(0xFFEEEEEE),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                          child: const Icon(Icons.grade_outlined),
                        ),ElevatedButton(
                          onPressed: (){},
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(90, 50),
                              backgroundColor: Color(0xFFEEEEEE),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                          child: const Icon(Icons.grade_outlined),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
