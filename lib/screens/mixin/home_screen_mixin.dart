import 'package:device_calendar/device_calendar.dart';
import 'package:event_app/core/base/state/base_view_state.dart';
import 'package:event_app/data/bloc/home/home_bloc.dart';
import 'package:event_app/data/bloc/home/home_event.dart';
import 'package:event_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

mixin HomeScreenMixin on BaseViewState<HomeScreen> {
  final HomeBloc _homeBloc = HomeBloc();
  HomeBloc get homeBloc => _homeBloc;
  final TextEditingController eventNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _homeBloc.add(HomeInitAction());
    });
  }

  Future<void> pickDate() async {
    final now = DateTime.now();
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );

    if (selectedDate != null) {
      _homeBloc.pickDate(selectedDate);
    }
  }

  void updateCalendar(Calendar calendar) {
    _homeBloc.updateCalender(calendar);
  }

  Future<void> addToCalendar() async {
    if (eventNameController.text.isEmpty
        || _homeBloc.state.selectedDate == null
        || _homeBloc.state.selectedCalendar == null
    ) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Choose and event name and date")),
      );
      return;
    }

    await _homeBloc.addToCalendar(title: eventNameController.text);
  }
}