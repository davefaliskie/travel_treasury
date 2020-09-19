import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_budget/services/custom_colors.dart';
import 'package:travel_budget/views/navigation_view.dart';
import 'package:travel_budget/views/first_view.dart';
import 'package:travel_budget/views/sign_up_view.dart';
import 'package:travel_budget/widgets/provider_widget.dart';
import 'package:travel_budget/services/auth_service.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:travel_budget/services/admob_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAdMob.instance.initialize(appId: AdMobService().getAdMobAppId());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  var colors = CustomColors(WidgetsBinding.instance.window.platformBrightness);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    setState(() {
      colors = CustomColors(WidgetsBinding.instance.window.platformBrightness);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      db: FirebaseFirestore.instance,
      colors: colors,
      child: MaterialApp(
        title: "Travel Budget App",
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,

          textTheme: TextTheme(
            bodyText2: GoogleFonts.bitter(fontSize: 14.0)
          )
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
            primarySwatch: Colors.blue,

            textTheme: TextTheme(
                bodyText2: GoogleFonts.bitter(fontSize: 14.0)
            )
        ),
        home: HomeController(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => HomeController(),
          '/signUp': (BuildContext context) => SignUpView(authFormType: AuthFormType.signUp),
          '/signIn': (BuildContext context) => SignUpView(authFormType: AuthFormType.signIn),
          '/anonymousSignIn': (BuildContext context) => SignUpView(authFormType: AuthFormType.anonymous),
          '/convertUser': (BuildContext context) => SignUpView(authFormType: AuthFormType.convert),
        },
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? Home() : FirstView();
        }
        return Container();
      },
    );
  }
}

