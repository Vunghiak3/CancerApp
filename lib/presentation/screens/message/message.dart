import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testfile/theme/text_styles.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'isBot': true,
      'text': 'Hello John',
    },
    {
      'isBot': true,
      'text':
      'Welcome to HealthAssist Chat!\nI\'m here to help. Choose a topic from the list or type your question below!',
    },
    {
      'isBot': true,
      'text': '1. General Information about Cancer\n'
          '2. Symptoms and Early Detection\n'
          '3. Treatment Options\n'
          '4. Coping and Support\n'
          '5. Prevention Tips',
    },
  ];

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add({
          'isBot': false,
          'text': _messageController.text,
        });
      });
      _messageController.clear();
    }
  }

  void _showChatHistory() {
    List<String> chatHistory = [
      "Chat ngày 01/03/2025",
      "Chat ngày 28/02/2025",
      "Chat ngày 27/02/2025",
    ];

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Close",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.centerLeft,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30,),
                  Text(
                      AppLocalizations.of(context)!.chatHistory,
                      style: AppTextStyles.title,
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index){
                          return ListTile(
                            title: Text(
                              chatHistory[index],
                              style: AppTextStyles.content,
                            ),
                            trailing: IconButton(
                                onPressed: (){},
                                icon: Icon(Icons.more_horiz_rounded, color: Colors.black, size: AppTextStyles.sizeIcon,)
                            ),
                            onTap: () {},
                          );
                        },
                        separatorBuilder: (context, index){
                          return const Divider(
                            color: Colors.grey,
                            thickness: 1,
                            indent: 15,
                            endIndent: 15,
                          );
                        },
                        itemCount: chatHistory.length
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(anim),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Transform.translate(
          offset: Offset(-20, 0),
          child: Text(
            AppLocalizations.of(context)!.chat,
            style: AppTextStyles.title,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: AppTextStyles.sizeIconSmall,),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: _showChatHistory,
            icon: const Icon(Icons.short_text_rounded, color: Colors.black, size: AppTextStyles.sizeIcon),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Align(
                  alignment: message['isBot']
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: message['isBot']
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (message['isBot']) // Chỉ hiện ảnh khi là tin nhắn của bot
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Image.asset(
                            'assets/imgs/logowelcome.png',
                            width: 30,
                          ),
                        ),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.8, // Chiều rộng tối đa là 80% màn hình
                        ),
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: message['isBot'] ? Colors.grey[200] : Colors.blue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          message['text'],
                          style: TextStyle(
                            color: message['isBot'] ? Colors.black : Colors.white,
                            fontSize: AppTextStyles.sizeContent
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey[300]!)),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: "Write a message",
                      hintStyle: AppTextStyles.content,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue, size: AppTextStyles.sizeIcon,),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}