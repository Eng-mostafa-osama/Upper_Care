import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class NursePatientsScreen extends StatefulWidget {
  final VoidCallback onBack;
  final Function(String) onNavigate;

  const NursePatientsScreen({
    Key? key,
    required this.onBack,
    required this.onNavigate,
  }) : super(key: key);

  @override
  State<NursePatientsScreen> createState() => _NursePatientsScreenState();
}

class _NursePatientsScreenState extends State<NursePatientsScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  String tr(String key) {
    return AppLocalizations.of(context)?.translate(key) ?? key;
  }

  List<Map<String, dynamic>> get _patients => [
    {
      'id': '1',
      'name': tr('patientAhmed'),
      'age': 45,
      'gender': tr('male'),
      'phone': '01012345678',
      'address': tr('addressAswan1'),
      'lastVisit': '2024-11-28',
      'condition': tr('diabetes'),
      'totalVisits': 8,
    },
    {
      'id': '2',
      'name': tr('patientFatma'),
      'age': 62,
      'gender': tr('female'),
      'phone': '01098765432',
      'address': tr('addressAswan2'),
      'lastVisit': '2024-11-25',
      'condition': tr('bloodPressure'),
      'totalVisits': 12,
    },
    {
      'id': '3',
      'name': tr('patientMahmoud'),
      'age': 35,
      'gender': tr('male'),
      'phone': '01155556666',
      'address': tr('addressKomOmbo'),
      'lastVisit': '2024-11-30',
      'condition': tr('postSurgery'),
      'totalVisits': 5,
    },
    {
      'id': '4',
      'name': tr('patientSarah'),
      'age': 28,
      'gender': tr('female'),
      'phone': '01234567890',
      'address': tr('addressEdfu'),
      'lastVisit': '2024-11-20',
      'condition': tr('pregnancy'),
      'totalVisits': 15,
    },
    {
      'id': '5',
      'name': tr('patientKarim'),
      'age': 55,
      'gender': tr('male'),
      'phone': '01122334455',
      'address': tr('addressAswan1'),
      'lastVisit': '2024-11-29',
      'condition': tr('chronicPain'),
      'totalVisits': 20,
    },
  ];

  List<Map<String, dynamic>> get _filteredPatients {
    if (_searchQuery.isEmpty) return _patients;
    return _patients.where((patient) {
      final name = patient['name'].toString().toLowerCase();
      final phone = patient['phone'].toString();
      final condition = patient['condition'].toString().toLowerCase();
      return name.contains(_searchQuery.toLowerCase()) ||
          phone.contains(_searchQuery) ||
          condition.contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECFDF5),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: _filteredPatients.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: _filteredPatients.length,
                    itemBuilder: (context, index) {
                      return _buildPatientCard(_filteredPatients[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => widget.onNavigate('nurse-add-patient'),
        backgroundColor: const Color(0xFF2BB9A9),
        icon: const Icon(Icons.person_add, color: Colors.white),
        label: Text(
          tr('addPatient'),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2BB9A9), Color(0xFF3BAA5C)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: widget.onBack,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    tr('nursePatients'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${_patients.length} ${tr('patients')}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _searchQuery = value),
                decoration: InputDecoration(
                  hintText: tr('searchPatients'),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFF2BB9A9),
                  ),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_search, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            tr('noPatients'),
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientCard(Map<String, dynamic> patient) {
    return GestureDetector(
      onTap: () => _showPatientDetails(patient),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2BB9A9).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      patient['name'].substring(0, 1),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2BB9A9),
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
                        patient['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${patient['age']} ${tr('years')} • ${patient['gender']}',
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B82F6).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${patient['totalVisits']} ${tr('visits')}',
                        style: const TextStyle(
                          color: Color(0xFF3B82F6),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildPatientInfo(
                    Icons.medical_information,
                    tr('condition'),
                    patient['condition'],
                  ),
                ),
                Expanded(
                  child: _buildPatientInfo(
                    Icons.calendar_today,
                    tr('lastVisit'),
                    patient['lastVisit'],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _callPatient(patient['phone']),
                    icon: const Icon(Icons.phone, size: 18),
                    label: Text(tr('call')),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF2BB9A9),
                      side: const BorderSide(color: Color(0xFF2BB9A9)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _scheduleVisit(patient),
                    icon: const Icon(Icons.add, size: 18),
                    label: Text(tr('scheduleVisit')),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2BB9A9),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientInfo(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(color: Colors.grey[500], fontSize: 11),
            ),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
          ],
        ),
      ],
    );
  }

  void _showPatientDetails(Map<String, dynamic> patient) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(24),
          child: ListView(
            controller: scrollController,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2BB9A9).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      patient['name'].substring(0, 1),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2BB9A9),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  patient['name'],
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  '${patient['age']} ${tr('years')} • ${patient['gender']}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
              const SizedBox(height: 24),
              _buildDetailSection(tr('contactInfo'), [
                _buildDetailRow(Icons.phone, tr('phone'), patient['phone']),
                _buildDetailRow(
                  Icons.location_on,
                  tr('address'),
                  patient['address'],
                ),
              ]),
              const SizedBox(height: 16),
              _buildDetailSection(tr('medicalInfo'), [
                _buildDetailRow(
                  Icons.medical_information,
                  tr('condition'),
                  patient['condition'],
                ),
                _buildDetailRow(
                  Icons.calendar_today,
                  tr('lastVisit'),
                  patient['lastVisit'],
                ),
                _buildDetailRow(
                  Icons.repeat,
                  tr('totalVisits'),
                  '${patient['totalVisits']}',
                ),
              ]),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        widget.onNavigate('nurse-patient-history');
                      },
                      icon: const Icon(Icons.history),
                      label: Text(tr('viewHistory')),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF2BB9A9),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: Color(0xFF2BB9A9)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _scheduleVisit(patient);
                      },
                      icon: const Icon(Icons.add),
                      label: Text(tr('scheduleVisit')),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2BB9A9),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF2BB9A9)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                Text(
                  value,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _callPatient(String phone) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${tr('calling')}: $phone'),
        backgroundColor: const Color(0xFF2BB9A9),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _scheduleVisit(Map<String, dynamic> patient) {
    widget.onNavigate('nurse-new-visit');
  }
}
