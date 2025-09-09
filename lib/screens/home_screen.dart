import 'package:event_app/core/base/state/base_view_state.dart';
import 'package:event_app/core/base/view/base_view.dart';
import 'package:event_app/data/bloc/home/home_bloc.dart';
import 'package:event_app/data/bloc/home/home_event.dart';
import 'package:event_app/data/bloc/home/home_state.dart';
import 'package:event_app/screens/mixin/home_screen_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseViewState<HomeScreen> with HomeScreenMixin {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeBloc, HomeAction, HomeState>(
      blocModel: homeBloc,
      child: PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(title: const Text("Event App")),
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (BuildContext context, HomeState state) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                        controller: eventNameController,
                        decoration: const InputDecoration(labelText: "Etkinlik Adı"),
                      ),
                      const SizedBox(height: 20),

                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: pickDate,
                            child: const Text("Tarih Seç"),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            homeBloc.state.selectedDate == null
                                ? "Seçilmedi"
                                : "${homeBloc.state.selectedDate!.day}.${homeBloc.state.selectedDate!.month}.${homeBloc.state.selectedDate!.year}",
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      if (homeBloc.state.calendars != null && homeBloc.state.calendars!.isNotEmpty)
                        DropdownButton<String>(
                          value: homeBloc.state.selectedCalendar?.id,
                          items: homeBloc.state.calendars!
                              .map((c) => DropdownMenuItem(
                            value: c.id,
                            child: Text(c.name ?? "Takvim"),
                          ))
                              .toList(),
                          onChanged: (String? value) {
                          },
                        ),

                      const Spacer(),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.calendar_today),
                        label: const Text("Takvime Ekle"),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
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
