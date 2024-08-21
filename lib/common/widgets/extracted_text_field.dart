import 'package:flutter/material.dart';

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
  final Icon icon;
  final String hintText, helperText;
  final bool showSuffixIcon, readOnly, capitalize;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final void Function()? onTap;

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
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              )
            : const SizedBox(),
      ),
    );
  }
}
