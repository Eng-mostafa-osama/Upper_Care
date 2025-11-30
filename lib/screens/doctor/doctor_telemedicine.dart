import 'package:flutter/material.dart';
import '../../widgets/colorful_header.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/gradient_button.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/locale_provider.dart';

class DoctorTelemedicine extends StatefulWidget {
  final VoidCallback onBack;
  final Function(String) onNavigate;

  const DoctorTelemedicine({
    Key? key,
    required this.onBack,
    required this.onNavigate,
  }) : super(key: key);

  @override
  State<DoctorTelemedicine> createState() => _DoctorTelemedicineState();
}

class _DoctorTelemedicineState extends State<DoctorTelemedicine> {
  bool isInCall = false;
  bool isMuted = false;
  bool isVideoOff = false;

  List<Map<String, dynamic>> get scheduledCalls {
    final isArabic = localeProvider.isArabic;
    return [
      {
        'id': 1,
        'time': isArabic ? '02:00 م' : '02:00 PM',
        'patient': isArabic ? 'سارة حسن' : 'Sara Hassan',
        'type': isArabic ? 'استشارة عامة' : 'General Consultation',
      },
      {
        'id': 2,
        'time': isArabic ? '04:00 م' : '04:00 PM',
        'patient': isArabic ? 'أحمد علي' : 'Ahmed Ali',
        'type': isArabic ? 'متابعة' : 'Follow-up',
      },
      {
        'id': 3,
        'time': isArabic ? '05:30 م' : '05:30 PM',
        'patient': isArabic ? 'منى إبراهيم' : 'Mona Ibrahim',
        'type': isArabic ? 'استشارة متخصصة' : 'Specialized Consultation',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (isInCall) {
      return _buildCallScreen();
    }
    return _buildMainScreen();
  }

  Widget _buildCallScreen() {
    final isArabic = localeProvider.isArabic;
    return Scaffold(
      backgroundColor: const Color(0xFF1F2937),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF164E63), Color(0xFF1E3A5F)],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 128,
                    height: 128,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF2BB9A9), Color(0xFF0A6DD9)],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        isArabic ? 'س' : 'S',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isArabic ? 'سارة حسن' : 'Sara Hassan',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    tr('calling'),
                    style: const TextStyle(
                      color: Color(0xFF2BB9A9),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 60,
            right: 20,
            child: Container(
              width: 100,
              height: 140,
              decoration: BoxDecoration(
                gradient: isVideoOff
                    ? const LinearGradient(
                        colors: [Color(0xFF374151), Color(0xFF4B5563)],
                      )
                    : const LinearGradient(
                        colors: [Color(0xFFFF9E57), Color(0xFFFF7D40)],
                      ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 2,
                ),
              ),
              child: Center(
                child: isVideoOff
                    ? const Icon(
                        Icons.videocam_off,
                        color: Colors.white,
                        size: 32,
                      )
                    : Text(
                        tr('you'),
                        style: const TextStyle(color: Colors.white),
                      ),
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text(
                    isArabic ? 'مدة المكالمة' : 'Call Duration',
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  const Text(
                    '08:24',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildControlButton(
                        icon: isMuted ? Icons.mic_off : Icons.mic,
                        isActive: isMuted,
                        onTap: () => setState(() => isMuted = !isMuted),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () => setState(() => isInCall = false),
                        child: Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFF43F5E), Color(0xFFDC2626)],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.4),
                                blurRadius: 16,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.call_end,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      _buildControlButton(
                        icon: isVideoOff ? Icons.videocam_off : Icons.videocam,
                        isActive: isVideoOff,
                        onTap: () => setState(() => isVideoOff = !isVideoOff),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSmallButton(Icons.message, tr('chatBtn')),
                      const SizedBox(width: 12),
                      _buildSmallButton(
                        Icons.description,
                        tr('prescriptionBtn'),
                      ),
                      const SizedBox(width: 12),
                      _buildSmallButton(Icons.camera_alt, tr('screenshot')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFFF43F5E)
              : Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }

  Widget _buildSmallButton(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildMainScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFFECFEFF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ColorfulHeader(
              title: tr('videoConsultationsTitle'),
              subtitle: tr('remoteCallManagement'),
              onBack: widget.onBack,
              showNotifications: true,
              gradient: 'turquoise',
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlassCard(
                    gradient: 'nile',
                    child: Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF2BB9A9), Color(0xFF0A6DD9)],
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.videocam,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          tr('startInstantCall'),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          tr('startConsultationNow'),
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 16),
                        GradientButton(
                          variant: 'turquoise',
                          fullWidth: true,
                          onPressed: () => setState(() => isInCall = true),
                          child: Text(tr('startCallBtn')),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    tr('scheduledCalls'),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...scheduledCalls
                      .map((call) => _buildScheduledCallCard(call))
                      .toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduledCallCard(Map<String, dynamic> call) {
    return GlassCard(
      gradient: 'blue',
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0A6DD9), Color(0xFF2BB9A9)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    call['patient'][0],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      call['patient'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      call['type'],
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Text(call['time'], style: TextStyle(color: Colors.grey[700])),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => setState(() => isInCall = true),
                  icon: const Icon(Icons.videocam, size: 18),
                  label: Text(tr('join')),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A6DD9),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                onPressed: () => widget.onNavigate('doctor-chat'),
                icon: const Icon(Icons.message, color: Color(0xFF2BB9A9)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
