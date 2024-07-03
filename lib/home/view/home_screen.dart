import 'package:flutter/material.dart';
import 'package:weather_app/home/view/widgets/drawer_other_details.dart';
import 'package:weather_app/home/view/widgets/drawer_profile_info.dart';
import 'package:weather_app/home/view/widgets/zaynax_logo.dart';
import 'package:weather_app/notifications/view/notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, NotificationScreen.id);
                },
                child: const Icon(Icons.notifications_outlined)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ZaynaxLogo(
              size: MediaQuery.of(context).size.width / 2.5,
            ),
          ],
        ),
      ),
      drawer: const Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            DrawerProfileInfo(),
            SizedBox(
              height: 12,
            ),
            DrawerOtherDetails()
          ],
        ),
      ),
    );
  }
}
