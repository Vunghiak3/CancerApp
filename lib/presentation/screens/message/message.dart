import 'package:flutter/material.dart';
import 'package:testfile/services/llm.dart';
import 'package:testfile/theme/text_styles.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final LLMService _llmService = LLMService();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _sessionNameController = TextEditingController();

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
      debugPrint('❌ Error initializing chat: $e');
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
      debugPrint('❌ Failed to load messages: $e');
    }
  }

  Future<void> _sendMessage() async {
    String messageText = _messageController.text.trim();

    if (messageText.isEmpty || _sessionId == null) return;

    setState(() {
      _isSending = true;
      _messages.add({'sender': "User", 'message': messageText});
    });

    try {
      _messageController.clear();
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

  Future<void> _loadSessions() async {
    try {
      final sessionsResponse = await _llmService.getUserSessions();
      final sessionList = List<Map<String, dynamic>>.from(
        sessionsResponse['sessions']?['data'] ?? [],
      );

      setState(() => _sessions = sessionList);
    } catch (e) {
      debugPrint('❌ Error loading sessions: $e');
    }
  }

  Future<void> _promptNewSessionDialog() async {
    _sessionNameController.clear();

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Create New Session"),
        content: TextField(
          controller: _sessionNameController,
          decoration: const InputDecoration(hintText: "Session name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              final name = _sessionNameController.text.trim();
              if (name.isNotEmpty) {
                Navigator.pop(ctx);
                await _createNewSession(name);
              }
            },
            child: const Text("Create"),
          ),
        ],
      ),
    );
  }

  Future<void> _createNewSession(String name) async {
    try {
      final newSessionId = await _llmService.createSession({
        'session_name': name,
      });

      _sessionId = newSessionId;
      await _loadSessions();
      await _loadMessagesForSession(_sessionId!);
    } catch (e) {
      debugPrint('❌ Error creating session: $e');
    }
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
                    padding: const EdgeInsets.all(10),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final msg = _messages[index];
                      final isUser = msg['sender'] == 'User';

                      return Row(
                        mainAxisAlignment: isUser ? MainAxisAlignment.start : MainAxisAlignment.end,
                        children: [
                          if(isUser)
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
                              color: isUser ? Colors.grey[200] : Colors.blue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              msg['message'],
                              style: TextStyle(
                                  color: isUser ? Colors.black : Colors.white,
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
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Sessions",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _loadSessions,
            child: ListView.builder(
              itemCount: _sessions.length,
              itemBuilder: (context, index) {
                final session = _sessions[index];
                final sessionId = session['sessionId'] ?? 'Unknown ID';
                final sessionName = session['sessionName'] ?? sessionId;

                return ListTile(
                  title: Text(sessionName),
                  subtitle: Text(
                    "Created: ${session['created_at'] ?? 'N/A'}",
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    setState(() => _isLoading = true);
                    _sessionId = sessionId;
                    await _loadMessagesForSession(_sessionId!);
                    setState(() => _isLoading = false);
                  },
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton.icon(
            onPressed: _promptNewSessionDialog,
            icon: const Icon(Icons.add),
            label: const Text("New Session"),
          ),
        ),
      ],
    );
  }
}
