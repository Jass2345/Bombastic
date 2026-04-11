// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 폭탄 남은 시간을 HH:MM:SS 문자열로 제공하는 provider.
///
/// ## 기기 간 타이머 동기화 원리
/// - `bomb.expiresAt`, `bomb.receivedAt` 모두 서버 타임스탬프(Cloud Function이 기록).
/// - `totalDuration = expiresAt - receivedAt` : 서버가 정한 총 유효 시간 (기기 클럭 무관).
/// - `builtAt` : 이 provider가 빌드된 로컬 시각 — 절대값이 아닌 **기준점**으로만 사용.
/// - `elapsed = DateTime.now() - builtAt` : 로컬 시간끼리의 상대 차이이므로 클럭 오차 없음.
/// - `remaining = totalDuration - elapsed`
///
/// 폭탄이 교체(새 snapshot)될 때마다 provider가 재빌드되어 builtAt·totalDuration이 리셋된다.

@ProviderFor(bombTimer)
final bombTimerProvider = BombTimerFamily._();

/// 폭탄 남은 시간을 HH:MM:SS 문자열로 제공하는 provider.
///
/// ## 기기 간 타이머 동기화 원리
/// - `bomb.expiresAt`, `bomb.receivedAt` 모두 서버 타임스탬프(Cloud Function이 기록).
/// - `totalDuration = expiresAt - receivedAt` : 서버가 정한 총 유효 시간 (기기 클럭 무관).
/// - `builtAt` : 이 provider가 빌드된 로컬 시각 — 절대값이 아닌 **기준점**으로만 사용.
/// - `elapsed = DateTime.now() - builtAt` : 로컬 시간끼리의 상대 차이이므로 클럭 오차 없음.
/// - `remaining = totalDuration - elapsed`
///
/// 폭탄이 교체(새 snapshot)될 때마다 provider가 재빌드되어 builtAt·totalDuration이 리셋된다.

final class BombTimerProvider
    extends $FunctionalProvider<AsyncValue<String>, String, Stream<String>>
    with $FutureModifier<String>, $StreamProvider<String> {
  /// 폭탄 남은 시간을 HH:MM:SS 문자열로 제공하는 provider.
  ///
  /// ## 기기 간 타이머 동기화 원리
  /// - `bomb.expiresAt`, `bomb.receivedAt` 모두 서버 타임스탬프(Cloud Function이 기록).
  /// - `totalDuration = expiresAt - receivedAt` : 서버가 정한 총 유효 시간 (기기 클럭 무관).
  /// - `builtAt` : 이 provider가 빌드된 로컬 시각 — 절대값이 아닌 **기준점**으로만 사용.
  /// - `elapsed = DateTime.now() - builtAt` : 로컬 시간끼리의 상대 차이이므로 클럭 오차 없음.
  /// - `remaining = totalDuration - elapsed`
  ///
  /// 폭탄이 교체(새 snapshot)될 때마다 provider가 재빌드되어 builtAt·totalDuration이 리셋된다.
  BombTimerProvider._({
    required BombTimerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'bombTimerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bombTimerHash();

  @override
  String toString() {
    return r'bombTimerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<String> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<String> create(Ref ref) {
    final argument = this.argument as String;
    return bombTimer(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is BombTimerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bombTimerHash() => r'17ac8d4d28ca18375cdcd6876030ccbdc6329e15';

/// 폭탄 남은 시간을 HH:MM:SS 문자열로 제공하는 provider.
///
/// ## 기기 간 타이머 동기화 원리
/// - `bomb.expiresAt`, `bomb.receivedAt` 모두 서버 타임스탬프(Cloud Function이 기록).
/// - `totalDuration = expiresAt - receivedAt` : 서버가 정한 총 유효 시간 (기기 클럭 무관).
/// - `builtAt` : 이 provider가 빌드된 로컬 시각 — 절대값이 아닌 **기준점**으로만 사용.
/// - `elapsed = DateTime.now() - builtAt` : 로컬 시간끼리의 상대 차이이므로 클럭 오차 없음.
/// - `remaining = totalDuration - elapsed`
///
/// 폭탄이 교체(새 snapshot)될 때마다 provider가 재빌드되어 builtAt·totalDuration이 리셋된다.

final class BombTimerFamily extends $Family
    with $FunctionalFamilyOverride<Stream<String>, String> {
  BombTimerFamily._()
    : super(
        retry: null,
        name: r'bombTimerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 폭탄 남은 시간을 HH:MM:SS 문자열로 제공하는 provider.
  ///
  /// ## 기기 간 타이머 동기화 원리
  /// - `bomb.expiresAt`, `bomb.receivedAt` 모두 서버 타임스탬프(Cloud Function이 기록).
  /// - `totalDuration = expiresAt - receivedAt` : 서버가 정한 총 유효 시간 (기기 클럭 무관).
  /// - `builtAt` : 이 provider가 빌드된 로컬 시각 — 절대값이 아닌 **기준점**으로만 사용.
  /// - `elapsed = DateTime.now() - builtAt` : 로컬 시간끼리의 상대 차이이므로 클럭 오차 없음.
  /// - `remaining = totalDuration - elapsed`
  ///
  /// 폭탄이 교체(새 snapshot)될 때마다 provider가 재빌드되어 builtAt·totalDuration이 리셋된다.

  BombTimerProvider call(String groupId) =>
      BombTimerProvider._(argument: groupId, from: this);

  @override
  String toString() => r'bombTimerProvider';
}
