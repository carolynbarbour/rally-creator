import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'level_selection_provider.g.dart';

@Riverpod(keepAlive: true)
class Level extends _$Level {
  @override
  int build() => 1;

  void setLevel(int newLevel) {
    state = newLevel;
  }
}
