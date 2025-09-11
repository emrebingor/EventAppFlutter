import 'package:device_calendar/device_calendar.dart';
import 'package:event_app/data/bloc/event/event_event.dart';
import 'package:event_app/data/bloc/event/event_state.dart';
import 'package:event_app/core/base/bloc/base_bloc.dart';
import 'package:event_app/data/local/event_local_storage.dart';
import 'package:event_app/data/local/models/event_local_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class EventBloc extends BaseBloc<EventAction, EventState> {
  EventBloc() : super(EventState()) {
    on<EventInitAction>(_eventInitAction);
    on<RemoveEventAction>(_removeEventAction);
  }
  final DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();

  Future<void> _eventInitAction(EventAction event,
      Emitter<EventState> emit) async {
    final EventLocalStorage storage = EventLocalStorage();
    final List<LocalEvent> events = storage.getEvents();

    emit(state.copyWith(
      events: events,
    ));
  }

  Future<void> _removeEventAction(RemoveEventAction event,
      Emitter<EventState> emit) async {
    final EventLocalStorage storage = EventLocalStorage();
    await _deviceCalendarPlugin.deleteCalendar(event.calendarId);
    await storage.removeEvent(event.id);
    final List<LocalEvent> events = storage.getEvents();

    emit(state.copyWith(
      events: events,
    ));
  }
}