import 'package:flutter/material.dart';
import 'package:todo_list/app/core/ui/todo_list_icons.dart';

class AppField extends StatelessWidget {
  final String label;
  final IconButton? suffixIconButton;
  final bool obscureText;
  final ValueNotifier<bool> obscureTextVN;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;

  AppField({
    Key? key,
    required this.label,
    this.suffixIconButton,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.focusNode,
  })  : assert(obscureText == true ? suffixIconButton == null : true,
            'obscureText não pode ser enviado em conjunto com suffixIconButton'),
        obscureTextVN = ValueNotifier(obscureText),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureTextVN,
      builder: (_, obscureTextValue, child) {
        return TextFormField(
          controller: controller,
          validator: validator,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade700,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide(color: Colors.red),
            ),
            isDense: true,
            suffixIcon: this.suffixIconButton ??
                (obscureText == true
                    ? IconButton(
                        icon: Icon(
                          !obscureTextValue
                              ? TodoListIcons.eye_slash
                              : TodoListIcons.eye,
                          size: 18,
                        ),
                        onPressed: () {
                          obscureTextVN.value = !obscureTextVN.value;
                        },
                      )
                    : null),
          ),
          obscureText: obscureTextValue,
        );
      },
    );
  }
}
