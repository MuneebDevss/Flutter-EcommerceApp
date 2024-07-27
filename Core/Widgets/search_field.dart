import 'package:flutter/material.dart';

import '../constants/color_palette.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search in store',
        hintStyle: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.grey),
        filled: true,
        fillColor: TColors.white,
        prefixIcon: const Icon(Icons.search,color: TColors.grey,),

      ),
    );
  }
}
