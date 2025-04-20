class DailyTip {
  final String title;
  final String description;
  final String source;

  DailyTip({
    required this.title,
    required this.description,
    required this.source,
  });
}

class CancerTips {
  static final List<DailyTip> lungCancerTips = [
    DailyTip(
      title: "Quit Smoking",
      description:
          "Ceasing smoking improves lung function and reduces the risk of cancer progression.",
      source: "Johns Hopkins Medicine",
    ),
    DailyTip(
      title: "Avoid Secondhand Smoke",
      description:
          "Secondhand smoke contains carcinogens that can harm lung health.",
      source: "CDC",
    ),
    DailyTip(
      title: "Test for Radon",
      description:
          "Radon exposure increases lung cancer risk; test your home to ensure safety.",
      source: "CDC",
    ),
    DailyTip(
      title: "Eat a Balanced Diet",
      description:
          "A diet rich in fruits and vegetables supports overall health during treatment.",
      source: "Johns Hopkins Medicine",
    ),
    DailyTip(
      title: "Engage in Physical Activity",
      description: "Regular exercise can reduce fatigue and improve mood.",
      source: "Johns Hopkins Medicine",
    ),
    DailyTip(
      title: "Practice Relaxation Techniques",
      description:
          "Techniques like deep breathing and visualization can alleviate stress.",
      source: "Roy Castle Lung Cancer Foundation",
    ),
    DailyTip(
      title: "Maintain a Sleep Routine",
      description: "Quality sleep aids in recovery and emotional well-being.",
      source: "Roy Castle Lung Cancer Foundation",
    ),
  ];

  static final List<DailyTip> brainCancerTips = [
    DailyTip(
      title: "Practice Mindfulness",
      description:
          "Mindfulness exercises can help manage stress and improve focus.",
      source: "Tisch Brain Tumor Center",
    ),
    DailyTip(
      title: "Engage in Gentle Yoga",
      description: "Yoga can enhance flexibility and reduce tension.",
      source: "Tisch Brain Tumor Center",
    ),
    DailyTip(
      title: "Maintain a Balanced Diet",
      description: "Proper nutrition supports energy levels and recovery.",
      source: "The Brain Tumour Charity",
    ),
    DailyTip(
      title: "Stay Positive",
      description: "Focusing on positive aspects can improve mental health.",
      source: "National Cancer Institute",
    ),
    DailyTip(
      title: "Seek Support",
      description: "Connecting with others can provide emotional relief.",
      source: "Johns Hopkins Medicine",
    ),
    DailyTip(
      title: "Set Daily Intentions",
      description: "Positive affirmations can foster a hopeful mindset.",
      source: "National Cancer Institute",
    ),
    DailyTip(
      title: "Engage in Light Exercise",
      description: "Activities like walking can boost mood and energy.",
      source: "The Brain Tumour Charity",
    ),
  ];
}
