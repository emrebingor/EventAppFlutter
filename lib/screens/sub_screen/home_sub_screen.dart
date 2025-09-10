part of '../home_screen.dart';

final class _CalenderSelectionWidget extends StatelessWidget {
  const _CalenderSelectionWidget({
    required this.id,
    required this.calendar,
    required this.onTap,
  });
  final String? id;
  final List<Calendar> calendar;
  final ValueSetter<String> onTap;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: id,
      items: calendar.map((c) => DropdownMenuItem(
        value: c.id,
        child: Text(c.name ?? "Calendar"),
      )).toList(),
      onChanged: (String? value) {
        if (value != null) {
          onTap(value);
        }
      },
    );
  }
}

final class _AddCalenderButtonWidget extends StatelessWidget {
  const _AddCalenderButtonWidget({
    required this.onTap,
  });
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: const Icon(
        Icons.calendar_today,
      ),
      label: const Text(
        "Add to Calendar",
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(
          double.infinity,
          50,
        ),
      ),
    );
  }
}

final class _EventNameTextFieldWidget extends StatelessWidget {
  const _EventNameTextFieldWidget({
    required this.controller,
  });
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: "Event Name",
      ),
    );
  }
}

final class _DatePickerFieldWidget extends StatelessWidget {
  const _DatePickerFieldWidget({
    required this.onTap,
    this.selectedDate,
  });
  final VoidCallback onTap;
  final DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: onTap,
          child: const Text(
            "Pick Date",
          ),
        ),
        const SizedBox(width: 10),
        Text(
          selectedDate == null
              ? "Not Picked"
              : "${selectedDate!.day}.${selectedDate!.month}.${selectedDate!.year}",
        ),
      ],
    );
  }
}