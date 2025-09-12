import 'package:event_app/core/base/state/base_view_state.dart';
import 'package:event_app/data/bloc/event/event_bloc.dart';
import 'package:event_app/data/bloc/event/event_event.dart';
import 'package:event_app/screens/event/event_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

  void removeEvent(String id,String calendarId, String deviceEventId) {
    _eventBloc.add(RemoveEventAction(id, calendarId, deviceEventId));
  }

  Future<void> calendarNavigation(BuildContext context, DateTime selectedDate) async {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      final epochSeconds = (selectedDate.millisecondsSinceEpoch / 1000)
          .floor();
      final url = Uri.parse("calshow:$epochSeconds");
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      }
    } else {
      final epochMillis = selectedDate.millisecondsSinceEpoch;
      final url = Uri.parse("content://com.android.calendar/time/$epochMillis");
      if (await canLaunchUrl(url)) {
        await launchUrl
          (url,
          mode: LaunchMode.externalApplication,
        );
      }
    }
  }
}