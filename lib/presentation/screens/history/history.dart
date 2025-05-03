import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:testfile/presentation/screens/result/result.dart';
import 'package:testfile/presentation/widgets/CustomTopNotification.dart';
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
  bool isChoose = false;

  List<String> selectedIds = [];

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

  void fetchDeleteMultiHistory(List<String> listHistory) async{
    try{
      String idToken = await AuthService().getIdToken();
      final response = await CnnService().deleteMultiHistory(idToken, listHistory);
      await refreshHistory();
      setState(() {
        isChoose = !isChoose;
      });
      CustomTopNotification.show(
        context,
        message: AppLocalizations.of(context)!.deleteSuccess,
      );
      return response;
    }catch(e){
      throw Exception(e);
    }
  }

  void loadViewHistory(Map<String, dynamic> data) {
    NavigationHelper.nextPage(
        context,
        ResultPage(
          imageUrl: data['signedImageUrl'],
          data: data,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getAppBar(),
      body: Stack(
        children: [
          getBody(),
          if (isChoose && selectedIds.isNotEmpty)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ElevatedButton(
                  onPressed: (){
                    fetchDeleteMultiHistory(selectedIds);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: Text(
                    "${AppLocalizations.of(context)!.delete} (${selectedIds.length})",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  PreferredSizeWidget getAppBar() {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Text(
        AppLocalizations.of(context)!.diagnosisHistory,
        style: AppTextStyles.title,
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: FutureBuilder(
              future: futureHistory,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                }

                if (snapshot.hasError || snapshot.data!.isEmpty ?? true) {
                  return Container();
                }

                return TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.grey.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    minimumSize: Size(0, 36),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedIds.clear();
                      isChoose = !isChoose;
                    });
                  },
                  child: Text(
                    isChoose ? AppLocalizations.of(context)!.cancel : AppLocalizations.of(context)!.select,
                    style: TextStyle(
                      fontSize: AppTextStyles.sizeSubtitle,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }

  Widget getBody() {
    return FutureBuilder<List<dynamic>>(
        future: futureHistory,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return shimmerLoadingList();
          }

          if (snapshot.hasError) {
            return Center(child: Text('${AppLocalizations.of(context)!.error}: ${snapshot.error}'));
          }
          final historyData = snapshot.data ?? [];

          if (historyData.isEmpty) {
            return Center(
              child: Text(
                AppLocalizations.of(context)!.noDiagnosisHistory,
                style: TextStyle(
                    fontSize: AppTextStyles.sizeContent, color: Colors.grey),
              ),
            );
          }

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
        });
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
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.delete,
                    style: AppTextStyles.delete,
                  ))
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

        CustomTopNotification.show(
          context,
          message: AppLocalizations.of(context)!.deleteSuccess,
        );

        refreshHistory();
      } catch (e) {
        Navigator.of(context).pop();
        CustomTopNotification.show(context,
            message: AppLocalizations.of(context)!.deletionFailed, color: Colors.red, icon: Icons.cancel);
        throw Exception(e);
      }
    }
  }

  Widget shimmerLoadingList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 9),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 14,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 12,
                        width: MediaQuery.of(context).size.width * 0.5,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => const Divider(indent: 24, endIndent: 24),
      itemCount: 5,
    );
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
      contentPadding: EdgeInsets.only(left: parent.isChoose ? 5 : 24, right: 8),
      leading: Wrap(
        spacing: 5,
        children: [
          if (parent.isChoose)
            Checkbox(
              value: parent.selectedIds.contains(data["diagnosisId"]),
              onChanged: (value) {
                if (value == true) {
                  parent.setState(() {
                    parent.selectedIds.add(data["diagnosisId"]);
                  });
                } else {
                  parent.setState(() {
                    parent.selectedIds.remove(data["diagnosisId"]);
                  });
                }
              },
            ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: data["signedImageUrl"] != null
                ? FadeInImage.assetNetwork(
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
                  )
                : Image.asset(
                    "assets/imgs/placeholder.png",
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                  ),
          )
        ],
      ),
      title: Text(
        data["aiPrediction"] ?? "Unknown",
        style: AppTextStyles.content,
      ),
      subtitle: Text(
        "${AppLocalizations.of(context)!.accuracy}: ${data["confidenceScore"]}",
        style: AppTextStyles.subtitle,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            DateFormat('HH:mm - dd/MM/yyyy').format(
                    DateTime.parse(data['diagnosedAt'] + 'Z').toLocal()) ??
                'N/A',
            style: AppTextStyles.subtitle,
          ),
          PopupMenuButton<String>(
              icon: Icon(
                Icons.more_horiz_rounded,
                size: 24,
                color: Colors.black,
              ),
              color: Color(0xfff5f5f5),
              onSelected: (value) {
                if (value == AppLocalizations.of(context)!.delete) {
                  parent.showDialogItem(data["diagnosisId"]);
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              itemBuilder: (context) => <PopupMenuEntry<String>>[
                    PopupMenuItem(
                        value: AppLocalizations.of(context)!.delete,
                        height: 30,
                        child: Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.delete,
                              style: AppTextStyles.delete,
                            ),
                            Spacer(),
                            Icon(
                              Icons.delete_outline_rounded,
                              color: Colors.red,
                              size: 24,
                            ),
                          ],
                        )),
                  ])
        ],
      ),
      onTap: () {
        parent.loadViewHistory(data);
      },
    );
  }
}
