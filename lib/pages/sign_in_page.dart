import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

import 'forget_password_page.dart';
import 'home_page.dart';

class SignInPage extends StatefulWidget {

  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  
  final _username = TextEditingController();
  final _password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String name = "";
  bool loading = false;
  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Form(
                key: formKey,
                child: Container(
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 195),
                      child: Text(
                        "EXPLORA",
                        style: GoogleFonts.orbitron(
                            fontSize: 34,
                            letterSpacing: 5,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 6, 36, 8)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        "- SIGN IN -",
                        style: GoogleFonts.orbitron(
                            fontSize: 12,
                            letterSpacing: 3,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 6, 36, 8)),
                      ),
                    ),
                    SizedBox(
                      height: 65,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: TextFormField(
                        controller: _username,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(10.0),
                            isDense: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(45),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 6, 36, 8),
                                  width: 1.5),
                            ),
                            filled: true,
                            hintText: 'Email ID',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(45))),
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            return "Invalid Email Format";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: TextFormField(
                          controller: _password,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.all(10.0),
                              isDense: true,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(45),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 6, 36, 8),
                                    width: 1.5),
                              ),
                              filled: true,
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(45),
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password should not be empty";
                            } else {
                              return null;
                            }
                          }),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    loading
                        ? const CircularProgressIndicator(
                            color: Color.fromARGB(255, 6, 36, 8),
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width / 2.6,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  loading = true;
                                });
                                if (formKey.currentState!.validate()) {
                                  try {
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                      email: _username.text.trim(),
                                      password: _password.text.trim(),
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage()),
                                    );
                                  } on FirebaseAuthException catch (e) {
                                    if (e.message ==
                                        'There is no user record corresponding to this identifier. The user may have been deleted.') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar( SnackBar(
                                              backgroundColor:
                                                  Color.fromARGB(255, 6, 36, 8),
                                              content: Text(
                                                'User not found',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.orbitron(
                                                    fontSize: 10,
                                                    letterSpacing: 0.5,
                                                    // fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )));
                                    } else if (e.message ==
                                        'The password is invalid or the user does not have a password.') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar( SnackBar(
                                              backgroundColor:
                                                  Color.fromARGB(255, 6, 36, 8),
                                              content: Text(
                                                'Password Incorrect',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.orbitron(
                                                    fontSize: 10,
                                                    letterSpacing: 0.5,
                                                    // fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )));
                                    } else if (e.message ==
                                        'A network error (such as timeout, interrupted connection or unreachable host) has occurred.') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar( SnackBar(
                                              backgroundColor:
                                                  Color.fromARGB(255, 6, 36, 8),
                                              content: Text(
                                                'Check your internet',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.orbitron(
                                                    fontSize: 10,
                                                    letterSpacing: 0.5,
                                                    // fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 6, 36, 8),
                                              content: Text(
                                                'Contact Support Team With Error Details"${e.message.toString()}"',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.orbitron(
                                                    fontSize: 10,
                                                    letterSpacing: 0.5,
                                                    // fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )));
                                    }

                                    print(e);
                                  }
                                }
                                setState(() {
                                  loading = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 6, 36, 8),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                              ),
                              child: Text('Sign In',
                                  style: GoogleFonts.orbitron(
                                      fontSize: 13,
                                      wordSpacing: 1,
                                      letterSpacing: 1)),
                            ),
                          ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 128),
                      child: Divider(
                        color: Color.fromARGB(255, 3, 20, 4),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ForgetPasswordPage();
                        }));
                      },
                      child: Text(
                        'Forget your password ?',
                        style: GoogleFonts.orbitron(
                            fontSize: 10,
                            letterSpacing: 0.2,
                            // fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 6, 36, 8)),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Transform.rotate(
                          angle: 90 * math.pi / 180,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Color.fromARGB(255, 6, 36, 8),
                              size: 28,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
