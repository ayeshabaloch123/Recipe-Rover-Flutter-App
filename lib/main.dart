import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:recipe_rover/HomePage.dart';
import 'package:recipe_rover/SplashScreen.dart';
import 'package:recipe_rover/firebase_options.dart';
import 'package:recipe_rover/signIn.dart';
import 'package:recipe_rover/signUp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/recipe': (context) => MyHomePage(
              title: "Recipe Rover App",
            ),

        '/home': (context) => HomePage(),
        '/signin': (context) => SignInForm(),
        '/signup': (context) => RegistrationForm(),
        // Add other routes as needed
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.orange,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orangeAccent,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            textStyle: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      home: const MyHomePage(title: 'Recipe Rover'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Center(),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 500,
                width: 400,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/logo.png"),
                  ),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInForm(),
                      ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 90),
                  child: Text(
                    'Log In',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegistrationForm(),
                      ));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 90),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
