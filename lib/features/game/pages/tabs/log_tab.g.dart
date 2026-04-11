// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_tab.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(passLogs)
final passLogsProvider = PassLogsFamily._();

final class PassLogsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Map<String, dynamic>>>,
          List<Map<String, dynamic>>,
          Stream<List<Map<String, dynamic>>>
        >
    with
        $FutureModifier<List<Map<String, dynamic>>>,
        $StreamProvider<List<Map<String, dynamic>>> {
  PassLogsProvider._({
    required PassLogsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'passLogsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$passLogsHash();

  @override
  String toString() {
    return r'passLogsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Map<String, dynamic>>> create(Ref ref) {
    final argument = this.argument as String;
    return passLogs(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PassLogsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$passLogsHash() => r'a26855cb03ff8a79f60e2930931f164bb3b973ee';

final class PassLogsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Map<String, dynamic>>>, String> {
  PassLogsFamily._()
    : super(
        retry: null,
        name: r'passLogsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PassLogsProvider call(String groupId) =>
      PassLogsProvider._(argument: groupId, from: this);

  @override
  String toString() => r'passLogsProvider';
}
