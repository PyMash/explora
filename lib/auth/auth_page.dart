import 'package:explora/pages/opening_page.dart';
import 'package:explora/pages/sign_in_page.dart';
import 'package:explora/pages/sign_up_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  @override
  Widget build(BuildContext context) {
    return const OpeningPage();
  }
}
