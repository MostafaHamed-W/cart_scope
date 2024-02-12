import 'package:cart_scope/src/common_widgets/responsive_two_column_layout.dart';
import 'package:cart_scope/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CutomShimmerLayout extends StatelessWidget {
  const CutomShimmerLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ResponsiveTwoColumnLayout(
        startFlex: 1,
        endFlex: 2,
        breakpoint: 320,
        startContent: Container(
          margin: const EdgeInsets.symmetric(vertical: 7.5),
          child: Container(
            height: 100,
            width: 100,
            color: Colors.grey,
          ),
        ),
        endContent: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 15,
                width: 200,
                color: Colors.grey,
              ),
              const SizedBox(height: 5),
              Container(
                height: 15,
                width: 200,
                color: Colors.grey,
              ),
              const SizedBox(height: 5),
              Container(
                height: 15,
                width: 200 * 0.75,
                color: Colors.grey,
              )
            ],
          ),
        ),
        spacing: Sizes.p8,
      ),
    );
  }
}
