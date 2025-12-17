import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fripesfinderv2/utils/colors.dart';
import 'package:fripesfinderv2/features/shared/splash_screen.dart';
import 'lib/screens/auth/auth_screen.dart';
import 'package:fripesfinderv2/features/auth/signup_screen.dart';
import 'lib/screens/home/home_screen.dart';
import 'package:fripesfinderv2/features/rewards/rewards_screen.dart';
import 'package:fripesfinderv2/providers/auth_provider.dart' as auth_provider;
import 'package:fripesfinderv2/providers/rewards_provider.dart';
import 'package:fripesfinderv2/services/home_service.dart';
import 'package:fripesfinderv2/services/outfit_service.dart';
import 'package:fripesfinderv2/services/place_service.dart';
import 'package:fripesfinderv2/services/profile_service.dart';
import 'package:fripesfinderv2/services/notification_service.dart';
import 'firebase_options.dart';

class RouteNames {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
}

void main() async {
  // 1. Initialisation du moteur Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Initialisation de Firebase (Rapide et essentiel)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // NOTE : J'ai retiré le blocage 'await homeService.setQuoteOfTheDay()' ici.
  // Cela permet à l'application de s'afficher immédiatement.
  // La récupération de la citation se fera en arrière-plan via le Service.

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => auth_provider.AuthProvider()),
        ChangeNotifierProvider(create: (_) => RewardsProvider()),
        // Injection des Services (Singletons)
        Provider<HomeService>(create: (_) => HomeService()), // Ajouté ici !
        Provider<OutfitService>(create: (_) => OutfitService()),
        Provider<PlaceService>(create: (_) => PlaceService()),
        Provider<ProfileService>(create: (_) => ProfileService()),
        Provider<NotificationService>(create: (_) => NotificationService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FripesFinder',
      debugShowCheckedModeBanner: false, // Enlève le bandeau DEBUG
      theme: AppTheme.theme,
      initialRoute: RouteNames.splash,
      routes: {
        RouteNames.splash: (context) => const AuthWrapper(),
        RouteNames.login: (context) => const LoginScreen(),
        RouteNames.signup: (context) => const SignUpScreen(),
        RouteNames.home: (context) => const HomeScreen(),
      },
    );
  }
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryBlue,
        primary: AppColors.primaryBlue,
        secondary: AppColors.secondaryMauve,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryBlue,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primaryBlue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
        ),
        labelStyle: const TextStyle(color: AppColors.primaryBlue),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<auth_provider.AuthProvider>(context);

    return StreamBuilder<User?>(
      stream: authProvider.userChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Une erreur s'est produite : ${snapshot.error}"),
            ),
          );
        }
        if (snapshot.hasData) {
          // L'utilisateur est connecté, on peut lancer des initialisations d'arrière-plan ici si nécessaire
          return const HomeScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}