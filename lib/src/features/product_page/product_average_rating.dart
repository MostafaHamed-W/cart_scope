import 'package:cart_scope/src/localization/language_constants';

import 'package:flutter/material.dart';
import 'package:cart_scope/src/constants/app_sizes.dart';
import 'package:cart_scope/src/models/product.dart';

import 'package:intl/intl.dart';

/// Shows the product average rating score and the number of ratings
class ProductAverageRating extends StatelessWidget {
  const ProductAverageRating({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    NumberFormat formatter = NumberFormat();

    return Row(
      children: [
        const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        gapW8,
        Text(
          product.avgRating.toStringAsFixed(1),
          style: Theme.of(context).textTheme.bodyText1,
        ),
        gapW8,
        Text(
          product.numRatings == 1
              ? '1 rating'
              : '${NumberFormat.decimalPattern('ar').format(product.numRatings)} ${tr(context).rating}',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
