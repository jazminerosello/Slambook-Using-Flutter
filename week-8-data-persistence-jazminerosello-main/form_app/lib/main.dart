

import 'package:flutter/material.dart';
import 'provider/slambook_provider.dart';
import 'screens/initialiRoute.dart';
import 'screens/thirdRoute.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => SlambookProvider())),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title: 'Slambook',
    initialRoute: '/friendsPage',
    routes: {
      '/friendsPage': (context) => const InitialRoute(), //main route
    },
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color.fromARGB(255, 251, 254, 255),
        scaffoldBackgroundColor: Color.fromARGB(255, 208, 244, 250),
         textTheme: Theme.of(context).textTheme.apply(
             
              displayColor: const Color(0xff22215B),
              
            ),
      ),
      
    );
  }
}