import 'package:device_calendar/device_calendar.dart';
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
}