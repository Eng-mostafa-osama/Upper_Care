import 'package:flutter/material.dart';
import '../../widgets/colorful_header.dart';
import '../../widgets/glass_card.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/locale_provider.dart';

class DoctorChat extends StatefulWidget {
  final VoidCallback onBack;

  const DoctorChat({Key? key, required this.onBack}) : super(key: key);

  @override
  State<DoctorChat> createState() => _DoctorChatState();
}

class _DoctorChatState extends State<DoctorChat> {
  int? selectedChat;
  String message = '';
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> get chats {
    final isArabic = localeProvider.isArabic;
    return [
      {
        'id': 1,
        'patient': isArabic ? 'فاطمة علي' : 'Fatma Ali',
        'lastMessage': isArabic
            ? 'شكراً جزيلاً يا دكتور'
            : 'Thank you so much, Doctor',
        'time': isArabic ? 'منذ 5 دقائق' : '5 min ago',
        'unread': 2,
        'online': true,
      },
      {
        'id': 2,
        'patient': isArabic ? 'محمد أحمد' : 'Mohamed Ahmed',
        'lastMessage': isArabic
            ? 'متى موعدي القادم؟'
            : 'When is my next appointment?',
        'time': isArabic ? 'منذ ساعة' : '1 hour ago',
        'unread': 0,
        'online': false,
      },
      {
        'id': 3,
        'patient': isArabic ? 'سارة حسن' : 'Sara Hassan',
        'lastMessage': isArabic
            ? 'هل يمكنني تناول الدواء مع الطعام؟'
            : 'Can I take the medicine with food?',
        'time': isArabic ? 'منذ 3 ساعات' : '3 hours ago',
        'unread': 1,
        'online': true,
      },
      {
        'id': 4,
        'patient': isArabic ? 'أحمد سعيد' : 'Ahmed Said',
        'lastMessage': isArabic
            ? 'الأعراض تحسنت كثيراً'
            : 'The symptoms have improved a lot',
        'time': isArabic ? 'أمس' : 'Yesterday',
        'unread': 0,
        'online': false,
      },
    ];
  }

  List<Map<String, dynamic>> get messages {
    final isArabic = localeProvider.isArabic;
    return [
      {
        'id': 1,
        'sender': 'patient',
        'text': isArabic ? 'مساء الخير يا دكتور' : 'Good evening, Doctor',
        'time': isArabic ? '04:20 م' : '04:20 PM',
      },
      {
        'id': 2,
        'sender': 'doctor',
        'text': isArabic
            ? 'مساء النور. كيف حالك اليوم؟'
            : 'Good evening. How are you today?',
        'time': isArabic ? '04:22 م' : '04:22 PM',
      },
      {
        'id': 3,
        'sender': 'patient',
        'text': isArabic
            ? 'الحمد لله، الأعراض بدأت تتحسن بعد الدواء'
            : 'Thank God, the symptoms started improving after the medicine',
        'time': isArabic ? '04:23 م' : '04:23 PM',
      },
      {
        'id': 4,
        'sender': 'doctor',
        'text': isArabic
            ? 'ممتاز! استمري على نفس الجرعة لمدة أسبوع آخر'
            : 'Excellent! Continue with the same dose for another week',
        'time': isArabic ? '04:25 م' : '04:25 PM',
      },
      {
        'id': 5,
        'sender': 'patient',
        'text': isArabic
            ? 'شكراً جزيلاً يا دكتور'
            : 'Thank you very much, Doctor',
        'time': isArabic ? '04:26 م' : '04:26 PM',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (selectedChat != null) {
      return _buildChatScreen();
    }
    return _buildChatsListScreen();
  }

  Widget _buildChatScreen() {
    final isArabic = localeProvider.isArabic;
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7ED),
      body: Column(
        children: [
          ColorfulHeader(
            title: isArabic ? 'فاطمة علي' : 'Fatma Ali',
            subtitle: tr('activeNow'),
            onBack: () => setState(() => selectedChat = null),
            gradient: 'sunset',
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isDoctor = msg['sender'] == 'doctor';
                return Align(
                  alignment: isDoctor
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    decoration: BoxDecoration(
                      gradient: isDoctor
                          ? const LinearGradient(
                              colors: [Color(0xFFFF9E57), Color(0xFFFF7D40)],
                            )
                          : null,
                      color: isDoctor ? null : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(isDoctor ? 4 : 16),
                        bottomRight: Radius.circular(isDoctor ? 16 : 4),
                      ),
                      border: isDoctor
                          ? null
                          : Border.all(color: Colors.grey.withOpacity(0.2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          msg['text'],
                          style: TextStyle(
                            color: isDoctor ? Colors.white : Colors.black87,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          msg['time'],
                          style: TextStyle(
                            color: isDoctor ? Colors.white70 : Colors.grey[500],
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              border: Border(
                top: BorderSide(color: Colors.grey.withOpacity(0.2)),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.attach_file, color: Colors.grey[600]),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: tr('writeMessage'),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF9E57), Color(0xFFFF7D40)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.mic, color: Colors.grey[600]),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatsListScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7ED),
      body: Column(
        children: [
          ColorfulHeader(
            title: tr('patientMessagesTitle'),
            subtitle: tr('activeChats'),
            onBack: widget.onBack,
            showNotifications: true,
            gradient: 'orange',
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              decoration: InputDecoration(
                hintText: tr('searchPatient'),
                prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                filled: true,
                fillColor: Colors.white.withOpacity(0.8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return GlassCard(
                  gradient: 'sunset',
                  padding: const EdgeInsets.all(16),
                  onTap: () => setState(() => selectedChat = chat['id']),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFF9E57), Color(0xFFFF7D40)],
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                chat['patient'][0],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          if (chat['online'])
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  chat['patient'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  chat['time'],
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              chat['lastMessage'],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      if (chat['unread'] > 0) ...[
                        const SizedBox(width: 8),
                        Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFFF9E57), Color(0xFFFF7D40)],
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${chat['unread']}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                      IconButton(
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.grey[600],
                          size: 18,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
