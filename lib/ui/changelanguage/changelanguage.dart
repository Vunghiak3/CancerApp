import 'package:flutter/material.dart';
import 'package:testfile/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeLanguagePage extends StatefulWidget {
  const ChangeLanguagePage({super.key});

  @override
  State<ChangeLanguagePage> createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  int _selectedIndex = 0;
  Locale? _currentLocale;

  static const List<Map<String, dynamic>> _languages = [
    {"flag": "🇺🇸", "name": "English (US)", "sub": "(English)", "locale": Locale('en')},
    {"flag": "🇻🇳", "name": "Tiếng Việt", "sub": "(Vietnamese)", "locale": Locale('vi')},
    {"flag": "🇨🇳", "name": "简体中文", "sub": "(Chinese, Simplified)", "locale": Locale('zh')},
    {"flag": "🇯🇵", "name": "日本語", "sub": "(Japanese)", "locale": Locale('ja')},
    {"flag": "🇰🇷", "name": "한국어", "sub": "(Korean)", "locale": Locale('ko')},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _currentLocale = Localizations.localeOf(context);
      _selectedIndex = _languages.indexWhere((lang) => lang["locale"].languageCode == _currentLocale?.languageCode);
      if (_selectedIndex == -1) _selectedIndex = 0; // Mặc định nếu không tìm thấy
      setState(() {});
    });
  }

  void _changeLanguage() {
    final selectedLocale = _languages[_selectedIndex]["locale"] as Locale;
    if (selectedLocale != _currentLocale) {
      CancerApp.setLocale(context, selectedLocale);
      Navigator.pop(context);
    }
  }

  PreferredSizeWidget _buildAppBar() {
    final isChanged = _languages[_selectedIndex]["locale"] != _currentLocale;
    return AppBar(
      title: Text(AppLocalizations.of(context)!.changeLanguage, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.check, color: isChanged ? Colors.red : Colors.grey),
          onPressed: isChanged ? _changeLanguage : null,
        ),
      ],
    );
  }

  Widget _buildLanguageItem(int index) {
    final lang = _languages[index];
    final isSelected = index == _selectedIndex;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? Colors.red : Colors.grey.shade300, width: isSelected ? 2 : 1),
        ),
        child: Row(
          children: [
            Text(lang["flag"]!, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 12),
            Expanded(child: Text(lang["name"]!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
            Text(lang["sub"]!, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ListView.builder(
        itemCount: _languages.length,
        itemBuilder: (context, index) => _buildLanguageItem(index),
      ),
    );
  }
}
