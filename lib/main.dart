import 'package:flutter/material.dart';
import 'package:insta_class/auth_wrapper.dart';
import 'package:insta_class/firebase_options.dart';
import 'package:insta_class/screens/auth/forgot_password_screen.dart';
import 'package:insta_class/screens/auth/login_screen.dart';
import 'package:insta_class/screens/auth/sign_up_screen.dart';
import 'package:insta_class/screens/courses_page.dart';
import 'package:insta_class/screens/home/home_screen.dart';
import 'package:insta_class/screens/pages_home/user_info_screen.dart';
import 'package:insta_class/view_models/auth_viewmodel.dart';
import 'package:insta_class/view_models/data_from_firestore_view_model.dart';
import 'package:insta_class/view_models/localization_view_model.dart';
import 'package:insta_class/view_models/user_repository_view_model.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthViewmodel()),
        ChangeNotifierProvider(
          create: (context) {
            final localizationVM = LocalizationViewModel();
            localizationVM.loadTranslations();
            return localizationVM;
          },
        ),
        ChangeNotifierProvider(create: (context) => UserRepositoryViewModel()),
        ChangeNotifierProvider(
          create: (create) => DataFromFirestoreViewModel(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final translation = Provider.of<LocalizationViewModel>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale(translation.currentLocale),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('ar')],
      home: AuthWrapper(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/forgot': (context) => ForgotPassword(),
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => HomeScreen(),
        "/page": (context) => PageCourses(),
        "/profile": (context) => InfoUserScreen(),
      },
    );
  }
}
