import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile screen';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Screen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Sorry, you can not update the profile at the moment..'),
      ),
    );
  }
}
