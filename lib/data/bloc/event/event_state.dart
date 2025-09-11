import 'package:event_app/core/base/bloc/base_bloc_state.dart';
import 'package:event_app/data/local/models/event_local_model.dart';

final class EventState extends BaseBlocState {
  EventState({
    super.hasError,
    super.errorMessage,
    super.isLoading,
    this.events,
  });

  List<LocalEvent>? events;

  @override
  List<Object?> get props {
    return <Object?>[
      ...super.props,
      events,
    ];
  }

  @override
  EventState copyWith({
    bool? hasError,
    String? errorMessage,
    bool? isLoading,
    List<LocalEvent>? events,
  }) {
    return EventState(
      hasError: hasError ?? false,
      errorMessage: errorMessage ?? '',
      isLoading: isLoading ?? this.isLoading,
      events: events ?? this.events,
    );
  }
}