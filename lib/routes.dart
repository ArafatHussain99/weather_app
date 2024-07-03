import 'package:flutter/material.dart';
import 'package:weather_app/notifications/view/notification_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    
    case NotificationScreen.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>const  NotificationScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist..'),
          ),
        ),
      );
  }
}
