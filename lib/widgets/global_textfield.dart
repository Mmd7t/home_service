import 'package:flutter/material.dart';

class GlobalTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const GlobalTextFormField({
    Key key,
    @required this.controller,
    @required this.hintText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // var themeController = ThemeController.of(context);
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
        filled: true,
        fillColor: Theme.of(context).primaryColor.withOpacity(0.2),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'fill this label please';
        }
        return null;
      },
    );
  }
}
