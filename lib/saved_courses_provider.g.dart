// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_courses_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SavedCourses)
const savedCoursesProvider = SavedCoursesProvider._();

final class SavedCoursesProvider
    extends $AsyncNotifierProvider<SavedCourses, List<String>> {
  const SavedCoursesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'savedCoursesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$savedCoursesHash();

  @$internal
  @override
  SavedCourses create() => SavedCourses();
}

String _$savedCoursesHash() => r'a7ff91c19d95d3bb606e9273728beaabf8a0367a';

abstract class _$SavedCourses extends $AsyncNotifier<List<String>> {
  FutureOr<List<String>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<String>>, List<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<String>>, List<String>>,
              AsyncValue<List<String>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
