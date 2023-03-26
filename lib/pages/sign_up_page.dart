import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'home_page.dart';
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _username = TextEditingController();
  final _emailId = TextEditingController();
  final _password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String name = "";
  bool loading = false;
  @override
  void dispose() {
    _emailId.dispose();
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  Future addUserDetails(
      String name, String email, String password) async {
    await FirebaseFirestore.instance.collection('users').add({
      'Name': name,
      'email': email,
      'password': password,
    });
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
                        "- SIGN UP -",
                        style: GoogleFonts.orbitron(
                            fontSize: 12,
                            letterSpacing: 3,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 6, 36, 8)),
                      ),
                    ),
                    SizedBox(
                      height: 65,
                    ),Container(
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
                            hintText: 'Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(45))),
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                            return "Invalid Format";
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
                        controller: _emailId,
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
                            return "Invalid Format";
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
                        ? const Center(
                            child: CircularProgressIndicator(
                                color:Color.fromARGB(255, 6, 36, 8)),
                          )
                        :Container(
                      width: MediaQuery.of(context).size.width / 2.6,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async{
                          setState(() {
                                  loading = true;
                                });
                          if (formKey.currentState!.validate()) {
                            try{
                            await FirebaseAuth.instance
                                          .createUserWithEmailAndPassword(
                                              email: _emailId.text.trim(),
                                              password: _password.text.trim());
                                      final user =
                                          FirebaseAuth.instance.currentUser!;

                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(user.uid)
                                          .set({
                                        'Name': _username.text.trim(),
                                        'email': _emailId.text.trim(),
                                        'password': _password.text.trim(),
                                      });
                                      Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage()),
                                    );
                          }on FirebaseAuthException catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor:
                                                Color.fromARGB(255, 6, 36, 8),
                                            content: Text(
                                              e.message.toString(),textAlign: TextAlign.center,
                                              style: GoogleFonts.orbitron(
                                                    fontSize: 12,
                                                    letterSpacing: 0.5,
                                                    // fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                            )));
                                  }
                          }
                          if (mounted) {
                                  setState(() {
                                    loading = false;
                                  });
                                }
                                setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 6, 36, 8),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                        ),
                        child: Text('Sign Up',
                            style: GoogleFonts.orbitron(
                                fontSize: 13, wordSpacing: 1, letterSpacing: 1)),
                      ),
                    ),
                   
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom:38.0),
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