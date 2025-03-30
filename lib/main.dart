import 'package:flutter/material.dart';
import 'package:testfile/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testfile/presentation/screens/login/login.dart';

void main() => runApp(const CancerApp());

class CancerApp extends StatefulWidget {
  const CancerApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale){
    _CancerAppState? state = context.findAncestorStateOfType<_CancerAppState>();
    state?.changeLanguage(newLocale);
  }

  @override
  State<CancerApp> createState() => _CancerAppState();
}

class _CancerAppState extends State<CancerApp> {
  Locale _locale = const Locale('en');

  void changeLanguage(Locale locale){
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cancer App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.normal),
          bodySmall: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.normal),
          titleLarge: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        )
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
      supportedLocales: L10n.all,
      locale: _locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }
}


