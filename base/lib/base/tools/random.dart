import 'dart:math';
import 'dart:typed_data';

class SecureRandom implements Random {
  static final Random _globalRandom1 = Random()..advance(211, Random());

  static int _seedCounter = 0;

  static int _generateSeedBasic() {
    var c = ++_seedCounter;

    var r1 = Random()..advance(97, Random());
    var r2 = Random(_globalRandom1.nextSeed() ^ c);
    var r3 = Random(r1.nextSeed() ^ r2.nextSeed() ^ (c * 31));

    var s1 = r1.nextSeed();
    var s2 = r2.nextSeed();
    var s3 = r3.nextSeed();

    return s1 ^ s2 ^ s3;
  }

  /// Generates a seed to be used to instantiate [Random].
  static int generateSeed() {
    var s1 = _generateSeedBasic();
    var s2 = _globalRandom1.nextSeed();
    var s3 = _generateSeedBasic();
    var s4 = Random().nextSeed();

    return s1 ^ s2 ^ s3 ^ s4;
  }

  /// Tries to return [Random.secure()]. If not supported by the
  /// current platform, returns a fallback ([_SecureRandomFallback]).
  ///
  /// - [forceFallbackSecureRandom] if `true` forces to return a [_SecureRandomFallback] instance.
  static Random createPlatformSecureRandom(
      {bool forceFallbackSecureRandom = false}) {
    if (forceFallbackSecureRandom) {
      return _SecureRandomFallback();
    }

    try {
      return Random.secure();
    } catch (e) {
      return _SecureRandomFallback();
    }
  }

  final Random _random;

  SecureRandom({bool forceFallbackSecureRandom = false})
      : _random = createPlatformSecureRandom(
            forceFallbackSecureRandom: forceFallbackSecureRandom);

  @override
  bool nextBool() => _random.nextBool();

  @override
  double nextDouble() => _random.nextDouble();

  @override
  int nextInt(int max) => _random.nextInt(max);

  bool get isFallbackSecureRandom => _random is _SecureRandomFallback;

  @override
  String toString() {
    return 'SecureRandom{ isFallbackSecureRandom: $isFallbackSecureRandom }';
  }
}

extension RandomExtension on Random {

  /// Advances this random generator randomly. Return the number of advanced steps.
  ///
  /// - [maxSteps] the maximum number of steps to advance.
  int advance([int maxSteps = 97, Random random]) {
    var steps = (random ?? this).nextInt(maxSteps) ;
    for (var i = 0; i < steps; ++i) {
      nextDouble();
    }
    return steps ;
  }

  int nextSeed() {
    return _nextSeedImpl() ^
        _nextSeedImpl() ^
        _nextSeedImpl() ^
        _nextSeedImpl() ^
        _nextSeedImpl();
  }

  static final int _maxInt = 2147000000;

  int _nextSeedImpl() {
    var n = nextInt(_maxInt);
    return nextBool() ? -n : n;
  }

  int nextBytes(Uint8List bytes, [int length]) {
    length ??= bytes.length;

    for (var i = 0; i < length; ++i) {
      var b = nextInt(256);
      bytes[i] = b;
    }

    return length;
  }
}

class _SecureRandomFallback implements Random {
  final Random _random;

  _SecureRandomFallback() : _random = Random(SecureRandom.generateSeed()) {
    _random.advance(211, Random(SecureRandom.generateSeed()));
  }

  @override
  bool nextBool() => _random.nextBool();

  @override
  double nextDouble() => _random.nextDouble();

  @override
  int nextInt(int max) => _random.nextInt(max);
}
