import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:elevens_organizer/providers/auth_provider.dart';
import 'package:elevens_organizer/providers/booking_provider.dart';
import 'package:elevens_organizer/providers/navigation_provider.dart';
import 'package:elevens_organizer/providers/profile_provider.dart';
import 'package:elevens_organizer/providers/team_provider.dart';
import 'package:elevens_organizer/utils/colours.dart';
import 'package:elevens_organizer/utils/connectivity_service.dart';
import 'package:elevens_organizer/utils/connectivity_status.dart';
import 'package:elevens_organizer/utils/local_notification_service.dart';
import 'package:elevens_organizer/utils/strings.dart';
import 'package:elevens_organizer/view/address/add_address.dart';
import 'package:elevens_organizer/view/auth/login_screen.dart';
import 'package:elevens_organizer/view/auth/register_screen.dart';
import 'package:elevens_organizer/view/menu/menu_screen.dart';
import 'package:elevens_organizer/view/more/block_slot_date.dart';
import 'package:elevens_organizer/view/more/request_player.dart';
import 'package:elevens_organizer/view/my_bookings/bookings.dart';
import 'package:elevens_organizer/view/my_matches/my_matches.dart';
import 'package:elevens_organizer/view/my_team/create_team.dart';
import 'package:elevens_organizer/view/notification/notifications_screen.dart';
import 'package:elevens_organizer/view/payment/payment_information.dart';
import 'package:elevens_organizer/view/profile/edit_profile.dart';
import 'package:elevens_organizer/view/refer_and_earn/refer_and_earn_screen.dart';
import 'package:elevens_organizer/view/revenue/revenue_screen.dart';
import 'package:elevens_organizer/view/splash_screen.dart';
import 'package:elevens_organizer/view/toss/toss.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

///Receive message when app is in background solution for on message
Future<void> backgroundHandler(RemoteMessage message) async{
  print(message.data.toString());
  print(message.notification!.title);
  // LocalNotificationService.display(message);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => TeamProvider()),
        ChangeNotifierProvider(create: (context) => BookingProvider()),
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  initiateNotifications() async {
    await FirebaseMessaging.instance.requestPermission(
        sound: true,
        badge: true,
        alert: true
    );
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        sound: true,
        badge: true,
        alert: true
    );

    //terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if(message?.notification != null){
        print(message?.notification!.body);
        print(message?.notification!.title);
      }
      // LocalNotificationService.display(message);
    });

    ///foreground work
    FirebaseMessaging.onMessage.listen((message) {
      if(message.notification != null){
        print(message.notification!.body);
        print(message.notification!.title);
      }
      LocalNotificationService.display(message);
    });

    ///When the app is in background but opened and user taps
    ///on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if(message.notification != null){
        print(message.notification!.body);
        print(message.notification!.title);
      }
      // LocalNotificationService.display(message);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initiateNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) {
          return StreamProvider<ConnectivityStatus>(
              initialData: ConnectivityStatus.offline,
              create: (context) => ConnectivityService().connectionStatusController.stream,
              child: MaterialApp(
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
                  'edit_profile': (context) => const EditProfile(),
                  'add_address': (context) => const AddAddress(),
                  'payment_information': (context) => const PaymentInformation(),
                  'my_bookings': (context) => const MyBookings(),
                  'block_slot_date': (context) => const BlockSlotDate(),
                  'request_player': (context) => const RequestPlayer(),
                },
              ),
          );
        }
    );
  }
}
