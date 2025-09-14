// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(signsByLevel)
const signsByLevelProvider = SignsByLevelProvider._();

final class SignsByLevelProvider
    extends
        $FunctionalProvider<
          Map<int, List<SignInfo>>,
          Map<int, List<SignInfo>>,
          Map<int, List<SignInfo>>
        >
    with $Provider<Map<int, List<SignInfo>>> {
  const SignsByLevelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signsByLevelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signsByLevelHash();

  @$internal
  @override
  $ProviderElement<Map<int, List<SignInfo>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Map<int, List<SignInfo>> create(Ref ref) {
    return signsByLevel(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<int, List<SignInfo>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<int, List<SignInfo>>>(value),
    );
  }
}

String _$signsByLevelHash() => r'1042d3ba092d0608b2152ada36a3f262fb57125a';

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

String _$historyHash() => r'46d9c8cae89390175c7bc5b81946a71afef724a3';

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

@ProviderFor(IsReordering)
const isReorderingProvider = IsReorderingProvider._();

final class IsReorderingProvider extends $NotifierProvider<IsReordering, bool> {
  const IsReorderingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isReorderingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isReorderingHash();

  @$internal
  @override
  IsReordering create() => IsReordering();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isReorderingHash() => r'42928e3ea319bb2242536fed8b35624bdcb949ea';

abstract class _$IsReordering extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
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
        isAutoDispose: false,
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

String _$placedImagesHash() => r'09ecb817e88daefde4e90032e4565c3e3cfbbbd0';

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

@ProviderFor(AppTitle)
const appTitleProvider = AppTitleProvider._();

final class AppTitleProvider extends $NotifierProvider<AppTitle, String> {
  const AppTitleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appTitleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appTitleHash();

  @$internal
  @override
  AppTitle create() => AppTitle();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$appTitleHash() => r'565e359a037a9e6969825fe2bef2cfecc8de41da';

abstract class _$AppTitle extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
