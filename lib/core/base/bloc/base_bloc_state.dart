import 'package:equatable/equatable.dart';

abstract class BaseBlocState extends Equatable {
  const BaseBlocState({
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage = '',
  });

  final bool isLoading;
  final bool hasError;
  final String errorMessage;

  bool get hasErrorAndMessage => hasError && errorMessage.isNotEmpty;

  @override
  List<Object?> get props => <Object?>[
    isLoading,
    hasError,
    errorMessage,
  ];

  BaseBlocState copyWith({
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
  });
}