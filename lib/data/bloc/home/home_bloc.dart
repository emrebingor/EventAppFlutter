import 'package:device_calendar/device_calendar.dart';
import 'package:event_app/data/local/event_local_storage.dart';
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

  Future<void> _updateCalenderInformation(HomeInitAction event,
      Emitter<HomeState> emit) async {

    final permissionsGranted = await _deviceCalendarPlugin.hasPermissions();
    if (!permissionsGranted.isSuccess || permissionsGranted.data == false) {
      final request = await _deviceCalendarPlugin.requestPermissions();
      if (!request.isSuccess || request.data == false) {
        emit(state.copyWith(calendarAccessStatus: true));
        return;
      }
    }

    final calendarsResult = await _deviceCalendarPlugin.retrieveCalendars();
    if (calendarsResult.data != null && calendarsResult.data!.isNotEmpty) {
      emit(state.copyWith(
        selectedCalendar: calendarsResult.data!.first,
        calendars: calendarsResult.data,
        calendarAccessStatus: false,
      ));
    }
  }

  void pickDate(DateTime selectedDate) {
    emit(state.copyWith(selectedDate: selectedDate));
  }

  void updateCalender(Calendar calendar) {
    emit(state.copyWith(selectedCalendar: calendar));
  }

  void updateDialogStatus(bool status, String message) {
    emit(state.copyWith(dialogStatus: status, successDialogStatus: false, message: message));
  }

  Future<void> addToCalendar({required String title}) async {
    final selected = state.selectedDate!;
    final tzStart = tz.TZDateTime(
      tz.local,
      selected.year,
      selected.month,
      selected.day,
    );
    final tzEnd = tzStart.add(const Duration(hours: 1));
    final EventLocalStorage storage = EventLocalStorage();

    final event = Event(
      state.selectedCalendar!.id,
      title: title,
      start: tzStart,
      end: tzEnd,
      allDay: true,
    );

    final createResult = await _deviceCalendarPlugin.createOrUpdateEvent(event);

    if (createResult!.isSuccess) {
      await storage.addEvent(
        title: title,
        date: tzStart,
        calendarId: state.selectedCalendar!.id,
        deviceEventId: createResult.data,
      );

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