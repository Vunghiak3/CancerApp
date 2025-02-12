import 'package:flutter/material.dart';

// class ChangelanguagePage extends StatelessWidget {
//   const ChangelanguagePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           'Change Language'
//         ),
//       ),
//       body: ListView.builder(itemBuilder: itemBuilder),
//     );
//   }
// }

class ChangeLanguagePage extends StatefulWidget {
  const ChangeLanguagePage({super.key});

  @override
  State<ChangeLanguagePage> createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  int _selectedIndex = 0;

  final List<Map<String, String>> _languages = [
    {"flag": "🇺🇸", "name": "English (US)", "sub": "(English)"},
    {"flag": "🇻🇳", "name": "Tiếng Việt", "sub": "(Vietnamese)"},
    {"flag": "🇨🇳", "name": "简体中文", "sub": "(Chinese, Simplified)"},
    {"flag": "🇯🇵", "name": "日本語", "sub": "(Japanese)"},
    {"flag": "🇫🇷", "name": "Francais", "sub": "(French)"},
    {"flag": "🇷🇺", "name": "Русский", "sub": "(Russian)"},
    {"flag": "🇮🇹", "name": "Italiano", "sub": "(Italian)"},
    {"flag": "🇰🇷", "name": "한국어", "sub": "(Korean)"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Change Language'
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.red),
            onPressed: () {}, // Xử lý xác nhận chọn ngôn ngữ
          )
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
