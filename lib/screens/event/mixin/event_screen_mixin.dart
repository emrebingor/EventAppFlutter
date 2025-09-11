import 'package:event_app/core/base/state/base_view_state.dart';
import 'package:event_app/data/bloc/event/event_bloc.dart';
import 'package:event_app/data/bloc/event/event_event.dart';
import 'package:event_app/screens/event/event_list_screen.dart';
import 'package:flutter/material.dart';

mixin EventScreenMixin on BaseViewState<EventListScreen> {
  final EventBloc _eventBloc = EventBloc();
  EventBloc get eventBloc => _eventBloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _eventBloc.add(EventInitAction());
    });
  }

  void removeEvent(String id, String calendarId) {
    _eventBloc.add(RemoveEventAction(id, calendarId));
  }
}