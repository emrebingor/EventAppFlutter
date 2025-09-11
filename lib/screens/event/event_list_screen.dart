import 'package:flutter/material.dart';

final class EventListScreen extends StatelessWidget {
  const EventListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Event List",
          ),
        ),
      ),
    );
  }
}
