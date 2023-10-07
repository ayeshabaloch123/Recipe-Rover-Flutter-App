import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_rover/HomePage.dart';
import 'package:recipe_rover/authService.dart';

class SignInForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    signIn() async {
      try {
        if (_formKey.currentState?.validate() ?? false) {
          final User? user = await authService.signIn(
            emailController.text,
            passwordController.text,
          );

          if (user != null) {
            final userDetails = await authService.getUserDetails(user.email!);

            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("You successfully signed in!"),
                backgroundColor: Colors.orange,
              ),
            );

            // Delay navigation to allow SnackBar to be displayed
            await Future.delayed(Duration(seconds: 2));

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          } else {
            // User is not registered or password is incorrect
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Invalid email or password"),
                backgroundColor: Colors.orange,
              ),
            );
          }
        }
      } catch (e) {
        print("Error during sign-in: $e");
        // Handle other errors, if any
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went wrong! Please try again."),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.orange[500]!,
            Colors.orange[300]!,
            Colors.orange[300]!
          ]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 80,
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Welcome Back",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 60,
                          ),
                          AnimatedOpacity(
                              opacity: 1.0,
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeInOut,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(88, 22, 94, 0.298),
                                      blurRadius: 20,
                                      offset: Offset(0, 10),
                                    )
                                  ],
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.grey[200]!,
                                          ),
                                        ),
                                      ),
                                      child: TextFormField(
                                        controller: emailController,
                                        decoration: const InputDecoration(
                                          hintText: "Email ",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none,
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter your email';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.grey[200]!,
                                          ),
                                        ),
                                      ),
                                      child: TextFormField(
                                          controller: passwordController,
                                          obscureText: true,
                                          decoration: const InputDecoration(
                                            hintText: "Password",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none,
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter your password';
                                            }
                                            return null;
                                          }),
                                    ),
                                  ],
                                ),
                              )),
                          const SizedBox(height: 20.0),
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  signIn();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange[500],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  elevation: 2,
                                  minimumSize: const Size(200, 50),
                                ),
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Text(
                                'Forgot Password?',
                                style: TextStyle(color: Colors.blueGrey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                            child: const Text(
                              "Don't have an account? Sign Up",
                              style: TextStyle(color: Colors.blueGrey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
