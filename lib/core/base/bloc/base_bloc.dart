import 'package:event_app/core/base/bloc/base_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseBloc<T, R extends BaseBlocState> extends Bloc<T, R> {
  BaseBloc(super.initialState);

  @override
  void emit(R state) {
    if (isClosed) return;
    super.emit(state);
  }

  void errorEmit(String? errorMessage) {
    emit(state.copyWith(hasError: true, errorMessage: errorMessage) as R);
  }
}