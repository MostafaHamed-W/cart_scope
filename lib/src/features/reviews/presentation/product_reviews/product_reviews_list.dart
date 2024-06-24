import 'package:cart_scope/src/common_widgets/async_value_widget.dart';
import 'package:cart_scope/src/constants/breakpoints.dart';
import 'package:cart_scope/src/features/products/domain/product.dart';
import 'package:cart_scope/src/features/reviews/data/fake_review_repository.dart';
import 'package:cart_scope/src/features/reviews/presentation/product_reviews/product_review_card.dart';
import 'package:flutter/material.dart';
import 'package:cart_scope/src/common_widgets/responsive_center.dart';
import 'package:cart_scope/src/constants/app_sizes.dart';
import 'package:cart_scope/src/features/reviews/domain/review.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Shows the list of reviews for a given product ID
class ProductReviewsList extends ConsumerWidget {
  const ProductReviewsList({super.key, required this.productId});
  final ProductID productId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewsValue = ref.watch(productReviewsProvider(productId));

    return AsyncValueSliverWidget<List<Review>>(
      value: reviewsValue,
      data: (reviews) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) => ResponsiveCenter(
            maxContentWidth: Breakpoint.tablet,
            padding: const EdgeInsets.symmetric(horizontal: Sizes.p16, vertical: Sizes.p8),
            child: ProductReviewCard(reviews[index]!),
          ),
          childCount: reviews.length,
        ),
      ),
    );
  }
}
