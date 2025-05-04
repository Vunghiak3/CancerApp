import 'package:flutter/material.dart';

import 'package:testfile/presentation/screens/chooseCancer/chooseCancer.dart';
import 'package:testfile/presentation/screens/history/history.dart';
import 'package:testfile/presentation/screens/message/message.dart';
import 'package:testfile/presentation/screens/profile/profile.dart';
import 'package:testfile/presentation/widgets/ImagePickerHelper.dart';
import 'package:testfile/presentation/widgets/TipCarousel.dart';

import 'package:testfile/utils/navigation_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testfile/theme/text_styles.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_tabs.isEmpty) {
      _tabs.add(_buildHomeTab());
      _tabs.add(Container());
      _tabs.add(Container());
      _tabs.add(HistoryPage());
      _tabs.add(ProfilePage());
    }
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      NavigationHelper.nextPage(context, MessagePage());
    } else if (index == 2) {
      onSelectImage();
    } else if (index < _tabs.length) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabs = [
      _buildHomeTab(),
      Container(),
      Container(),
      HistoryPage(),
      ProfilePage(),
    ];

    return Scaffold(
      body: tabs[_selectedIndex],
      bottomNavigationBar: Container(
        height: 75,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFF0E70CB),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          iconSize: AppTextStyles.sizeIcon,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: _selectedIndex == 0
                  ? Icon(Icons.home_rounded)
                  : Icon(Icons.home_outlined),
              label: AppLocalizations.of(context)!.home,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message_outlined),
              label: AppLocalizations.of(context)!.chat,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.file_upload_rounded, color: Colors.red),
              label: AppLocalizations.of(context)!.diagnose,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_rounded),
              label: AppLocalizations.of(context)!.history,
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == _tabs.length - 1
                  ? Icon(Icons.person_rounded)
                  : Icon(Icons.person_outline),
              label: AppLocalizations.of(context)!.profile,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeTab() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.curely,
              style: TextStyle(
                color: Color(0xFF0E70CB),
                fontSize: 44,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(width: 10),
            Image.asset(
              'assets/imgs/logo_app_1.png',
              color: Color(0xFF0E70CB),
              width: 45,
              height: 45,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ── your top feature buttons ──
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _FeatureBox(
                  icon: Icons.health_and_safety,
                  label: AppLocalizations.of(context)!.aiDiagnosis,
                  onTap: onSelectImage,
                ),
                _FeatureBox(
                  icon: Icons.chat,
                  label: AppLocalizations.of(context)!.chatWithAI,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => MessagePage()),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ── Header ──
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context)!.dailyHealthTips,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),

            const SizedBox(height: 12),

            // ── Carousel ──
            Expanded(
              child: TipCarousel(),
            ),
          ],
        ),
      ),
    );
  }

  void onSelectImage() {
    ImagePickerHelper.showImagePickerDialog(context, (image) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChooseCancerPage(selectedImage: image)),
      );
    });
  }
}

class _FeatureBox extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _FeatureBox(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: Color(0xFFEDF4FF),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
        child: Column(
          children: [
            Icon(icon, size: 40, color: Color(0xFF0E70CB)),
            const SizedBox(height: 10),
            Text(label,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
