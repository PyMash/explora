import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

import 'sign_in_page.dart';
import 'sign_up_page.dart';


class OpeningPage extends StatefulWidget {
  const OpeningPage({super.key});

  @override
  State<OpeningPage> createState() => _OpeningPageState();
}

class _OpeningPageState extends State<OpeningPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('img/login2.png'), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 155),
              child: Text(
                "EXPLORA",
                style: GoogleFonts.orbitron(
                    fontSize: 38,
                    letterSpacing: 5,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 6, 36, 8)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                "- IF NOT NOW, THEN WHEN? -",
                style: GoogleFonts.orbitron(
                    fontSize: 12,
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 6, 36, 8)),
              ),
            ),
            SizedBox(
              height: 90,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2.8,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  SignInPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 6, 36, 8),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
                child: Text('Sign In',
                    style: GoogleFonts.orbitron(
                        fontSize: 13, wordSpacing: 1, letterSpacing: 1)),
              ),
            ),
            SizedBox(
              height: 11,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2.8,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  SignUpPage()),
                  );
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
            SizedBox(
              height: 50,
            ),
            // Icon(Icons.arrow_back_ios_new,)
            Transform.rotate(
              angle: 90 * math.pi / 180,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Color.fromARGB(255, 6, 36, 8),
                  size: 28,
                ),
                onPressed: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
