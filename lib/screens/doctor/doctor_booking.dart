import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class Doctor {
  final String id;
  final String name;
  final String specialty;
  final double rating;
  final int reviews;
  final String experience;
  final String location;
  final double price;
  final List<Color> gradientColors;
  final List<String> visitTypes;

  Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviews,
    required this.experience,
    required this.location,
    required this.price,
    required this.gradientColors,
    required this.visitTypes,
  });
}

class DoctorBooking extends StatefulWidget {
  final VoidCallback onBack;

  const DoctorBooking({Key? key, required this.onBack}) : super(key: key);

  @override
  State<DoctorBooking> createState() => _DoctorBookingState();
}

class _DoctorBookingState extends State<DoctorBooking> {
  Doctor? selectedDoctor;
  String? selectedDate;
  String? selectedTime;
  String visitType = 'home';

  List<Doctor> get doctors => [
    Doctor(
      id: '1',
      name: tr('drAhmedMahmoudFull'),
      specialty: tr('internalMedicine'),
      rating: 4.8,
      reviews: 124,
      experience: tr('yearsExp15'),
      location: tr('aswan'),
      price: 200,
      gradientColors: [const Color(0xFF0A6DD9), const Color(0xFF2BB9A9)],
      visitTypes: ['home', 'clinic', 'video'],
    ),
    Doctor(
      id: '2',
      name: tr('drFatimaSayed'),
      specialty: tr('pediatrics'),
      rating: 4.9,
      reviews: 186,
      experience: tr('yearsExp12'),
      location: tr('qena'),
      price: 250,
      gradientColors: [const Color(0xFFFF9E57), const Color(0xFFFF7D40)],
      visitTypes: ['home', 'video'],
    ),
    Doctor(
      id: '3',
      name: tr('drMohamedAli'),
      specialty: tr('generalSurgery'),
      rating: 4.7,
      reviews: 98,
      experience: tr('yearsExp20'),
      location: tr('sohag'),
      price: 300,
      gradientColors: [const Color(0xFF2BB9A9), const Color(0xFF0A6DD9)],
      visitTypes: ['clinic', 'home'],
    ),
    Doctor(
      id: '4',
      name: tr('nurseSaraAhmed'),
      specialty: tr('homeNursing'),
      rating: 4.6,
      reviews: 75,
      experience: tr('yearsExp8'),
      location: tr('aswan'),
      price: 150,
      gradientColors: [const Color(0xFFD9AE73), const Color(0xFFE4C590)],
      visitTypes: ['home'],
    ),
  ];

  List<Map<String, String>> get availableDates => [
    {'date': '2025-11-28', 'day': tr('fridayShort'), 'dayNum': '28'},
    {'date': '2025-11-29', 'day': tr('saturdayShort'), 'dayNum': '29'},
    {'date': '2025-11-30', 'day': tr('sundayShort'), 'dayNum': '30'},
    {'date': '2025-12-01', 'day': tr('mondayShort'), 'dayNum': '1'},
    {'date': '2025-12-02', 'day': tr('tuesdayShort'), 'dayNum': '2'},
  ];

  List<String> get timeSlots => [
    tr('time9AM'),
    tr('time10AM'),
    tr('time11AM'),
    tr('time12PM'),
    tr('time2PM'),
    tr('time3PM'),
    tr('time4PM'),
    tr('time5PM'),
  ];

