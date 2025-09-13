// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_selection_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Level)
const levelProvider = LevelProvider._();

final class LevelProvider extends $NotifierProvider<Level, int> {
  const LevelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'levelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$levelHash();

  @$internal
  @override
  Level create() => Level();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$levelHash() => r'baf7b5521dff1144f974490c86867772d2afca58';

abstract class _$Level extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
