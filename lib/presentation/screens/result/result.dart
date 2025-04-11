import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testfile/data/brainTumorData.dart';
import 'package:testfile/presentation/screens/home/home.dart';
import 'package:testfile/presentation/screens/message/message.dart';
import 'package:testfile/theme/text_styles.dart';
import 'package:testfile/utils/navigation_helper.dart';

class ResultPage extends StatefulWidget {
  final File? imageFile;
  final String? imageUrl;
  final Map<String, dynamic>? data;
  const ResultPage({super.key, this.imageFile, this.data, this.imageUrl});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  Map<String, dynamic>? cancerData;

  @override
  void initState() {
    super.initState();
    final predictionType = widget.data?['aiPrediction'];
    cancerData = BrainTumorData.brainTumorData[predictionType];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){Navigator.pop(context);},
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: AppTextStyles.sizeIconSmall,)
        ),
        actions: [
          IconButton(
              onPressed: (){
                NavigationHelper.nextPageRemoveUntil(context, HomeScreen());
              },
              icon: Icon(Icons.home_rounded, color: Colors.black, size: AppTextStyles.sizeIcon,)
          )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: widget.imageFile != null
                    ? Image.file(
                      widget.imageFile!,
                      width: double.infinity,
                      height: 350,
                      fit: BoxFit.cover,
                    )
                    : Image.network(
                      widget.imageUrl!,
                      width: double.infinity,
                      height: 350,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        capitalizeFirst(widget.data?["aiPrediction"]),
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                      Text(
                          ' - ${(widget.data!["confidenceScore"]*100).toStringAsFixed(2)}%'
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ...cancerData?.entries.map((entry) => solutionBox(entry.key, entry.value)).toList() ?? [],
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  NavigationHelper.nextPage(context, MessagePage());
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.askAi,
                      style: TextStyle(fontSize: AppTextStyles.sizeContent, color: Colors.white),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.send, color: Colors.white, size: AppTextStyles.sizeIconSmall,),
                  ],
                ),
              ),
          )
        ],
      ),
    );
  }

  Widget solutionBox(String title, dynamic content) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${title[0].toUpperCase()}${title.substring(1)}:",
            style: AppTextStyles.title,
          ),
          SizedBox(height: 8),
          content is List
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: content.map<Widget>((item) => Text("• $item", style: AppTextStyles.content)).toList(),
          )
              : Text(content.toString(), style: AppTextStyles.content),
        ],
      ),
    );
  }

  String capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}
