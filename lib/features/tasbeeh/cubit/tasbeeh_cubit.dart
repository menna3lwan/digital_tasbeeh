import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/repositories/tasbeeh_repository.dart';
import 'tasbeeh_state.dart';

final class TasbeehCubit extends Cubit<TasbeehState> {
  TasbeehCubit(this._repository) : super(const TasbeehInitial());

  final TasbeehRepository _repository;

  Future<void> loadCount() async {
    emit(const TasbeehLoading());
    try {
      final count = await _repository.getCount();
      emit(TasbeehLoaded(count: count.value));
    } catch (error) {
      emit(TasbeehError(message: error.toString()));
    }
  }

  Future<void> increment() async {
    final currentState = state;
    if (currentState is! TasbeehLoaded) return;

    final newCount = currentState.count + 1;
    emit(currentState.copyWith(count: newCount));

    try {
      await _repository.saveCount(newCount);
    } catch (error) {
      emit(TasbeehError(message: error.toString()));
    }
  }

  Future<void> reset() async {
    emit(const TasbeehLoading());
    try {
      final count = await _repository.resetCount();
      emit(TasbeehLoaded(count: count.value));
    } catch (error) {
      emit(TasbeehError(message: error.toString()));
    }
  }
}
