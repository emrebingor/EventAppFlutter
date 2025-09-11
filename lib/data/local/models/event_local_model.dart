import 'package:hive/hive.dart';

part 'event_local_model.g.dart';

@HiveType(typeId: 0)
class LocalEvent extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  String? calendarId;

  @HiveField(4)
  String? deviceEventId;

  LocalEvent({
    required this.id,
    required this.title,
    required this.date,
    this.calendarId,
    this.deviceEventId,
  });
}
