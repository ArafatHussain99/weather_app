import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  static const  String id ='notification screen';
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Notification'),centerTitle: true,),
      
      body:const  Center(child: Text('No Notifications available..'),),
    );
  }
}