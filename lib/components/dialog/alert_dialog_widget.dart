import 'package:flutter/material.dart';

final class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({
    super.key,
    required this.onTap,
    required this.message,
  });
  final VoidCallback onTap;
  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text('Information'),
      content: Text(message),
      actions: [
        ElevatedButton(
          onPressed: onTap,
          child: const Text("Okay"),
        ),
      ],
    );
  }
}
