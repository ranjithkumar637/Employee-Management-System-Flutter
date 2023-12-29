
import 'package:elevens_organizer/providers/auth_provider.dart';
import 'package:elevens_organizer/providers/booking_provider.dart';
import 'package:elevens_organizer/providers/navigation_provider.dart';
import 'package:elevens_organizer/providers/payment_info_provider.dart';
import 'package:elevens_organizer/providers/profile_provider.dart';
import 'package:elevens_organizer/providers/team_provider.dart';
import 'package:elevens_organizer/utils/colours.dart';
import 'package:elevens_organizer/utils/connectivity_service.dart';
import 'package:elevens_organizer/utils/connectivity_status.dart';
import 'package:elevens_organizer/utils/local_notification_service.dart';
import 'package:elevens_organizer/utils/strings.dart';
import 'package:elevens_organizer/view/auth/login_screen.dart';
import 'package:elevens_organizer/view/auth/register_screen.dart';
import 'package:elevens_organizer/view/menu/menu_screen.dart';
import 'package:elevens_organizer/view/more/block_slot_date.dart';
import 'package:elevens_organizer/view/more/request_player.dart';
import 'package:elevens_organizer/view/my_bookings/bookings.dart';
import 'package:elevens_organizer/view/my_matches/my_matches.dart';
import 'package:elevens_organizer/view/notification/notifications_screen.dart';
import 'package:elevens_organizer/view/payment/payment_information.dart';
import 'package:elevens_organizer/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

///Receive message when app is in background solution for on message
Future<void> backgroundHandler(RemoteMessage message) async{
  print(message.data.toString());
  print(message.notification!.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // if(!kDebugMode){
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  // }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => TeamProvider()),
        ChangeNotifierProvider(create: (context) => BookingProvider()),
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
        ChangeNotifierProvider(create: (context) => PaymentInfoProvider()),
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

  saveToken(String? token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("device_token" , token.toString());
  }

  initiateNotifications() async {
    String? fcmToken;
    await FirebaseMessaging.instance.getToken().then((value) async {
      if (fcmToken != "") {
        print("firebase token: $value");
        fcmToken = value;
        saveToken(fcmToken);
      }
      return;
    });
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
      // final player = AudioPlayer();
      // player.play(AssetSource("notification.mp3"));
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

  // static const String oneSignalAppId = "16090413-4b70-4c0b-a9f4-dd43c445ccee";
  // Future<void> initPlatformState() async {
  //   OneSignal.initialize(oneSignalAppId);
  //   OneSignal.Notifications.requestPermission(true);
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initiateNotifications();
    // initPlatformState();
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
