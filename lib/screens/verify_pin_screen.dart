import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({
    super.key,
  });

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    //final screenwidth = MediaQuery.of(context).size.width;
    //final screenheight = MediaQuery.of(context).size.height;
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Notification'),
        ),
      ),
    );
  }
}
