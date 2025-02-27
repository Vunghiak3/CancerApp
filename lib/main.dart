import 'package:flutter/material.dart';
import 'package:testfile/l10n/l10n.dart';
import 'package:testfile/ui/welcompage/welcome.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() => runApp(const CancerApp());

// class CancerApp extends StatelessWidget {
//   const CancerApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Cancer App',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
//         useMaterial3: true,
//       ),
//       home: WelcomePage(),
//       debugShowCheckedModeBanner: false,
//       supportedLocales: L10n.all,
//       locale: const Locale('en'),
//       localizationsDelegates: AppLocalizations.localizationsDelegates,
//     );
//   }
// }

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
      ),
      home: WelcomePage(),
      debugShowCheckedModeBanner: false,
      supportedLocales: L10n.all,
      locale: _locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }
}


