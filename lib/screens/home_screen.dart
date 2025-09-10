import 'package:device_calendar/device_calendar.dart';
import 'package:event_app/core/base/state/base_view_state.dart';
import 'package:event_app/core/base/view/base_view.dart';
import 'package:event_app/data/bloc/home/home_bloc.dart';
import 'package:event_app/data/bloc/home/home_event.dart';
import 'package:event_app/data/bloc/home/home_state.dart';
import 'package:event_app/screens/mixin/home_screen_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part './sub_screen/home_sub_screen.dart';

final class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final class _HomeScreenState extends BaseViewState<HomeScreen> with HomeScreenMixin {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeBloc, HomeAction, HomeState>(
      blocModel: homeBloc,
      child: PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Event App",
            ),
          ),
          body: BlocConsumer<HomeBloc, HomeState>(
            listener: blocListener,
            builder: (BuildContext context, HomeState state) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _EventNameTextFieldWidget(
                        controller: eventNameController,
                      ),
                      const SizedBox(height: 20),
                      _DatePickerFieldWidget(
                        onTap: pickDate,
                        selectedDate: homeBloc.state.selectedDate,
                      ),
                      const SizedBox(height: 20),
                      homeBloc.state.calendars != null && homeBloc.state.calendars!.isNotEmpty ?
                        _CalenderSelectionWidget(
                          id: homeBloc.state.selectedCalendar?.id,
                          calendar: homeBloc.state.calendars!,
                          onTap: calendarTypeUpdate,
                        ) : SizedBox.shrink(),
                      const Spacer(),
                      _AddCalenderButtonWidget(
                        onTap: addToCalendar,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
