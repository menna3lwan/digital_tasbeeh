import 'package:equatable/equatable.dart';

sealed class TasbeehState extends Equatable {
  const TasbeehState();

  @override
  List<Object?> get props => [];
}

final class TasbeehInitial extends TasbeehState {
  const TasbeehInitial();
}

final class TasbeehLoading extends TasbeehState {
  const TasbeehLoading();
}

final class TasbeehLoaded extends TasbeehState {
  const TasbeehLoaded({required this.count});

  final int count;

  TasbeehLoaded copyWith({int? count}) {
    return TasbeehLoaded(count: count ?? this.count);
  }

  @override
  List<Object?> get props => [count];
}

final class TasbeehError extends TasbeehState {
  const TasbeehError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
