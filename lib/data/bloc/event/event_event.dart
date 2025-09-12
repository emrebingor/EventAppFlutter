import 'package:flutter/material.dart';

@immutable
abstract class EventAction {
  const EventAction();
}

@immutable
final class EventInitAction extends EventAction {
  const EventInitAction();
}

@immutable
final class RemoveEventAction extends EventAction {
  const RemoveEventAction(this.id, this.calendarId, this.deviceEventId);
  final String id;
  final String calendarId;
  final String deviceEventId;
}