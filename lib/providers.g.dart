// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GridDimensions)
const gridDimensionsProvider = GridDimensionsProvider._();

final class GridDimensionsProvider
    extends $NotifierProvider<GridDimensions, Size> {
  const GridDimensionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gridDimensionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gridDimensionsHash();

  @$internal
  @override
  GridDimensions create() => GridDimensions();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Size value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Size>(value),
    );
  }
}

String _$gridDimensionsHash() => r'18a6387cbbbbaa7f5b1039a70090660c1c42fb62';

abstract class _$GridDimensions extends $Notifier<Size> {
  Size build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Size, Size>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Size, Size>,
              Size,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(Level)
const levelProvider = LevelProvider._();

final class LevelProvider extends $NotifierProvider<Level, int> {
  const LevelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'levelProvider',
        isAutoDispose: true,
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

String _$levelHash() => r'c49c2a2d20414fe4e8346a31b9700c06a687c267';

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

@ProviderFor(SelectedImageId)
const selectedImageIdProvider = SelectedImageIdProvider._();

final class SelectedImageIdProvider
    extends $NotifierProvider<SelectedImageId, String?> {
  const SelectedImageIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedImageIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedImageIdHash();

  @$internal
  @override
  SelectedImageId create() => SelectedImageId();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$selectedImageIdHash() => r'a9a138a090375c7db4a9ff4a9693bea2bf904707';

abstract class _$SelectedImageId extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(History)
const historyProvider = HistoryProvider._();

final class HistoryProvider
    extends $NotifierProvider<History, List<List<ImageState>>> {
  const HistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historyProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$historyHash();

  @$internal
  @override
  History create() => History();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<List<ImageState>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<List<ImageState>>>(value),
    );
  }
}

String _$historyHash() => r'c6a1278d52e96c4a6524bceb03c3376d416b6f96';

abstract class _$History extends $Notifier<List<List<ImageState>>> {
  List<List<ImageState>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<List<List<ImageState>>, List<List<ImageState>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<List<ImageState>>, List<List<ImageState>>>,
              List<List<ImageState>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(PlacedImages)
const placedImagesProvider = PlacedImagesProvider._();

final class PlacedImagesProvider
    extends $NotifierProvider<PlacedImages, List<ImageState>> {
  const PlacedImagesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'placedImagesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$placedImagesHash();

  @$internal
  @override
  PlacedImages create() => PlacedImages();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ImageState> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ImageState>>(value),
    );
  }
}

String _$placedImagesHash() => r'd1ad21b31f3ba0d9093e9071c25c4c28bec1d037';

abstract class _$PlacedImages extends $Notifier<List<ImageState>> {
  List<ImageState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<ImageState>, List<ImageState>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<ImageState>, List<ImageState>>,
              List<ImageState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
