import 'package:cart_scope/src/features/products/domain/product.dart';
import 'package:cart_scope/src/features/reviews/application/reviews_service.dart';
import 'package:cart_scope/src/features/reviews/domain/review.dart';
import 'package:cart_scope/src/utils/current_date_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeaveReviewController extends StateNotifier<AsyncValue<void>> {
  LeaveReviewController({
    required this.reviewsService,
    required this.currentDateBuilder,
  }) : super(const AsyncData(null));
  final ReviewsService reviewsService;
  // * this is injected so we can easily mock the date in the tests
  final DateTime Function() currentDateBuilder;

  Future<void> submitReview({
    required ProductID productId,
    required double rating,
    required String comment,
  }) async {
    final review = Review(
      rating: rating,
      comment: comment,
      date: currentDateBuilder(),
    );
    state = const AsyncLoading();
    final newState = await AsyncValue.guard(() => reviewsService.submitReview(productId: productId, review: review));
    if (mounted) {
      // only set stae if the controller has not been disposed
      state = newState;
    }
  }
}

final leaveReviewControllerProvider = StateNotifierProvider.autoDispose<LeaveReviewController, AsyncValue<void>>((ref) {
  return LeaveReviewController(
    reviewsService: ref.watch(reviewsServiceProvider),
    currentDateBuilder: ref.watch(currentDateBuilderProvider),
  );
});
