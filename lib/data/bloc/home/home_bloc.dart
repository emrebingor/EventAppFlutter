import 'package:device_calendar/device_calendar.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:event_app/core/base/bloc/base_bloc.dart';
import 'package:event_app/data/bloc/home/home_event.dart';
import 'package:event_app/data/bloc/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class HomeBloc extends BaseBloc<HomeAction, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<HomeInitAction>(_updateCalenderInformation);
  }

  final DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();


  Future<void> _updateCalenderInformation(HomeInitAction event, Emitter<HomeState> emit) async {
    final permissionsGranted = await _deviceCalendarPlugin.hasPermissions();
    if (permissionsGranted.isSuccess && permissionsGranted.data == false) {
      await _deviceCalendarPlugin.requestPermissions();
    }

    final calendarsResult = await _deviceCalendarPlugin.retrieveCalendars();
    if (calendarsResult.data != null && calendarsResult.data!.isNotEmpty) {
      emit(state.copyWith(selectedCalendar: calendarsResult.data!.first, calendars: calendarsResult.data));
    }
  }

  void pickDate(DateTime selectedDate) {
    emit(state.copyWith(selectedDate: selectedDate));
  }

  void updateCalender(Calendar calendar) {
    emit(state.copyWith(selectedCalendar: calendar));
  }

  void updateDialogStatus(bool status, String message) {
    emit(state.copyWith(dialogStatus: status, message: message));
  }

  Future<void> addToCalendar({required String title}) async {

    final tzStart = tz.TZDateTime.from(state.selectedDate!, tz.local);
    final tzEnd = tzStart.add(const Duration(hours: 1));

    final event = Event(
      state.selectedCalendar!.id,
      title: title,
      start: tzStart,
      end: tzEnd,
    );

    final createResult = await _deviceCalendarPlugin.createOrUpdateEvent(event);

    if (createResult!.isSuccess) {
      emit(state.copyWith(
        successDialogStatus: true,
        message: 'Event successfully added.',
      ));
    } else {
      emit(state.copyWith(
        dialogStatus: true,
        message: 'There is a problem with event arrangement. Please try again later.',
      ));
    }
  }
}