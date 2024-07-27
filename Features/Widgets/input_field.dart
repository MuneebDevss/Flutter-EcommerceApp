import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key, required this.label,  this.prefix, this.postfix, this.controller, this.validate, this.maxLines, this.contentPadding,
  });
  final String label;
  final Icon? prefix;
  final Widget? postfix;
  final TextEditingController? controller;
  final String? Function(String?)? validate;
  final int? maxLines;
  final double? contentPadding;
  @override
  Widget build(BuildContext context) {
    return TextFormField(

      maxLines: maxLines,
      validator: validate,
      controller: controller,
        decoration:  InputDecoration(
          contentPadding: contentPadding==null?null:EdgeInsets.all(contentPadding??0),
          label: Text(label),
          prefixIcon: prefix,
          suffixIcon:postfix,
        )
    );
  }
}
