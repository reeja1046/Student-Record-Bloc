import 'package:flutter/material.dart';
import 'package:student_record_bloc/screens/screen_home.dart';
import '../core/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<SplashScreen> {
  @override
  void initState() {
    gotomain();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Student - Record',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: kTextColor,
          ),
        ),
      ),
    );
  }

  Future<void> gotomain() async {
    await Future.delayed(
      const Duration(seconds: 4),
    );
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const HomeScreen(),
      ),
    );
  }
}
