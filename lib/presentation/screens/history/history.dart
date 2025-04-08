import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testfile/presentation/widgets/GetProgressBar.dart';
import 'package:testfile/services/auth.dart';
import 'package:testfile/services/user.dart';
import 'package:testfile/theme/text_styles.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>{
  List<dynamic>? historyData;

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<List<dynamic>> fetchHistory() async{
    try{
      String idToken = await AuthService().getIdToken();
      final response = await UserService().history(idToken);
      return response;
    }catch(e){
      throw Exception(e);
    }
  }

  void loadHistory() async {
    historyData = await fetchHistory();
    setState(() {});
  }

  Future<Map<String, dynamic>> fetchDeleteHistory(String historyId) async{
    try{
      String idToken = await AuthService().getIdToken();
      final response = await UserService().deleteHistoryById(idToken, historyId);
      return response;
    }catch(e){
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  PreferredSizeWidget getAppBar(){
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Text('Lịch sử chẩn đoán', style: AppTextStyles.title,),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: (){},
            icon: Icon(Icons.more_horiz_outlined, color: Colors.black, size: 24,)
        )
      ],
    );
  }

  Widget getBody(){
    if (historyData == null) {
      return GetProgressBar();
    }

    if (historyData!.isEmpty) {
      return Center(child: Text("Không có dữ liệu lịch sử"));
    }

    return getListView();
  }

  ListView getListView(){
    return ListView.separated(
        itemBuilder: (context, position) {
          final diagnose = historyData![position] as Map<String, dynamic>;
          return _HistoryItemSection(
            parent: this,
            data: diagnose,
          );
        },
        separatorBuilder: (context, index){
          return const Divider(
            color: Colors.grey,
            thickness: 1,
            indent: 24,
            endIndent: 24,
          );
        },
        itemCount: historyData!.length,
        shrinkWrap: true,
    );
  }

  void showDialogItem(String diagnosisId) async{
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context){
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
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                  style: AppTextStyles.cancel,
                )
            ),
            TextButton(
                onPressed: (){
                  Navigator.pop(context, true);
                },
                child: Text(
                  AppLocalizations.of(context)!.delete,
                  style: AppTextStyles.delete,
                )
            )
          ],
        );
      }
    );

    if(confirm == true){
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Center(child: CircularProgressIndicator(),)
      );

      try {
        print(diagnosisId);
        await fetchDeleteHistory(diagnosisId);
        Navigator.of(context).pop(); // Tắt loading

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Xoa thanh cong')),
        );

        loadHistory(); // Tải lại dữ liệu
      } catch (e) {
        Navigator.of(context).pop(); // Tắt loading
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Xoá thất bại: $e")),
        );
        throw Exception(e);
      }
    }
  }
}

class _HistoryItemSection extends StatelessWidget{
  final _HistoryPageState parent;
  final Map<String, dynamic> data;

  const _HistoryItemSection({
    required this.parent,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(
        left: 24,
        right: 8
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: FadeInImage.assetNetwork(
          placeholder: "assets/imgs/placeholder.png",
          image: data["mriImageUrl"],
          width: 48,
          height: 48,
          fit: BoxFit.cover,
          imageErrorBuilder: (context, error, stackTrace){
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
          icon: Icon(Icons.more_horiz_rounded, size: 24, color: Colors.black,),
          color: Color(0xfff5f5f5),
          onSelected: (value){
            if(value == 'delete'){
              parent.showDialogItem(data["diagnosisId"]);
            }
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
          ),
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

      },
    );
  }
}
