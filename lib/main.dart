import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/Pages/SignInPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase_demo/Pages/MainTabbarPage.dart';
import 'package:flutter_firebase_demo/Service/ApiClient.dart';
import 'ViewModel/ListViewModel.dart';


final ListViewModel listViewModel = ListViewModel(apiSvc: ApiClient());

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );

  }
}

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot)
    {
      // Check for errors
      if (snapshot.hasError) {
        return Scaffold(
          body: Center(
            child: Text("Error: ${snapshot.error}"),
          ),
        );
      }

      // Once complete, show your application
      if (snapshot.connectionState == ConnectionState.done) {
        return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                User user = snapshot.data;
                if (user == null) {
                  return SignIn();
                } else {
                  return  new CupertinoApp(
                    home: new MainTabbarPage(listViewModel: listViewModel),
                    localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
                      DefaultMaterialLocalizations.delegate,
                      DefaultWidgetsLocalizations.delegate,
                    ],
                  );
                }
              } else {
                return Scaffold(
                  body: Center(
                    child: Text("Checking Authentication ..."),
                  ),
                );
              }
            }

        );
      } else {
        return Scaffold(
          body: Center(
            child: Text("Connecting to the app ..."),
          ),
        );
      }
    }
    );
  }
}