class TasbeehCount {
  const TasbeehCount({required this.value});

  final int value;

  TasbeehCount copyWith({int? value}) {
    return TasbeehCount(value: value ?? this.value);
  }

  @override
  bool operator ==(Object other) {
    return other is TasbeehCount && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
