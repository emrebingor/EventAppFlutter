import 'package:event_app/data/local/models/event_local_model.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

final class EventLocalStorage {
  static const _boxName = 'events';
  static final EventLocalStorage _instance = EventLocalStorage._internal();
  factory EventLocalStorage() => _instance;
  EventLocalStorage._internal();

  late Box<LocalEvent> _box;

  Future<void> init() async {
    if (!Hive.isBoxOpen(_boxName)) {
      _box = await Hive.openBox<LocalEvent>(_boxName);
    } else {
      _box = Hive.box<LocalEvent>(_boxName);
    }
  }

  Future<void> addEvent({
    required String title,
    required DateTime date,
    String? calendarId,
  }) async {
    final id = const Uuid().v4();
    final event = LocalEvent(
      id: id,
      title: title,
      date: date,
      calendarId: calendarId,
    );
    await _box.put(id, event);
  }

  List<LocalEvent> getEvents() {
    return _box.values.toList();
  }

  Future<void> removeEvent(String id) async {
    await _box.delete(id);
  }

  Future<void> clear() async {
    await _box.clear();
  }
}
