import 'package:flutter/material.dart';
import 'package:testfile/data/dailyTip.dart';
import 'package:testfile/presentation/widgets/TipCard.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TipCarousel extends StatefulWidget {
  const TipCarousel({Key? key}) : super(key: key);

  @override
  State<TipCarousel> createState() => _TipCarouselState();
}

class _TipCarouselState extends State<TipCarousel> {
  int _selectedCategoryIndex = 0;
  late PageController _pageController;
  late int _dailyTipIndex;



  @override
  void initState() {
    super.initState();
    _updateDailyTipIndex();
    _pageController = PageController(initialPage: _dailyTipIndex);
  }

  void _updateDailyTipIndex() {
    final today = DateTime.now();
    final tips = _selectedCategoryIndex == 0
        ? CancerTips.lungCancerTips
        : CancerTips.brainCancerTips;

    // Use a hash of date to cycle through tips
    _dailyTipIndex = today.day % tips.length;
  }

  @override
  void didUpdateWidget(covariant TipCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateDailyTipIndex();
    _pageController.jumpToPage(_dailyTipIndex);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [AppLocalizations.of(context)!.lungCancer, AppLocalizations.of(context)!.brainCancer];

    final tips = _selectedCategoryIndex == 0
        ? CancerTips.lungCancerTips
        : CancerTips.brainCancerTips;

    // Recalculate tip index if category changes
    _dailyTipIndex = DateTime.now().day % tips.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: ToggleButtons(
            isSelected: List.generate(
              categories.length,
              (index) => index == _selectedCategoryIndex,
            ),
            onPressed: (index) {
              setState(() {
                _selectedCategoryIndex = index;
                _updateDailyTipIndex();
                _pageController.jumpToPage(_dailyTipIndex);
              });
            },
            borderRadius: BorderRadius.circular(12),
            selectedColor: Colors.white,
            fillColor: Theme.of(context).primaryColor,
            color: Theme.of(context).primaryColor,
            textStyle: Theme.of(context).textTheme.bodyLarge,
            children: categories
                .map((category) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(category),
                    ))
                .toList(),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: tips.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return FractionallySizedBox(
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    color: Colors.white,
                    child: TipCard(tip: tips[index]),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
