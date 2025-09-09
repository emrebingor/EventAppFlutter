import 'package:device_calendar/device_calendar.dart';
import 'package:event_app/core/base/bloc/base_bloc_state.dart';

final class HomeState extends BaseBlocState {
  HomeState({
    super.hasError,
    super.errorMessage,
    super.isLoading,
    this.selectedDate,
    this.selectedCalendar,
    this.calendars,
  });

  DateTime? selectedDate;
  Calendar? selectedCalendar;
  List<Calendar>? calendars;

  @override
  List<Object?> get props {
    return <Object?>[
      ...super.props,
      selectedDate,
      selectedCalendar,
      calendars,
    ];
  }

  @override
  HomeState copyWith({
    bool? hasError,
    String? errorMessage,
    bool? isLoading,
    DateTime? selectedDate,
    Calendar? selectedCalendar,
    List<Calendar>? calendars,
  }) {
    return HomeState(
      hasError: hasError ?? false,
      errorMessage: errorMessage ?? '',
      isLoading: isLoading ?? this.isLoading,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedCalendar: selectedCalendar ?? this.selectedCalendar,
      calendars: calendars ?? this.calendars,
    );
  }
}