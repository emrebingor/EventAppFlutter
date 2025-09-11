import 'package:event_app/data/local/event_local_storage.dart';
import 'package:event_app/data/local/models/event_local_model.dart';
import 'package:event_app/data/provider/tab_provider.dart';
import 'package:event_app/screens/tab/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(LocalEventAdapter());

  await EventLocalStorage().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TabProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
          )
        ),
        debugShowCheckedModeBanner: false,
        home: TabScreen(),
      ),
    );
  }
}