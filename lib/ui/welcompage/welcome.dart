import 'package:flutter/material.dart';
import 'package:testfile/ui/login/login.dart';
import 'package:testfile/ui/register/register.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
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
          child: Column(
            children: [
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Curely",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontStyle: FontStyle.italic
                            ),
                          ),
                          const SizedBox(width: 5,),
                          Image.asset(
                            'assets/imgs/logowelcome.png',
                            color: Colors.white,
                            width: 50,
                            height: 50,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5,),
                      const Text(
                        "Early Caner Detection, Better \nProtection, Healthier Lives.",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
              ),
              buildButton(context: context, text: 'Login', onPressed: (){nextPage(context, LoginPage());}),
              const SizedBox(height: 10,),
              buildButton(context: context, text: 'Register', onPressed: (){nextPage(context, RegisterPage());}),
              const SizedBox(height: 50,)
            ],
          )
      ),
    );
  }

  Widget buildButton({required BuildContext context, required String text, required VoidCallback onPressed}){
    return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF1D61E7),
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              textStyle: TextStyle(fontSize: 18),
            ),
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        )
    );
  }
}


void nextPage(BuildContext context, Widget page){
  Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page)
  );
}