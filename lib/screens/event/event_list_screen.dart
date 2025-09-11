import 'package:event_app/core/base/state/base_view_state.dart';
import 'package:event_app/core/base/view/base_view.dart';
import 'package:event_app/data/bloc/event/event_bloc.dart';
import 'package:event_app/data/bloc/event/event_event.dart';
import 'package:event_app/data/bloc/event/event_state.dart';
import 'package:event_app/data/local/models/event_local_model.dart';
import 'package:event_app/screens/event/mixin/event_screen_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

part '../event/sub_screen/event_list_sub_screen.dart';

final class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

final class _EventListScreenState extends BaseViewState<EventListScreen> with EventScreenMixin {
  @override
  Widget build(BuildContext context) {
    return BaseView<EventBloc, EventAction, EventState>(
      blocModel: eventBloc,
      child: PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Event List",
            ),
          ),
          body: BlocBuilder<EventBloc, EventState>(
            builder:(BuildContext context, EventState state) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: state.events?.isNotEmpty ?? false
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    children: [
                      state.events?.isNotEmpty ?? false ? Expanded(
                        child: _EventListViewWidget(
                          events: state.events,
                          onDelete: (LocalEvent event) {
                            removeEvent(event.id, event.calendarId ?? '');
                          },
                        ),
                      ) : _EmptyEventWidget(),
                    ],
                  ),
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}
