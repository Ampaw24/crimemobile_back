import 'package:flutter/material.dart';

import 'colors.dart';

class PasswordField extends StatefulWidget {
  final Key? fieldKey;
  final String? hintText, labelText, validateMsg;
  final FormFieldSetter<String>? onSaved;
  final bool? validate, removeBorder, showBorderRound;
  final IconData? prefixIcon;
  final ValueChanged<String>? onFieldSubmitted;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final double? borderRadius, borderWidth, height;
  final Color? borderColor;

  const PasswordField({
    super.key,
    this.fieldKey,
    @required this.hintText,
    this.onSaved,
    this.validate = true,
    this.removeBorder = false,
    this.onFieldSubmitted,
    this.labelText,
    @required this.controller,
    @required this.validateMsg,
    @required this.focusNode,
    this.prefixIcon,
    this.borderWidth,
    this.borderRadius = 10,
    this.showBorderRound = true,
    this.borderColor = GREY,
    this.height = 15,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.fieldKey,
      obscureText: _obscureText,
      onSaved: widget.onSaved,
      focusNode: widget.focusNode,
      validator: (value) {
        if (value!.isEmpty && widget.validate!) {
          return widget.validateMsg;
        }
        return null;
      },
      onFieldSubmitted: widget.onFieldSubmitted,
      style: const TextStyle(color: BLACK, fontWeight: FontWeight.w600),
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: DEEPGREY),
        labelText: widget.labelText,
        contentPadding: widget.height == null
            ? const EdgeInsets.symmetric(vertical: 15, horizontal: 10)
            : EdgeInsets.symmetric(vertical: widget.height!, horizontal: 10),
        filled: true,
        fillColor: WHITE,
        labelStyle: const TextStyle(color: BLACK),
        prefixIcon: widget.prefixIcon == null
            ? null
            : Icon(widget.prefixIcon, color: BLACK),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius!),
          borderSide: BorderSide(
            color: widget.borderColor!,
            width: widget.borderWidth!,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius!),
          borderSide: BorderSide(
            color: widget.borderColor!,
            width: widget.borderWidth!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius!),
          borderSide: BorderSide(
            color: BLACK,
            width: widget.borderWidth!,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius!),
          borderSide: BorderSide(
            color: widget.borderColor!,
            width: widget.borderWidth!,
          ),
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: BLACK,
          ),
        ),
      ),
    );
  }
}
