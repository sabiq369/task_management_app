import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EmailTextField extends StatefulWidget {
  EmailTextField({
    super.key,
    required this.controller,
    required this.icon,
    required this.hintText,
    required this.showSuffixIcon,
    required this.textInputAction,
    required this.validator,
  });
  TextEditingController controller = TextEditingController();
  Icon icon;
  String hintText;
  bool showSuffixIcon;
  TextInputAction? textInputAction;
  String? Function(String?)? validator;

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.showSuffixIcon
          ? showPassword
              ? false
              : true
          : false,
      textInputAction: widget.textInputAction,
      validator: widget.validator,
      decoration: InputDecoration(
        prefixIcon: widget.icon,
        hintText: widget.hintText,
        suffixIcon: widget.showSuffixIcon
            ? IconButton(
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                icon: showPassword
                    ? Icon(Icons.visibility)
                    : Icon(Icons.visibility_off),
              )
            : const SizedBox(),
      ),
    );
  }
}
