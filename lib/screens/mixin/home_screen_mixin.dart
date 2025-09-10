import 'package:device_calendar/device_calendar.dart';
import 'package:event_app/components/dialog/alert_dialog_widget.dart';
import 'package:event_app/core/base/state/base_view_state.dart';
import 'package:event_app/data/bloc/home/home_bloc.dart';
import 'package:event_app/data/bloc/home/home_event.dart';
import 'package:event_app/data/bloc/home/home_state.dart';
import 'package:event_app/screens/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';
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

  Future<void> blocListener(BuildContext context, HomeState state) async {
    if(state.dialogStatus || state.successDialogStatus) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialogWidget(
            message: _homeBloc.state.message ?? '',
            onTap: () async {
              _homeBloc.updateDialogStatus(false, '');
              Navigator.of(context).pop();
              if(state.successDialogStatus) {
                await calendarNavigation();
              }
            },
          );
        },
      );
    }
  }

  Future<void> calendarNavigation() async {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      final epochSeconds = (_homeBloc.state.selectedDate!.millisecondsSinceEpoch / 1000).floor();
      final url = Uri.parse("calshow:$epochSeconds");
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      }
    } else {
      final epochMillis = _homeBloc.state.selectedDate!.millisecondsSinceEpoch;
      final url = Uri.parse("content://com.android.calendar/time/$epochMillis");
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
      return;
    }
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
      _homeBloc.updateDialogStatus(true, 'Fill your event name and date please!');
      return;
    }

    await _homeBloc.addToCalendar(title: eventNameController.text);
  }
}