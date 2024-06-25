// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reviewsServiceHash() => r'd91877727c3a90c4267086fa9cd81c8ab6938afd';

/// See also [reviewsService].
@ProviderFor(reviewsService)
final reviewsServiceProvider = Provider<ReviewsService>.internal(
  reviewsService,
  name: r'reviewsServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reviewsServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ReviewsServiceRef = ProviderRef<ReviewsService>;
String _$userReviewFutureHash() => r'98a78f997bf77c9b2cb80da2ddb23242c933893f';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Check if a product was previously reviewed by the user
///
/// Copied from [userReviewFuture].
@ProviderFor(userReviewFuture)
const userReviewFutureProvider = UserReviewFutureFamily();

/// Check if a product was previously reviewed by the user
///
/// Copied from [userReviewFuture].
class UserReviewFutureFamily extends Family<AsyncValue<Review?>> {
  /// Check if a product was previously reviewed by the user
  ///
  /// Copied from [userReviewFuture].
  const UserReviewFutureFamily();

  /// Check if a product was previously reviewed by the user
  ///
  /// Copied from [userReviewFuture].
  UserReviewFutureProvider call(
    String productId,
  ) {
    return UserReviewFutureProvider(
      productId,
    );
  }

  @override
  UserReviewFutureProvider getProviderOverride(
    covariant UserReviewFutureProvider provider,
  ) {
    return call(
      provider.productId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userReviewFutureProvider';
}

/// Check if a product was previously reviewed by the user
///
/// Copied from [userReviewFuture].
class UserReviewFutureProvider extends AutoDisposeFutureProvider<Review?> {
  /// Check if a product was previously reviewed by the user
  ///
  /// Copied from [userReviewFuture].
  UserReviewFutureProvider(
    String productId,
  ) : this._internal(
          (ref) => userReviewFuture(
            ref as UserReviewFutureRef,
            productId,
          ),
          from: userReviewFutureProvider,
          name: r'userReviewFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userReviewFutureHash,
          dependencies: UserReviewFutureFamily._dependencies,
          allTransitiveDependencies:
              UserReviewFutureFamily._allTransitiveDependencies,
          productId: productId,
        );

  UserReviewFutureProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
  }) : super.internal();

  final String productId;

  @override
  Override overrideWith(
    FutureOr<Review?> Function(UserReviewFutureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserReviewFutureProvider._internal(
        (ref) => create(ref as UserReviewFutureRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Review?> createElement() {
    return _UserReviewFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserReviewFutureProvider && other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserReviewFutureRef on AutoDisposeFutureProviderRef<Review?> {
  /// The parameter `productId` of this provider.
  String get productId;
}

class _UserReviewFutureProviderElement
    extends AutoDisposeFutureProviderElement<Review?> with UserReviewFutureRef {
  _UserReviewFutureProviderElement(super.provider);

  @override
  String get productId => (origin as UserReviewFutureProvider).productId;
}

String _$userReviewStreamHash() => r'929c44de465ca195cb9f12203943b7bb4bdfda26';

/// Check if a product was previously reviewed by the user
///
/// Copied from [userReviewStream].
@ProviderFor(userReviewStream)
const userReviewStreamProvider = UserReviewStreamFamily();

/// Check if a product was previously reviewed by the user
///
/// Copied from [userReviewStream].
class UserReviewStreamFamily extends Family<AsyncValue<Review?>> {
  /// Check if a product was previously reviewed by the user
  ///
  /// Copied from [userReviewStream].
  const UserReviewStreamFamily();

  /// Check if a product was previously reviewed by the user
  ///
  /// Copied from [userReviewStream].
  UserReviewStreamProvider call(
    String productId,
  ) {
    return UserReviewStreamProvider(
      productId,
    );
  }

  @override
  UserReviewStreamProvider getProviderOverride(
    covariant UserReviewStreamProvider provider,
  ) {
    return call(
      provider.productId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userReviewStreamProvider';
}

/// Check if a product was previously reviewed by the user
///
/// Copied from [userReviewStream].
class UserReviewStreamProvider extends AutoDisposeStreamProvider<Review?> {
  /// Check if a product was previously reviewed by the user
  ///
  /// Copied from [userReviewStream].
  UserReviewStreamProvider(
    String productId,
  ) : this._internal(
          (ref) => userReviewStream(
            ref as UserReviewStreamRef,
            productId,
          ),
          from: userReviewStreamProvider,
          name: r'userReviewStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userReviewStreamHash,
          dependencies: UserReviewStreamFamily._dependencies,
          allTransitiveDependencies:
              UserReviewStreamFamily._allTransitiveDependencies,
          productId: productId,
        );

  UserReviewStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
  }) : super.internal();

  final String productId;

  @override
  Override overrideWith(
    Stream<Review?> Function(UserReviewStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserReviewStreamProvider._internal(
        (ref) => create(ref as UserReviewStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Review?> createElement() {
    return _UserReviewStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserReviewStreamProvider && other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserReviewStreamRef on AutoDisposeStreamProviderRef<Review?> {
  /// The parameter `productId` of this provider.
  String get productId;
}

class _UserReviewStreamProviderElement
    extends AutoDisposeStreamProviderElement<Review?> with UserReviewStreamRef {
  _UserReviewStreamProviderElement(super.provider);

  @override
  String get productId => (origin as UserReviewStreamProvider).productId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
