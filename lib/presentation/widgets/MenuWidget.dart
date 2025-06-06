import 'package:flutter/material.dart';
import 'package:testfile/theme/text_styles.dart';

class MenuWidget extends StatelessWidget {
  final String? title;
  final List<MenuItem> items;

  const MenuWidget({
    super.key,
    this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null && title!.isNotEmpty) ...[
          Text(
            title!,
            style: AppTextStyles.content,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 1,
          color: Colors.white,
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: List.generate(
              items.length,
              (index) => Column(
                children: [
                  Stack(
                    children: [
                      ListTile(
                        dense: true,
                        leading: Icon(
                          items[index].icon,
                          color: items[index].colorIcon ?? Colors.blue,
                          size: AppTextStyles.sizeIcon,
                        ),
                        title: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                items[index].text,
                                style: AppTextStyles.content,
                              ),
                              if (items[index].subText?.isNotEmpty ?? false)
                                Text(
                                  items[index].subText!,
                                  style: AppTextStyles.subtitle,
                                )
                            ],
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: items[index].onTap,
                      ),
                      if (index < items.length - 1)
                        Positioned(
                          left: 50,
                          right: 0,
                          bottom: 0,
                          child: Divider(
                            color: Colors.grey.shade300,
                            thickness: 1,
                            height: 1,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MenuItem {
  final String text;
  final String? subText;
  final IconData icon;
  final Color? colorIcon;
  final VoidCallback? onTap;

  MenuItem({
    required this.text,
    this.subText,
    required this.icon,
    this.colorIcon,
    this.onTap,
  });
}
