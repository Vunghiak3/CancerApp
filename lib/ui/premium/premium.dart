import 'package:flutter/material.dart';

class PremiumPage extends StatefulWidget {
  const PremiumPage({super.key});

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  int _selectedIndex = 0;
  
  final List<Widget> _tabs = [
    const TabForMonth(),
    const TabForYear()
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD9D9D9),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Premium Plans'
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: TabPremium(
                selectedIndex: _selectedIndex,
                onTabSelected: _onTabSelected
            ),
          ),
          Expanded(
            child: _tabs[_selectedIndex],
          ),
        ],
      ),
    );
  }
}


class TabPremium extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const TabPremium({super.key, required this.selectedIndex, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTabItem('Theo tháng', 0),
          _buildTabItem('Theo năm - 30%', 1),
        ],
      ),
    );
  }

  Widget _buildTabItem (String title, int index){
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 150,
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: index == 0 ? Radius.circular(10) : Radius.zero,
                  bottomLeft: index == 0 ? Radius.circular(10) : Radius.zero,
                  topRight: index == 1 ? Radius.circular(10) : Radius.zero,
                  bottomRight: index == 1 ? Radius.circular(10) : Radius.zero,
                )
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? Colors.blue : Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TabForMonth extends StatelessWidget {
  const TabForMonth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD9D9D9),
      body: Text('for month'),
    );
  }
}

class TabForYear extends StatelessWidget {
  const TabForYear({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD9D9D9),
      body: Text('for year'),
    );
  }
}


