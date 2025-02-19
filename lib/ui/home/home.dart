import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:testfile/ui/camera/camera.dart';
import 'package:testfile/ui/history/history.dart';
import 'package:testfile/ui/message/message.dart';
import 'package:testfile/ui/profile/profile.dart';
import 'package:testfile/ui/welcompage/welcome.dart';
import 'package:testfile/services/news_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:io' show Platform;

final newsProvider =
    FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  ref.keepAlive();
  final allNews = await NewsService.fetchNews();
  return allNews.take(10).toList();
});

class CancerHomePage extends StatefulWidget {
  const CancerHomePage({super.key});

  @override
  State<CancerHomePage> createState() => _CancerHomePageState();
}

class _CancerHomePageState extends State<CancerHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [
    const HomeTab(),
    const MessageTab(),
    const CameraTab(),
    const HistoryTab(),
    const ProfileTab(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: _tabs,
      ),
      floatingActionButton: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.indigoAccent,
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(0.3),
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: FloatingActionButton(
          // onPressed: ()=> _onTabSelected(2),
          onPressed: () => nextPage(context, CameraTab()),
          backgroundColor: Colors.transparent,
          elevation: 0, // Tắt bóng mặc định
          shape: const CircleBorder(),
          child: const Icon(
            Icons.camera_alt_outlined,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavigationBar(
        size: size,
        selectedIndex: _selectedIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final Size size;
  final int selectedIndex;
  final Function(int) onTabSelected;

  const CustomBottomNavigationBar({
    super.key,
    required this.size,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: size.width,
          height: 80,
          child: Stack(
            children: [
              CustomPaint(
                size: Size(size.width, 80),
                painter: BNBCustomPainter(),
              ),
              Container(
                width: size.width,
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(Icons.home, "Home", 0),
                    // _buildNavItem(Icons.chat_outlined, "Chat", 1),
                    IconButton(
                        onPressed: () {
                          nextPage(context, MessageTab());
                        },
                        icon: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.message_outlined,
                              color: Colors.grey,
                            ),
                            Text(
                              'Chat',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        )),
                    SizedBox(width: size.width * 0.10), // Khoảng trống cho FAB
                    _buildNavItem(Icons.history, "History", 3),
                    _buildNavItem(Icons.person_outline, "Profile", 4),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildNavItem(IconData icon, String title, int index) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? Colors.blue : Colors.grey),
          Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Paint borderPaint = Paint()
      ..color = Colors.black // Màu viền
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.40; // Độ dày viền

    Path path = Path()..moveTo(0, 20);
    path.arcToPoint(Offset(20, 0),
        radius: Radius.circular(20.0), clockwise: true);

    path.lineTo(size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.42, 20);

    path.arcToPoint(
      Offset(size.width * 0.58, 20),
      radius: Radius.circular(40.0),
      clockwise: false,
    );

    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);

    path.lineTo(size.width - 20, 0);
    path.arcToPoint(Offset(size.width, 20),
        radius: Radius.circular(20.0), clockwise: true);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    // Vẽ bóng
    canvas.drawShadow(path, Colors.black, -1.0, true);

    // Vẽ nền
    canvas.drawPath(path, paint);

    // Vẽ viền
    // canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsAsync = ref.watch(newsProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Curely',
              style: TextStyle(
                color: Color(0xFF0E70CB),
                fontSize: 44,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(width: 10),
            Icon(Icons.camera, color: Color(0xFF0E70CB), size: 40),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        heroTag: 'cameraFab', // Unique hero tag
        onPressed: () {
          // Only initialize camera on supported platforms
          if (Platform.isAndroid || Platform.isIOS) {
            nextPage(context, CameraTab());
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Camera not supported on this platform')),
            );
          }
        },
        backgroundColor: Colors.indigoAccent,
        child: Icon(Icons.camera_alt_outlined, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: [
          // News Carousel with padding and full width slides
          newsAsync.when(
            data: (newsList) => newsList.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 200,
                        autoPlay: true,
                        viewportFraction: 1.0, // full width
                      ),
                      items:
                          newsList.map((news) => _buildNewsItem(news)).toList(),
                    ),
                  )
                : Center(child: Text('No news available')),
            loading: () => Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(
              child: Text(
                'Failed to load news: $err',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 20),
          // Navigation Cards
          _buildNavigationCard(
            context,
            'Doctor Consultation',
            Icons.medical_services,
            MessageTab(),
          ),
          _buildNavigationCard(
            context,
            'AI Chat',
            Icons.smart_toy,
            MessageTab(),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsItem(Map<String, dynamic> news) {
    String title = news['title'] ?? 'No Title';
    String imageUrl = news['image_url'] ?? '';
    String description = news['description'] ?? 'No Description';
    String link = news['link'] ?? '';

    return GestureDetector(
      onTap: () {
        if (link.isNotEmpty) {
          // Use url_launcher to open the link
        }
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            // Use CachedNetworkImage for image caching & error handling
            if (imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[300],
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[300],
                    child: Icon(Icons.broken_image, color: Colors.grey),
                  ),
                ),
              ),
            Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationCard(
      BuildContext context, String title, IconData icon, Widget page) {
    return GestureDetector(
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListTile(
          leading: Icon(icon, color: Colors.blue),
          title: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
