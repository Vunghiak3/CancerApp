import 'package:flutter/material.dart';

class NavigationHelper {
  /// Chuyển sang trang mới mà vẫn giữ trang cũ
  static void nextPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  /// Chuyển sang trang mới và thay thế trang hiện tại (không quay lại được)
  static void nextPageReplace(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  /// Chuyển sang trang mới và xoá tất cả các trang trước đó
  static void nextPageRemoveUntil(BuildContext context, Widget page) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => page),
          (route) => false, // Xóa tất cả các route trước đó
    );
  }
}
