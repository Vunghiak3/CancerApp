import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testfile/services/llm.dart';
import 'package:testfile/theme/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final LLMService _llmService = LLMService();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _sessionNameController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String? _sessionId;
  List<Map<String, dynamic>> _messages = [];
  List<Map<String, dynamic>> _sessions = [];

  bool _isLoading = false;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _initializeChat();
    _loadSessions();
  }
  @override
  void dispose(){
    _messageController.dispose();
    _sessionNameController.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  Future<void> _initializeChat() async {
    setState(() => _isLoading = true);
    try {
      final latestSession = await _llmService.getLatestSession();
      String? sessionId = latestSession['sessionId'];

      if (sessionId == null || sessionId.isEmpty) {
        final sessionsResponse = await _llmService.getUserSessions();
        final sessionList = List<Map<String, dynamic>>.from(
          sessionsResponse['sessions']?['data'] ?? [],
        );

        if (sessionList.isEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _promptNewSessionDialog();
          });
        } else {
          sessionId = sessionList.first['sessionId'];
        }
      }

      if (sessionId != null) {
        _sessionId = sessionId;
        await _loadMessagesForSession(_sessionId!);
      }
    } catch (e) {
      debugPrint('Error initializing chat: $e');
    }
    setState(() => _isLoading = false);
  }

  Future<void> _loadMessagesForSession(String sessionId) async {
    try {
      final response = await _llmService.getSessionMessages(sessionId);
      setState(() {
        _messages = List<Map<String, dynamic>>.from(response['messages']);
      });
    } catch (e) {
      debugPrint('Failed to load messages: $e');
    }
  }

  Future<void> _sendMessage() async {
    String messageText = _messageController.text.trim();

    if (messageText.isEmpty || _sessionId == null) return;

    setState(() {
      _isSending = true;
      _messages.add({'sender': "User", 'message': messageText});
    });

    _messageController.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToBottom();
    });

    try {
      final response = await _llmService.generate({
        'session_id': _sessionId,
        'prompt': messageText,
      });

      setState(() {
        _messages.add({'sender': "AI", 'message': response});
      });
    } catch (e) {
      debugPrint('Error sending message: $e');
    }finally{
      setState(() {
        _isSending = false;
      });
    }
  }

  void scrollToBottom() {
    if (!_scrollController.hasClients) return;

    _scrollController.animateTo(
      0.0, // reverse = true nên offset 0 là cuối danh sách
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }


  Future<void> _loadSessions() async {
    try {
      final sessionsResponse = await _llmService.getUserSessions();
      final sessionList = List<Map<String, dynamic>>.from(
        sessionsResponse['sessions']?['data'] ?? [],
      );

      setState(() => _sessions = sessionList);
    } catch (e) {
      debugPrint('Error loading sessions: $e');
    }
  }

  Future<void> _createNewSession() async {
    final name = _sessionNameController.text.trim();

    if(name.isEmpty) return;

    try {
      final newSessionId = await _llmService.createSession({
        'session_name': name,
      });

      _sessionId = newSessionId;
      await _loadSessions();
      await _loadMessagesForSession(_sessionId!);
    } catch (e) {
      debugPrint('Error creating session: $e');
    }
  }

  Future<void> _promptNewSessionDialog() async {
    _sessionNameController.clear();

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Create New Chat", style: AppTextStyles.title,),
        content: TextField(
          controller: _sessionNameController,
          decoration: const InputDecoration(hintText: "Chat name"),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text(
                AppLocalizations.of(context)!.cancel,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: AppTextStyles.sizeContent
                ),
              )
          ),
          TextButton(
              onPressed: (){
                Navigator.pop(ctx);
                _createNewSession();
              },
              child: Text(
                "Create",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: AppTextStyles.sizeContent
                ),
              )
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: loadHistoryChat(),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Transform.translate(
          offset: Offset(-20, 0),
          child: Text(
            'LLMChat',
            style: AppTextStyles.title,
          ),
        ),
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: AppTextStyles.sizeIconSmall,)
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.short_text_rounded),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    reverse: true,
                    padding: const EdgeInsets.all(10),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final msg = _messages[_messages.length - 1 - index];
                      final isBot = msg['sender'] == 'AI';

                      return Row(
                        mainAxisAlignment: isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if(isBot)
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Image.asset(
                                'assets/imgs/logowelcome.png',
                                width: 30,
                              ),
                            ),
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.8,
                            ),
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: isBot ? Colors.grey[200] : Colors.blue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              msg['message'],
                              style: TextStyle(
                                  color: isBot ? Colors.black : Colors.white,
                                  fontSize: AppTextStyles.sizeContent
                              ),
                            ),
                          ),
                        ],
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

  Widget loadHistoryChat(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(
                AppLocalizations.of(context)!.chatHistory,
                style: AppTextStyles.title,
              ),
              Spacer(),
              TextButton.icon(
                onPressed: _promptNewSessionDialog,
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                icon: const Icon(
                  Icons.add,
                  size: AppTextStyles.sizeIcon,
                  color: Colors.blue,
                ),
                label: const Text(
                  "New Chat",
                  style: AppTextStyles.content,
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: RefreshIndicator(
            backgroundColor: Colors.white,
            onRefresh: _loadSessions,
            child: ListView.separated(
              itemCount: _sessions.length,
              itemBuilder: (context, index) {
                final session = _sessions[index];
                final sessionId = session['sessionId'] ?? 'Unknown ID';
                final sessionName = session['sessionName'] ?? sessionId;
                String time = DateFormat('HH:mm - dd/MM/yyyy').format(DateTime.parse(session['created_at']));

                return ListTile(
                  title: Text(sessionName, style: AppTextStyles.content,),
                  subtitle: Text(
                    "Created: ${time ?? 'N/A'}",
                    style: AppTextStyles.subtitle,
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    setState(() => _isLoading = true);
                    _sessionId = sessionId;
                    await _loadMessagesForSession(_sessionId!);
                    setState(() => _isLoading = false);
                  },
                  trailing: IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.more_horiz_rounded, color: Colors.black, size: AppTextStyles.sizeIcon,)
                  ),
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
            ),
          ),
        ),
      ],
    );
  }
}
