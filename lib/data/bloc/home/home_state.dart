import 'package:device_calendar/device_calendar.dart';
import 'package:event_app/core/base/bloc/base_bloc_state.dart';
import 'package:event_app/data/local/models/event_local_model.dart';

final class HomeState extends BaseBlocState {
  HomeState({
    super.hasError,
    super.errorMessage,
    super.isLoading,
    this.dialogStatus = false,
    this.successDialogStatus = false,
    this.calendarAccessStatus = false,
    this.selectedDate,
    this.selectedCalendar,
    this.calendars,
    this.message,
    this.events,
  });

  DateTime? selectedDate;
  Calendar? selectedCalendar;
  bool dialogStatus;
  bool successDialogStatus;
  bool calendarAccessStatus;
  String? message;
  List<Calendar>? calendars;
  List<LocalEvent>? events;

  @override
  List<Object?> get props {
    return <Object?>[
      ...super.props,
      selectedDate,
      selectedCalendar,
      calendars,
      dialogStatus,
      message,
      successDialogStatus,
      calendarAccessStatus,
      events,
    ];
  }

  @override
  HomeState copyWith({
    bool? hasError,
    String? errorMessage,
    bool? isLoading,
    bool? dialogStatus,
    bool? successDialogStatus,
    bool? calendarAccessStatus,
    String? message,
    DateTime? selectedDate,
    Calendar? selectedCalendar,
    List<Calendar>? calendars,
    List<LocalEvent>? events,
  }) {
    return HomeState(
      hasError: hasError ?? false,
      errorMessage: errorMessage ?? '',
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      dialogStatus: dialogStatus ?? this.dialogStatus,
      calendarAccessStatus: calendarAccessStatus ?? this.calendarAccessStatus,
      successDialogStatus: successDialogStatus ?? this.successDialogStatus,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedCalendar: selectedCalendar ?? this.selectedCalendar,
      calendars: calendars ?? this.calendars,
      events: events ?? this.events,
    );
  }
}