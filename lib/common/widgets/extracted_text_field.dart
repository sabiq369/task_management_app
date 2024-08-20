import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExtractedTextField extends StatefulWidget {
  ExtractedTextField({
    super.key,
    required this.controller,
    required this.icon,
    required this.hintText,
    required this.showSuffixIcon,
    required this.textInputAction,
    required this.validator,
    this.readOnly = false,
    this.onTap,
    this.helperText = '',
    this.textInputType,
    this.capitalize = false,
  });
  TextEditingController controller = TextEditingController();
  Icon icon;
  String hintText, helperText;
  bool showSuffixIcon, readOnly, capitalize;
  TextInputAction? textInputAction;
  TextInputType? textInputType;
  String? Function(String?)? validator;
  void Function()? onTap;

  @override
  State<ExtractedTextField> createState() => _ExtractedTextFieldState();
}

class _ExtractedTextFieldState extends State<ExtractedTextField> {
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
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      keyboardType: widget.textInputType,
      textCapitalization: widget.capitalize
          ? TextCapitalization.sentences
          : TextCapitalization.none,
      decoration: InputDecoration(
        helperText: widget.helperText,
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
