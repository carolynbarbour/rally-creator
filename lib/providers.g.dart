// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(imageAssetsForLevel)
const imageAssetsForLevelProvider = ImageAssetsForLevelFamily._();

final class ImageAssetsForLevelProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ImageAsset>>,
          List<ImageAsset>,
          FutureOr<List<ImageAsset>>
        >
    with $FutureModifier<List<ImageAsset>>, $FutureProvider<List<ImageAsset>> {
  const ImageAssetsForLevelProvider._({
    required ImageAssetsForLevelFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'imageAssetsForLevelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$imageAssetsForLevelHash();

  @override
  String toString() {
    return r'imageAssetsForLevelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ImageAsset>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ImageAsset>> create(Ref ref) {
    final argument = this.argument as int;
    return imageAssetsForLevel(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ImageAssetsForLevelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$imageAssetsForLevelHash() =>
    r'2a15cd1062b170968962b7a2806881d0137252e3';

final class ImageAssetsForLevelFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<ImageAsset>>, int> {
  const ImageAssetsForLevelFamily._()
    : super(
        retry: null,
        name: r'imageAssetsForLevelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ImageAssetsForLevelProvider call(int level) =>
      ImageAssetsForLevelProvider._(argument: level, from: this);

  @override
  String toString() => r'imageAssetsForLevelProvider';
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

String _$levelHash() => r'ce826910216116c504f5ee6221b1961eb2cf478c';

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
        isAutoDispose: false,
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

String _$gridDimensionsHash() => r'35fc0e18c1d730c4cb9c11c04592f0ffcab8a9a4';

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

String _$historyHash() => r'95d1867949dd5d48ed7be9f67e59b29201a17991';

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

String _$placedImagesHash() => r'b857f129dc5e2b3d28c6d24710f94949558e9944';

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

String _$selectedImageIdHash() => r'145fd162aed1c7e01e8c49d8c496757793c4df05';

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
