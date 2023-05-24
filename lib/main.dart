import 'package:elevens_organizer/providers/auth_provider.dart';
import 'package:elevens_organizer/providers/profile_provider.dart';
import 'package:elevens_organizer/utils/colours.dart';
import 'package:elevens_organizer/utils/strings.dart';
import 'package:elevens_organizer/view/auth/login_screen.dart';
import 'package:elevens_organizer/view/auth/register_screen.dart';
import 'package:elevens_organizer/view/menu/menu_screen.dart';
import 'package:elevens_organizer/view/my_matches/my_matches.dart';
import 'package:elevens_organizer/view/notification/notifications_screen.dart';
import 'package:elevens_organizer/view/refer_and_earn/refer_and_earn_screen.dart';
import 'package:elevens_organizer/view/revenue/revenue_screen.dart';
import 'package:elevens_organizer/view/splash_screen.dart';
import 'package:elevens_organizer/view/toss/toss.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: Strings.appName,
            theme: ThemeData(
                primaryColor: AppColor.primaryColor
            ),
            initialRoute: '/',
            routes: {
              '/': (context) => const SplashScreen(),
              'login_screen': (context) => const LoginScreen(),
              'register_screen': (context) => const RegisterScreen(),
              'menu_screen': (context) => const MenuScreen(),
              'my_matches': (context) => const MyMatchesScreen(),
              'notification_screen': (context) => const Notifications(),
              'revenue_screen': (context) => const RevenueScreen(),
              'refer_and_earn_screen': (context) => const ReferAndEarnScreen(),
              'toss': (context) => const Toss(),
            },
          );
        }
    );
  }
}
