import 'package:ecommerce_app/Features/Widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../Core/constants/sizes.dart';

class AddNewAddress extends StatefulWidget {
  const AddNewAddress({super.key});

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Address',style: Theme.of(context).textTheme.titleLarge,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: Column(
          children: [
            Text('Add a new address that might be more preferable to you or you want that would be helpful for later use.',style: Theme.of(context).textTheme.bodyLarge,),
            const SizedBox(height: Sizes.spaceBtwItems,),
            const InputField(label: 'Name', prefix: Icon(Iconsax.user)),
            const SizedBox(height: Sizes.spaceBtwItems,),
            const InputField(label: 'Phone number', prefix: Icon(Iconsax.call)),
            const SizedBox(height: Sizes.spaceBtwItems,),
            const SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(child: InputField(label: 'Street', prefix: Icon(Iconsax.building_31))),

                  SizedBox(width: Sizes.spaceBtwInputFields,),
                  Expanded(child: InputField(label: 'Postal Code', prefix: Icon(Iconsax.code)))
                ],
              ),
            ),
            const SizedBox(height: Sizes.spaceBtwItems,),
            const InputField(label: 'Country', prefix: Icon(Iconsax.global)),
            const SizedBox(height: Sizes.spaceBtwItems,),
            SizedBox(
              width: double.infinity,
                child: ElevatedButton(onPressed: (){}, child: const Text('Submit'))),
          ],
        ),
      ),
    );
  }
}
