import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'providers/locale_provider.dart';
import 'providers/auth_provider.dart';

// Patient Screens
import 'screens/user/auth_screen.dart';
import 'screens/user/home_screen.dart';
import 'screens/user/medicine_store.dart';
import 'screens/doctor/doctor_booking.dart';
import 'screens/user/telemedicine_screen.dart';
import 'screens/user/donation_screen.dart';
import 'screens/user/health_awareness_screen.dart';
import 'screens/user/profile_screen.dart';
import 'screens/user/labs_screen.dart';
import 'screens/user/medical_devices_screen.dart';

// Doctor Screens
import 'screens/doctor/doctor_dashboard.dart';
import 'screens/doctor/doctor_appointments.dart';
import 'screens/doctor/doctor_telemedicine.dart';
import 'screens/doctor/doctor_chat.dart';
import 'screens/doctor/doctor_schedule.dart';
import 'screens/doctor/doctor_earnings.dart';
import 'screens/doctor/doctor_profile.dart';
import 'screens/doctor/doctor_content.dart';
import 'screens/doctor/doctor_prescription.dart';

// Nurse Screens
import 'screens/nurse/nurse_dashboard.dart';
import 'screens/nurse/nurse_edit_profile.dart';
import 'screens/nurse/nurse_appointments.dart';
import 'screens/nurse/nurse_patients.dart';
import 'screens/nurse/nurse_new_visit.dart';
import 'screens/nurse/nurse_schedule.dart';
import 'screens/nurse/nurse_supplies.dart';
import 'screens/nurse/nurse_add_patient.dart';
import 'screens/nurse/nurse_notifications.dart';
import 'screens/nurse/nurse_settings.dart';

// Admin Screens
import 'screens/admin/admin_dashboard.dart';
import 'screens/admin/admin_users.dart';
import 'screens/admin/admin_orders.dart';
import 'screens/admin/admin_inventory.dart';
import 'screens/admin/admin_reports.dart';
import 'screens/admin/admin_payments.dart';
import 'screens/admin/admin_settings.dart';
import 'screens/admin/admin_doctors.dart';
import 'screens/admin/admin_order_details.dart';
import 'screens/admin/admin_notifications.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    localeProvider.addListener(_onLocaleChanged);
  }

  @override
  void dispose() {
    localeProvider.removeListener(_onLocaleChanged);
    super.dispose();
  }

  void _onLocaleChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final locale = localeProvider.locale;

    return MaterialApp(
      title: 'UpperCare',
      debugShowCheckedModeBanner: false,
      locale: locale,
      supportedLocales: const [Locale('ar'), Locale('en')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: locale.languageCode == 'ar' ? 'Cairo' : null,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0A6DD9),
          primary: const Color(0xFF0A6DD9),
          secondary: const Color(0xFF2BB9A9),
        ),
      ),
      builder: (context, child) {
        return Directionality(
          textDirection: locale.languageCode == 'ar'
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: child!,
        );
      },
      home: const AppNavigator(),
    );
  }
}

