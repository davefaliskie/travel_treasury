import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_budget/views/navigation_view.dart';
import 'package:travel_budget/views/first_view.dart';
import 'package:travel_budget/views/sign_up_view.dart';
import 'package:travel_budget/widgets/provider_widget.dart';
import 'package:travel_budget/services/auth_service.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:travel_budget/services/admob_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseAdMob.instance.initialize(appId: AdMobService().getAdMobAppId());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      child: MaterialApp(
        title: "Travel Budget App",
        theme: ThemeData(
          primarySwatch: Colors.blue,

          textTheme: TextTheme(
            body1: GoogleFonts.bitter(fontSize: 14.0)
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
        return CircularProgressIndicator();
      },
    );
  }
}

