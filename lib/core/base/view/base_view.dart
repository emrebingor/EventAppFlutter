import 'package:event_app/core/base/bloc/base_bloc.dart';
import 'package:event_app/core/base/bloc/base_bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class BaseView<T extends BaseBloc<BlocEvent, BlocState>, BlocEvent extends Object,
BlocState extends BaseBlocState> extends StatefulWidget {
  const BaseView({
    super.key,
    required this.blocModel,
    required this.child,
    this.initEvent,
  });

  final T blocModel;
  final Widget child;
  final BlocEvent? initEvent;

  @override
  State<BaseView<T, BlocEvent, BlocState>> createState() => _BaseViewState<T, BlocEvent, BlocState>();
}

class _BaseViewState<T extends BaseBloc<BlocEvent, BlocState>, BlocEvent extends Object,
BlocState extends BaseBlocState> extends State<BaseView<T, BlocEvent, BlocState>> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<T>(
      create: (BuildContext context) {
        if (widget.initEvent == null) return widget.blocModel;
        return widget.blocModel..add(widget.initEvent!);
      },
      child: widget.child,
    );
  }
}