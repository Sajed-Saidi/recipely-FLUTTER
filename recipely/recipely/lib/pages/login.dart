import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:recipely/theme_notifier.dart';
import 'package:recipely/user.dart';
import 'package:recipely/GLOBAL.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  void update(bool success) {
    loading = false;
    setState(() {
      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Something Went Wrong!')));
      } else {
        if (userExists()) {
          Global.globalUser = getUser();
          // ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(content: Text('Login Successfully!')));
          Navigator.of(context).pushReplacementNamed("home");
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('User Not Found!')));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<ThemeNotifier>(
                builder: (context, notifier, child) => Container(
                  child: Stack(children: [
                    Positioned(
                      bottom: 2,
                      left: 2,
                      child: Container(
                        child: Image.asset(
                          "images/Rectangle 3.png",
                          color: Color(0x4070B9BE),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 2,
                      left: 2,
                      child: Container(
                        child: Image.asset(
                          "images/Rectangle 4.png",
                          color: Color(0x4070B9BE),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Stack(
                            children: [
                              Positioned(
                                top: -10,
                                right: -20,
                                child: Container(
                                  child: Image.asset(
                                    "images/Ellipse 1.png",
                                    color: Color(0x4070B9BE),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: -30,
                                right: -30,
                                child: Container(
                                  child: Image.asset(
                                    "images/Ellipse 2.png",
                                    color: Color(0x4070B9BE),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 100,
                                left: 50,
                                child: Column(
                                  children: [
                                    Text(
                                      "Login here",
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
                                      "Welcome back you've been missed! ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 300,
                                left: 40,
                                child: Column(
                                  children: [
                                    Container(
                                      width: 330,
                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              cursorColor: Colors.black,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(
                                                        notifier.mainColor),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                                label: const Text(
                                                  "Email",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              controller: emailController,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter your email';
                                                }
                                                final emailRegex = RegExp(
                                                    r'^[^@]+@[^@]+\.[^@]+');
                                                if (!emailRegex
                                                    .hasMatch(value)) {
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
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(
                                                        notifier.mainColor),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                                label: const Text(
                                                  "Password",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              controller: passwordController,
                                              obscureText: true,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter your password';
                                                }
                                                return null;
                                              },
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  onPressed: () {},
                                                  child: Text(
                                                    "Forgot your password?",
                                                    style: TextStyle(
                                                      color: Color(
                                                          notifier.mainColor),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              width: 250,
                                              height: 55,
                                              child: MaterialButton(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                                color:
                                                    Color(notifier.mainColor),
                                                onPressed: () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    setState(() {
                                                      loading = true;
                                                      findUser(
                                                          emailController.text,
                                                          passwordController
                                                              .text,
                                                          update);
                                                    });
                                                  }
                                                },
                                                child: const Text(
                                                  "Login",
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
                                                            "signUp");
                                                  },
                                                  child: const Text(
                                                    "Create new account",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
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
                                                Text(
                                                  "Or continue with",
                                                  style: TextStyle(
                                                    color: Color(
                                                        notifier.mainColor),
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
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                    ),
                                                    color: const Color.fromARGB(
                                                        255, 205, 205, 205),
                                                    onPressed: () {},
                                                    child: const Icon(
                                                        FontAwesomeIcons
                                                            .google),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  width: 60,
                                                  height: 55,
                                                  child: MaterialButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                    ),
                                                    color: const Color.fromARGB(
                                                        255, 205, 205, 205),
                                                    onPressed: () {},
                                                    child: const Icon(
                                                        FontAwesomeIcons
                                                            .facebook),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  width: 60,
                                                  height: 55,
                                                  child: MaterialButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
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
                    )
                  ]),
                ),
              ));
  }
}
