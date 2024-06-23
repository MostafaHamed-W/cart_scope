import 'package:cart_scope/src/features/authentication/data/fake_auth_repository.dart';
import 'package:cart_scope/src/features/products/domain/product.dart';
import 'package:cart_scope/src/features/reviews/data/fake_review_repository.dart';
import 'package:cart_scope/src/features/reviews/domain/review.dart';
import 'package:cart_scope/src/localization/string_hardcoded.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewsService {
  ReviewsService(this.ref);
  final Ref ref;

  Future<void> submitReview({
    required ProductID productId,
    required Review review,
  }) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    // * we should only call this method when the user is signed in
    assert(user != null);
    if (user == null) {
      throw AssertionError('Can\'t submit a review if the user is not signed in'.hardcoded);
    }
    await ref.read(reviewsRepositoryProvider).setReview(
          productId: productId,
          uid: user.uid,
          review: review,
        );
  }
}

final reviewsServiceProvider = Provider<ReviewsService>((ref) {
  return ReviewsService(ref);
});

/// Check if a product was previously reviewed by the user
final userReviewFutureProvider = FutureProvider.autoDispose.family<Review?, ProductID>((ref, productId) {
  final user = ref.watch(authStateChangesProvider).value;
  if (user != null) {
    return ref.watch(reviewsRepositoryProvider).fetchUserReview(productId, user.uid);
  } else {
    return Future.value(null);
  }
});

/// Check if a product was previously reviewed by the user
final userReviewStreamProvider = StreamProvider.autoDispose.family<Review?, ProductID>((ref, productId) {
  final user = ref.watch(authStateChangesProvider).value;
  if (user != null) {
    return ref.watch(reviewsRepositoryProvider).watchUserReview(productId, user.uid);
  } else {
    return Stream.value(null);
  }
});
