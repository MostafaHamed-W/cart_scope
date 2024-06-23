import 'package:cart_scope/src/features/products/domain/product.dart';
import 'package:cart_scope/src/features/reviews/application/reviews_service.dart';
import 'package:cart_scope/src/features/reviews/domain/review.dart';
import 'package:cart_scope/src/utils/current_date_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeaveReviewController extends StateNotifier<AsyncValue<void>> {
  LeaveReviewController(
    this.reviewsService,
    this.currentDateBuilder,
  ) : super(const AsyncData(null));
  final ReviewsService reviewsService;
  // * this is injected so we can easily mock the date in the tests
  final DateTime Function() currentDateBuilder;

  Future<void> submitReview(ProductID productID, String comment, double rating) async {
    final review = Review(rating: rating, comment: comment, date: currentDateBuilder());
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => reviewsService.submitReview(productId: productID, review: review));
  }
}

final leaveReviewControllerProvider = StateNotifierProvider.autoDispose<LeaveReviewController, AsyncValue<void>>((ref) {
  return LeaveReviewController(
    ref.watch(reviewsServiceProvider),
    ref.watch(currentDateBuilderProvider),
  );
});
