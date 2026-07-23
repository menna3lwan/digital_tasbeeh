import '../../domain/entities/tasbeeh_count.dart';
import '../../domain/repositories/tasbeeh_repository.dart';
import '../datasources/tasbeeh_local_datasource.dart';

final class TasbeehRepositoryImpl implements TasbeehRepository {
  TasbeehRepositoryImpl(this._localDataSource);

  final TasbeehLocalDataSource _localDataSource;

  @override
  Future<TasbeehCount> getCount() async {
    final value = await _localDataSource.getCount();
    return TasbeehCount(value: value);
  }

  @override
  Future<TasbeehCount> saveCount(int count) async {
    await _localDataSource.saveCount(count);
    return TasbeehCount(value: count);
  }

  @override
  Future<TasbeehCount> resetCount() async {
    await _localDataSource.saveCount(0);
    return const TasbeehCount(value: 0);
  }
}
