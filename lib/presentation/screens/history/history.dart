import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testfile/data/model/historyDiagnose.dart';
import 'package:testfile/presentation/widgets/GetProgressBar.dart';
import 'package:http/http.dart' as http;
import 'package:testfile/theme/text_styles.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  final List<HistoryDiagnose> _history = [
    HistoryDiagnose(
      id: "1",
      title: "Title 1",
      content: "Lịch sử 1",
      image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3ptSvyhlI6mkEM1kkVUlqP15QN4_8MHg5uA&s",
      confidenceScore: 95.0,
    ),
    HistoryDiagnose(
      id: "2",
      title: "Title 2",
      content: "Lịch sử 2",
      image: "ádfasf",
      confidenceScore: 89.5,
    ),
    HistoryDiagnose(
      id: "3",
      title: "Title 3",
      content: "Lịch sử 3",
      image: "ádf",
      confidenceScore: 92.3,
    ),
    HistoryDiagnose(
      id: "4",
      title: "Title 4",
      content: "Lịch sử 4",
      image: "https://prod-images-static.radiopaedia.org/images/23495/downloaded_image20241008-104595-4b847r_big_gallery.jpeg",
      confidenceScore: 87.2,
    ),
    HistoryDiagnose(
      id: "4",
      title: "Title 4",
      content: "Lịch sử 4",
      image: "https://prod-images-static.radiopaedia.org/images/23495/downloaded_image20241008-104595-4b847r_big_gallery.jpeg",
      confidenceScore: 87.2,
    ),
    HistoryDiagnose(
      id: "4",
      title: "Title 4",
      content: "Lịch sử 4",
      image: "https://prod-images-static.radiopaedia.org/images/23495/downloaded_image20241008-104595-4b847r_big_gallery.jpeg",
      confidenceScore: 87.2,
    ),
    HistoryDiagnose(
      id: "4",
      title: "Title 4",
      content: "Lịch sử 4",
      image: "https://prod-images-static.radiopaedia.org/images/23495/downloaded_image20241008-104595-4b847r_big_gallery.jpeg",
      confidenceScore: 87.2,
    ),
    HistoryDiagnose(
      id: "4",
      title: "Title 4",
      content: "Lịch sử 4",
      image: "https://prod-images-static.radiopaedia.org/images/23495/downloaded_image20241008-104595-4b847r_big_gallery.jpeg",
      confidenceScore: 87.2,
    ),
    HistoryDiagnose(
      id: "4",
      title: "Title 4",
      content: "Lịch sử 4",
      image: "https://prod-images-static.radiopaedia.org/images/23495/downloaded_image20241008-104595-4b847r_big_gallery.jpeg",
      confidenceScore: 87.2,
    ),
  ];

  Future<List<HistoryDiagnose>> fetchHistory() async{
    final response = await http.get(Uri.parse('https://api.example.com/history'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => HistoryDiagnose.fromJson(item)).toList();
    } else {
      throw Exception("Lỗi khi tải dữ liệu");
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
    bool showLoading = _history.isEmpty;
    return showLoading ? GetProgressBar() : getListView();
    // return FutureBuilder<List<HistoryDiagnose>>(
    //   future: fetchHistory(), // Gọi API
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return GetProgressBar(); // Hiển thị loading
    //     } else if (snapshot.hasError) {
    //       return Center(child: Text("Lỗi: ${snapshot.error}")); // Xử lý lỗi
    //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
    //       return Center(child: Text("Không có dữ liệu lịch sử"));
    //     }
    //
    //     // Dữ liệu đã tải xong, hiển thị danh sách
    //     return getListView();
    //   },
    // );
  }

  ListView getListView(){
    return ListView.separated(
        itemBuilder: (context, position) {
          return _HistoryItemSection(
              parent: this,
              historyDiagnose: _history[position]
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
        itemCount: _history.length,
        shrinkWrap: true,
    );
  }

  void showDialogItem(){
    showDialog(
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
                  Navigator.pop(context);
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
  }
}

class _HistoryItemSection extends StatelessWidget{
  final _HistoryPageState parent;
  final HistoryDiagnose historyDiagnose;

  const _HistoryItemSection({
    required this.parent,
    required this.historyDiagnose,
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
          image: historyDiagnose.image,
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
        historyDiagnose.title,
        style: AppTextStyles.content,
      ),
      subtitle: Text(
        "Percent: ${historyDiagnose.confidenceScore}",
        style: AppTextStyles.subtitle,
      ),
      trailing: PopupMenuButton<String>(
          icon: Icon(Icons.more_horiz_rounded, size: 24, color: Colors.black,),
          color: Color(0xfff5f5f5),
          onSelected: (value){
            if(value == 'delete'){
              parent.showDialogItem();
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
