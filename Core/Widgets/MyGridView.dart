import 'package:flutter/material.dart';

import '../constants/sizes.dart';

class MyGridView extends StatelessWidget {
  const MyGridView({
    super.key, required this.itemBuilder, required this.count,
  });
  final Widget? Function(BuildContext, int) itemBuilder;
  final int count;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: Sizes.md,
        crossAxisSpacing: Sizes.md,
        mainAxisExtent: 300,
        crossAxisCount: 2,
      ),
      itemCount: count, // Adjust the item count as needed
      itemBuilder: itemBuilder,
    );
  }
}
