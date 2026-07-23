import '../entities/tasbeeh_count.dart';

abstract interface class TasbeehRepository {
  Future<TasbeehCount> getCount();

  Future<TasbeehCount> saveCount(int count);

  Future<TasbeehCount> resetCount();
}
