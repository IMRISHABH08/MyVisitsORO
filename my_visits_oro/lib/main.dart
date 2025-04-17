import 'package:flutter/material.dart';

import 'core/injection/injections.dart';
import 'features/my_visits/presentation/my_visits_home.dart';

void main() => runApp(const MyVisitsHome());

class MyVisitsHome extends StatefulWidget {
  const MyVisitsHome({super.key});

  @override
  State<MyVisitsHome> createState() => _MyVisitsHomeState();
}

class _MyVisitsHomeState extends State<MyVisitsHome> {
  @override
  void initState() {
    registerOnAppStartUpServices();
    super.initState();
  }

  @override
  void dispose() {
    unRegisterOnAppClosedServices();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oro Money',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Satoshi',
        useMaterial3: true,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AllVisits(),
    );
  }
}
