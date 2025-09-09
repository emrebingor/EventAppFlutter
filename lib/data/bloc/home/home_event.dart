import 'package:flutter/material.dart';

@immutable
abstract class HomeAction {
  const HomeAction();
}

@immutable
final class HomeInitAction extends HomeAction {
  const HomeInitAction();
}