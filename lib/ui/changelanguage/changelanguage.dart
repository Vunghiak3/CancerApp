import 'package:flutter/material.dart';
import 'package:testfile/main.dart';
import 'package:testfile/ui/welcompage/welcome.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeLanguagePage extends StatefulWidget {
  const ChangeLanguagePage({super.key});

  @override
  State<ChangeLanguagePage> createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  int _selectedIndex = 0;
  Locale? _currentLocale;

  final List<Map<String, dynamic>> _languages = [
    {"flag": "🇺🇸", "name": "English (US)", "sub": "(English)", "locale": Locale('en')},
    {"flag": "🇻🇳", "name": "Tiếng Việt", "sub": "(Vietnamese)", "locale": Locale('vi')},
    {"flag": "🇨🇳", "name": "简体中文", "sub": "(Chinese, Simplified)", "locale": Locale('zh')},
    {"flag": "🇯🇵", "name": "日本語", "sub": "(Japanese)", "locale": Locale('ja')},
    {"flag": "🇰🇷", "name": "한국어", "sub": "(Korean)", "locale": Locale('ko')},
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Lấy Locale hiện tại
    _currentLocale = Localizations.localeOf(context);

    // Tìm chỉ số của ngôn ngữ hiện tại trong danh sách _languages
    for (int i = 0; i < _languages.length; i++) {
      if (_languages[i]["locale"].languageCode == _currentLocale!.languageCode) {
        _selectedIndex = i;
        break;
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.changeLanguage
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check, color: _selectedIndex != -1 &&
                _languages[_selectedIndex]["locale"] != _currentLocale
                ? Colors.red
                : Colors.grey),
            onPressed: _selectedIndex != -1 &&
                _languages[_selectedIndex]["locale"] != _currentLocale
                ? () {
              Locale selectedLocale = _languages[_selectedIndex]["locale"];
              CancerApp.setLocale(context, selectedLocale);
              nextPage(context, WelcomePage());
            }
                : null, // Disable khi không chọn ngôn ngữ hoặc chọn trùng với ngôn ngữ hiện tại
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: _languages.length,
          itemBuilder: (context, index){
            bool isSelected = index == _selectedIndex;
            return GestureDetector(
              onTap: (){
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? Colors.red : Colors.grey.shade300,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Text(_languages[index]["flag"]!, style: const TextStyle(fontSize: 24)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _languages[index]["name"]!,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(_languages[index]["sub"]!, style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