  void handleBooking() {
    if (selectedDoctor != null &&
        selectedDate != null &&
        selectedTime != null) {
      String visitTypeText = visitType == 'home'
          ? tr('homeVisitLabel')
          : visitType == 'clinic'
          ? tr('clinicVisitLabel')
          : tr('onlineConsultationLabel');

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: Color(0xFF2BB9A9),
                size: 32,
              ),
              const SizedBox(width: 12),
              Text(tr('bookingSuccess')),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${tr('doctorLabel')}: ${selectedDoctor!.name}'),
              Text('${tr('dateLabel')}: $selectedDate'),
              Text('${tr('timeLabel')}: $selectedTime'),
              Text('${tr('visitTypeLabel')}: $visitTypeText'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  selectedDoctor = null;
                  selectedDate = null;
                  selectedTime = null;
                });
              },
              child: Text(tr('done')),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (selectedDoctor != null) {
      return _buildBookingScreen();
    }
    return _buildDoctorsList();
  }

  Widget _buildDoctorsList() {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          _buildHeader(
            title: tr('doctorsAndNurses'),
            subtitle: tr('bookBestDoctors'),
            gradientColors: [const Color(0xFF2BB9A9), const Color(0xFF0A6DD9)],
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                return _buildDoctorCard(doctors[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader({
    required String title,
    required String subtitle,
    required List<Color> gradientColors,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradientColors),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(48),
          bottomRight: Radius.circular(48),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Decorative dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(15, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),

              // Top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_forward, color: Colors.white),
                    onPressed: selectedDoctor != null
                        ? () => setState(() => selectedDoctor = null)
                        : widget.onBack,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorCard(Doctor doctor) {
    return GestureDetector(
      onTap: () => setState(() => selectedDoctor = doctor),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Colored top bar
            Container(
              height: 8,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: doctor.gradientColors),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Doctor avatar
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: doctor.gradientColors,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.all(3),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: doctor.gradientColors[0],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              doctor.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              doctor.specialty,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  doctor.location,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.location_on,
                                  size: 14,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  '(${doctor.reviews})',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[400],
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${doctor.rating}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.star,
                                  size: 14,
                                  color: Color(0xFFFF9E57),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Visit type badges
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (doctor.visitTypes.contains('video'))
                        _buildVisitTypeBadge(
                          tr('onlineVisitType'),
                          Icons.videocam,
                          const Color(0xFFFF9E57),
                        ),
                      if (doctor.visitTypes.contains('clinic'))
                        _buildVisitTypeBadge(
                          tr('clinicVisitType'),
                          Icons.location_on,
                          const Color(0xFF0A6DD9),
                        ),
                      if (doctor.visitTypes.contains('home'))
                        _buildVisitTypeBadge(
                          tr('homeVisitType'),
                          Icons.home,
                          const Color(0xFF2BB9A9),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Bottom section
                  Container(
                    padding: const EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.grey[200]!)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () =>
                              setState(() => selectedDoctor = doctor),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: doctor.gradientColors[0],
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                          child: Text(tr('bookNow')),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              tr('priceFrom'),
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[500],
                              ),
                            ),
                            Text(
                              '${doctor.price.toInt()} ${tr('pound')}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVisitTypeBadge(String label, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 4),
          Icon(icon, size: 14, color: color),
        ],
      ),
    );
  }

  Widget _buildBookingScreen() {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with doctor info
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: selectedDoctor!.gradientColors,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(48),
                  bottomRight: Radius.circular(48),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // Decorative dots
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(15, (index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              shape: BoxShape.circle,
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 16),

                      // Back button
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          onPressed: () =>
                              setState(() => selectedDoctor = null),
                        ),
                      ),

                      // Doctor profile card
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: selectedDoctor!.gradientColors,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  padding: const EdgeInsets.all(3),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      size: 48,
                                      color: selectedDoctor!.gradientColors[0],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        selectedDoctor!.name,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        selectedDoctor!.specialty,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(selectedDoctor!.location),
                                          const SizedBox(width: 4),
                                          const Icon(
                                            Icons.location_on,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 12),
                                          Text('${selectedDoctor!.rating}'),
                                          const SizedBox(width: 4),
                                          const Icon(
                                            Icons.star,
                                            size: 16,
                                            color: Color(0xFFFF9E57),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${selectedDoctor!.price.toInt()} ${tr('pound')}',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    tr('checkupPrice'),
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Booking form
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Visit type selection
                  Text(
                    tr('visitType'),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      if (selectedDoctor!.visitTypes.contains('video'))
                        Expanded(
                          child: _buildVisitTypeButton(
                            'video',
                            tr('onlineVisitType'),
                            Icons.videocam,
                            const Color(0xFFFF9E57),
                          ),
                        ),
                      if (selectedDoctor!.visitTypes.contains('clinic'))
                        Expanded(
                          child: _buildVisitTypeButton(
                            'clinic',
                            tr('clinicVisitType'),
                            Icons.location_on,
                            const Color(0xFF0A6DD9),
                          ),
                        ),
                      if (selectedDoctor!.visitTypes.contains('home'))
                        Expanded(
                          child: _buildVisitTypeButton(
                            'home',
                            tr('homeVisitType'),
                            Icons.home,
                            const Color(0xFF2BB9A9),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Date selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        tr('chooseDate'),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.calendar_today, color: Colors.grey[600]),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 90,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      itemCount: availableDates.length,
                      itemBuilder: (context, index) {
                        final dateObj = availableDates[index];
                        final isSelected = selectedDate == dateObj['date'];
                        return GestureDetector(
                          onTap: () =>
                              setState(() => selectedDate = dateObj['date']),
                          child: Container(
                            width: 70,
                            margin: const EdgeInsets.only(left: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF2BB9A9)
                                    : Colors.grey[200]!,
                                width: 2,
                              ),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF2BB9A9,
                                        ).withOpacity(0.2),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  dateObj['day']!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  dateObj['dayNum']!,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? const Color(0xFF2BB9A9)
                                        : Colors.grey[800],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Time selection
                  if (selectedDate != null) ...[
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          tr('chooseTime'),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.access_time, color: Colors.grey[600]),
                      ],
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1.8,
                          ),
                      itemCount: timeSlots.length,
                      itemBuilder: (context, index) {
                        final time = timeSlots[index];
                        final isSelected = selectedTime == time;
                        return GestureDetector(
                          onTap: () => setState(() => selectedTime = time),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFFFF9E57)
                                    : Colors.grey[200]!,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                time,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? const Color(0xFFFF9E57)
                                      : Colors.grey[700],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],

                  // Confirm button
                  if (selectedDate != null && selectedTime != null) ...[
                    const SizedBox(height: 32),
                    GestureDetector(
                      onTap: handleBooking,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF2BB9A9), Color(0xFF0A6DD9)],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF2BB9A9).withOpacity(0.4),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              tr('confirmBooking'),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.check, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVisitTypeButton(
    String type,
    String label,
    IconData icon,
    Color color,
  ) {
    final isSelected = visitType == type;
    return GestureDetector(
      onTap: () => setState(() => visitType = type),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : Colors.grey[200]!,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? color : Colors.grey[400], size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
