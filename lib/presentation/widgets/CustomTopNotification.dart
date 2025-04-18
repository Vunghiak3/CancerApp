import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testfile/theme/text_styles.dart';

class CustomTopNotification {
  static void show(BuildContext context,
      {IconData icon = Icons.check_circle,
      Color color = const Color(0xFF0866FF),
      required String message}) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    final animationController = AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 300),
    );

    final animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    );

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 10,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0, -1),
              end: Offset(0, 0),
            ).animate(animation),
            child: FadeTransition(
              opacity: animation,
              child: Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.up,
                onDismissed: (_) {
                  animationController.reverse().then((_) {
                    overlayEntry.remove();
                    animationController.dispose();
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        icon,
                        color: Colors.white,
                        size: AppTextStyles.sizeIcon,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          message,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          animationController.reverse().then((_) {
                            overlayEntry.remove();
                            animationController.dispose();
                          });
                        },
                        child: Icon(Icons.close, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    animationController.forward();

    // Auto dismiss sau 3s nếu không đóng bằng tay
    Future.delayed(Duration(seconds: 2)).then((_) {
      if (animationController.status == AnimationStatus.completed) {
        animationController.reverse().then((_) {
          overlayEntry.remove();
          animationController.dispose();
        });
      }
    });
  }
}