class AppNavigator extends StatefulWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  State<AppNavigator> createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  String currentScreen = 'auth';
  String userRole = 'patient';
  Map<String, dynamic>? selectedOrderData;

  @override
  void initState() {
    super.initState();
    localeProvider.addListener(_onLocaleChanged);
  }

  @override
  void dispose() {
    localeProvider.removeListener(_onLocaleChanged);
    super.dispose();
  }

  void _onLocaleChanged() {
    setState(() {});
  }

  void navigateTo(String screen) {
    setState(() {
      currentScreen = screen;
    });
  }

  void handleAuthComplete(String role) {
    setState(() {
      userRole = role;
      switch (role) {
        case 'doctor':
          currentScreen = 'doctor-dashboard';
          break;
        case 'nurse':
          currentScreen = 'nurse-dashboard';
          break;
        case 'admin':
          currentScreen = 'admin-dashboard';
          break;
        default:
          currentScreen = 'home';
      }
    });
  }

  void handleCategorySelect(String category) {
    switch (category) {
      case 'medicines':
        navigateTo('medicines');
        break;
      case 'devices':
        navigateTo('devices');
        break;
      case 'doctors':
        navigateTo('doctors');
        break;
      case 'telemedicine':
        navigateTo('telemedicine');
        break;
      case 'donations':
        navigateTo('donations');
        break;
      case 'awareness':
        navigateTo('awareness');
        break;
      case 'labs':
        navigateTo('labs');
        break;
      case 'profile':
        navigateTo('profile');
        break;
      default:
        break;
    }
  }

  Future<void> handleLogout() async {
    await authProvider.logout();
    setState(() {
      currentScreen = 'auth';
      userRole = 'patient';
    });
  }

  void viewOrderDetails(Map<String, dynamic> order) {
    setState(() {
      selectedOrderData = order;
      currentScreen = 'admin-order-details';
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (currentScreen) {
      // ==================== AUTH SCREEN ====================
      case 'auth':
        return AuthScreen(onComplete: handleAuthComplete, userRole: userRole);

      // ==================== PATIENT SCREENS ====================
      case 'home':
        return HomeScreen(onCategorySelect: handleCategorySelect);

      case 'medicines':
        return MedicineStore(onBack: () => navigateTo('home'));

      case 'devices':
        return MedicalDevicesScreen(onBack: () => navigateTo('home'));

      case 'doctors':
        return DoctorBooking(onBack: () => navigateTo('home'));

      case 'telemedicine':
        return TelemedicineScreen(onBack: () => navigateTo('home'));

      case 'donations':
        return DonationScreen(onBack: () => navigateTo('home'));

      case 'awareness':
        return HealthAwarenessScreen(onBack: () => navigateTo('home'));

      case 'profile':
        return ProfileScreen(
          onBack: () => navigateTo('home'),
          onLogout: handleLogout,
        );

      case 'labs':
        return LabsScreen(onBack: () => navigateTo('home'));

      // ==================== DOCTOR SCREENS ====================
      case 'doctor-dashboard':
        return DoctorDashboard(onNavigate: navigateTo);

      case 'doctor-appointments':
        return DoctorAppointments(
          onBack: () => navigateTo('doctor-dashboard'),
          onNavigate: navigateTo,
        );

      case 'doctor-telemedicine':
        return DoctorTelemedicine(
          onBack: () => navigateTo('doctor-dashboard'),
          onNavigate: navigateTo,
        );

      case 'doctor-chat':
        return DoctorChat(onBack: () => navigateTo('doctor-dashboard'));

      case 'doctor-schedule':
        return DoctorSchedule(onBack: () => navigateTo('doctor-dashboard'));

      case 'doctor-earnings':
        return DoctorEarnings(onBack: () => navigateTo('doctor-dashboard'));

      case 'doctor-profile':
        return DoctorProfile(
          onBack: () => navigateTo('doctor-dashboard'),
          onNavigate: navigateTo,
        );

      case 'doctor-content':
        return DoctorContent(onBack: () => navigateTo('doctor-dashboard'));

      case 'doctor-prescription':
        return DoctorPrescription(onBack: () => navigateTo('doctor-dashboard'));

      // ==================== ADMIN SCREENS ====================
      case 'admin-dashboard':
        return AdminDashboard(onNavigate: navigateTo);

      case 'admin-users':
        return AdminUsers(onBack: () => navigateTo('admin-dashboard'));

      case 'admin-orders':
        return AdminOrders(
          onBack: () => navigateTo('admin-dashboard'),
          onViewDetails: viewOrderDetails,
        );

      case 'admin-order-details':
        return AdminOrderDetails(
          onBack: () => navigateTo('admin-orders'),
          orderData: selectedOrderData ?? {},
        );

      case 'admin-inventory':
        return AdminInventory(onBack: () => navigateTo('admin-dashboard'));

      case 'admin-doctors':
        return AdminDoctors(onBack: () => navigateTo('admin-dashboard'));

      case 'admin-reports':
        return AdminReports(onBack: () => navigateTo('admin-dashboard'));

      case 'admin-payments':
        return AdminPayments(onBack: () => navigateTo('admin-dashboard'));

      case 'admin-settings':
        return AdminSettings(
          onBack: () => navigateTo('admin-dashboard'),
          onLogout: handleLogout,
        );

      case 'admin-notifications':
        return AdminNotifications(onBack: () => navigateTo('admin-dashboard'));

      // ==================== NURSE SCREENS ====================
      case 'nurse-dashboard':
        return NurseDashboard(onLogout: handleLogout, onNavigate: navigateTo);

      case 'nurse-edit-profile':
        return NurseEditProfile(onBack: () => navigateTo('nurse-dashboard'));

      case 'nurse-appointments':
        return NurseAppointmentsScreen(
          onBack: () => navigateTo('nurse-dashboard'),
          onNavigate: navigateTo,
        );

      case 'nurse-patients':
        return NursePatientsScreen(
          onBack: () => navigateTo('nurse-dashboard'),
          onNavigate: navigateTo,
        );

      case 'nurse-new-visit':
        return NurseNewVisitScreen(
          onBack: () => navigateTo('nurse-dashboard'),
          onNavigate: navigateTo,
        );

      case 'nurse-schedule':
        return NurseScheduleScreen(
          onBack: () => navigateTo('nurse-dashboard'),
          onNavigate: navigateTo,
        );

      case 'nurse-supplies':
        return NurseSuppliesScreen(
          onBack: () => navigateTo('nurse-dashboard'),
          onNavigate: navigateTo,
        );

      case 'nurse-add-patient':
        return NurseAddPatientScreen(
          onBack: () => navigateTo('nurse-patients'),
          onNavigate: navigateTo,
        );

      case 'nurse-notifications':
        return NurseNotificationsScreen(
          onBack: () => navigateTo('nurse-dashboard'),
        );

      case 'nurse-settings':
        return NurseSettingsScreen(
          onBack: () => navigateTo('nurse-dashboard'),
          onNavigate: navigateTo,
        );

      // ==================== DEFAULT ====================
      default:
        return AuthScreen(onComplete: handleAuthComplete, userRole: userRole);
    }
  }
}
