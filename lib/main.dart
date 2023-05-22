import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Cubit/cubit.dart';
import 'Screens/LoginScreen/splash.dart';
import 'Shared_Pref/Share_Pref.dart';
import 'Screens/Social_Layout.dart';
import 'Theme/theme.dart';
import 'imp_func.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  showtoast('on background Message');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Sharepref.init();
  await Firebase.initializeApp();
  var Token =await FirebaseMessaging.instance.getToken();
  print( Token);
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    print('on Message');
    showtoast('on Message');
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
      showtoast('on Message Opened App');
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Widget widget;
  var UID = Sharepref.getdata(key: "U_ID");

  if (UID != null) {
    widget = const Social_layout();
  } else {
    widget = MainSplashScreen();
  }
  runApp(MyApp(
    Start_widget: widget,
  ));
}

class MyApp extends StatelessWidget {
  Widget Start_widget;
  MyApp({required this.Start_widget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SocialAppCubit()
              ..GetUserData()
              ..GetPost(),
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.teal,
          ),
          // home:  MainSplashScreen(),
          darkTheme: Themes.dark,
          themeMode: ThemeMode.light,
          home: Start_widget,
        ));
  }
}
