import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testfile/presentation/screens/result/result.dart';
import 'package:testfile/presentation/widgets/GetProgressBar.dart';
import 'package:testfile/services/auth.dart';
import 'package:testfile/services/cnn.dart';
import 'package:testfile/theme/text_styles.dart';
import 'package:testfile/utils/navigation_helper.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<List<dynamic>> futureHistory = fetchHistory();

  Future<List<dynamic>> fetchHistory() async {
    try {
      String idToken = await AuthService().getIdToken();
      final response = await CnnService().history(idToken);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> refreshHistory() async {
    setState(() {
      futureHistory = fetchHistory();
    });
  }

  Future<Map<String, dynamic>> fetchDeleteHistory(String historyId) async {
    try {
      String idToken = await AuthService().getIdToken();
      final response = await CnnService().deleteHistoryById(idToken, historyId);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  void loadViewHistory(Map<String, dynamic> data){
    NavigationHelper.nextPage(context, ResultPage(imageUrl: data['mriImageUrl'], data: data,));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  PreferredSizeWidget getAppBar() {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Text(
        'Lịch sử chẩn đoán',
        style: AppTextStyles.title,
      ),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_horiz_outlined,
              color: Colors.black,
              size: 24,
            ))
      ],
    );
  }

  Widget getBody() {
    return FutureBuilder<List<dynamic>>(
        future: futureHistory,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return GetProgressBar();
          }

          if(snapshot.hasError){
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          }
          final historyData = snapshot.data ?? [];

          return RefreshIndicator(
            backgroundColor: Colors.white,
            onRefresh: refreshHistory,
            child: ListView.separated(
              itemBuilder: (context, position) {
                final diagnose = historyData![position] as Map<String, dynamic>;
                return _HistoryItemSection(
                  parent: this,
                  data: diagnose,
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  color: Colors.grey,
                  thickness: 1,
                  indent: 24,
                  endIndent: 24,
                );
              },
              itemCount: historyData!.length,
              shrinkWrap: true,
            ),
          );
        }
    );
  }

  void showDialogItem(String diagnosisId) async {
    final confirm = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              AppLocalizations.of(context)!.confirmDeletion,
              style: AppTextStyles.title,
            ),
            content: Text(
              AppLocalizations.of(context)!.desConfirmDeletion,
              style: AppTextStyles.content,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.cancel,
                    style: AppTextStyles.cancel,
                  )
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.delete,
                    style: AppTextStyles.delete,
                  )
              )
            ],
          );
        });

    if (confirm == true) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Center(
                child: CircularProgressIndicator(),
              ));

      try {
        await fetchDeleteHistory(diagnosisId);
        Navigator.of(context).pop();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Xoa thanh cong')),
        );

        refreshHistory();
      } catch (e) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Xoá thất bại: $e")),
        );
        throw Exception(e);
      }
    }
  }
}

class _HistoryItemSection extends StatelessWidget {
  final _HistoryPageState parent;
  final Map<String, dynamic> data;

  const _HistoryItemSection({
    required this.parent,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 24, right: 8),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: FadeInImage.assetNetwork(
          placeholder: "assets/imgs/placeholder.png",
          image: data["signedImageUrl"],
          width: 48,
          height: 48,
          fit: BoxFit.cover,
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset(
              "assets/imgs/placeholder.png",
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
      title: Text(
        data["aiPrediction"] ?? "Unknown",
        style: AppTextStyles.content,
      ),
      subtitle: Text(
        "Percent: ${data["confidenceScore"]}",
        style: AppTextStyles.subtitle,
      ),
      trailing: PopupMenuButton<String>(
          icon: Icon(
            Icons.more_horiz_rounded,
            size: 24,
            color: Colors.black,
          ),
          color: Color(0xfff5f5f5),
          onSelected: (value) {
            if (value == 'delete') {
              parent.showDialogItem(data["diagnosisId"]);
            }
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          itemBuilder: (context) => <PopupMenuEntry<String>>[
            PopupMenuItem(
                value: 'delete',
                height: 30,
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.delete,
                      style: AppTextStyles.delete,
                    ),
                    Spacer(),
                    Icon(Icons.delete_outline_rounded, color: Colors.red, size: 24,),
                  ],
                )
            ),
          ]
      ),
      onTap: (){
        parent.loadViewHistory(data);
      },
    );
  }
}
