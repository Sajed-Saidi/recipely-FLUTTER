import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:recipely/GLOBAL.dart';
import 'package:recipely/theme_notifier.dart';
import 'package:recipely/user.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool loading = false;

  void updateRegister(String message, bool success) {
    setState(() {
      loading = false;
    });

    if (success) {
      Global.globalUser = getUser();
      Navigator.of(context).pushReplacementNamed("home");
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  void update(bool success) {
    setState(() {
      loading = false;
    });
    if (!success) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Something Went Wrong!')));
    } else {
      if (userExists()) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User Already Exists!')));
      } else {
        addUser(updateRegister, emailController.text.trim(),
            passwordController.text.trim());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<ThemeNotifier>(
                builder: (context, notifier, child) => Stack(children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Image.asset(
                      "images/Rectangle 3.png",
                      color: Color(0x4070B9BE),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Image.asset(
                      "images/Rectangle 4.png",
                      color: Color(0x4070B9BE),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Stack(
                            children: [
                              Positioned(
                                top: -10,
                                right: -20,
                                child: Image.asset(
                                  "images/Ellipse 1.png",
                                  color: Color(0x4070B9BE),
                                ),
                              ),
                              Positioned(
                                top: -30,
                                right: -30,
                                child: Image.asset(
                                  "images/Ellipse 2.png",
                                  color: Color(0x4070B9BE),
                                ),
                              ),
                              Positioned(
                                top: 100,
                                left: 50,
                                right: 50,
                                child: Column(
                                  children: [
                                    Text(
                                      "Create Account",
                                      style: TextStyle(
                                        color: Color(notifier.mainColor),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Create an account so you can explore all the existing recipes ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 250,
                                left: 40,
                                right: 40,
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(notifier.mainColor),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          label: const Text(
                                            "Email",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        controller: emailController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your email';
                                          }
                                          final emailRegex =
                                              RegExp(r'^[^@]+@[^@]+\.[^@]+');
                                          if (!emailRegex.hasMatch(value)) {
                                            return 'Please enter a valid email';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      TextFormField(
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(notifier.mainColor),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          label: const Text(
                                            "Password",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        controller: passwordController,
                                        obscureText: true,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your password';
                                          }
                                          if (value.length < 6) {
                                            return 'Password must be at least 6 characters long';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      TextFormField(
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(notifier.mainColor),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          label: const Text(
                                            "Confirm Password",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        controller: confirmPasswordController,
                                        obscureText: true,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please confirm your password';
                                          }
                                          if (value !=
                                              passwordController.text) {
                                            return 'Passwords do not match';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        width: 250,
                                        height: 55,
                                        child: MaterialButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          color: Color(notifier.mainColor),
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              setState(() {
                                                loading = true;
                                                checkUserEmail(
                                                    emailController.text.trim(),
                                                    update);
                                              });
                                            }
                                          },
                                          child: const Text(
                                            "Sign up",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                      "login");
                                            },
                                            child: const Text(
                                              "Already have an account",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Or continue with",
                                            style: TextStyle(
                                              color: Color(notifier.mainColor),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 60,
                                            height: 55,
                                            child: MaterialButton(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              color: const Color.fromARGB(
                                                  255, 205, 205, 205),
                                              onPressed: () {},
                                              child: const Icon(
                                                  FontAwesomeIcons.google),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: 60,
                                            height: 55,
                                            child: MaterialButton(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              color: const Color.fromARGB(
                                                  255, 205, 205, 205),
                                              onPressed: () {},
                                              child: const Icon(
                                                  FontAwesomeIcons.facebook),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: 60,
                                            height: 55,
                                            child: MaterialButton(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              color: const Color.fromARGB(
                                                  255, 205, 205, 205),
                                              onPressed: () {},
                                              child: const Icon(
                                                  FontAwesomeIcons.apple),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ));
  }
}
