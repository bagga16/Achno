import 'package:flutter/material.dart';

class CommonTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool readOnly;
  final bool isPassword;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;
  final int? maxLines;
  final double? height; // Optional height

  const CommonTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.keyboardType,
    this.contentPadding,
    this.prefixIcon,
    this.maxLines,
    this.height, // Make height optional
  }) : super(key: key);

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 42, // Default to 42.h if not provided
      child: TextField(
        controller: widget.controller,
        readOnly: widget.readOnly,
        keyboardType: widget.keyboardType,
        obscureText: widget.isPassword ? _isObscured : false,
        maxLines: widget.maxLines ?? 1,
        onTap: widget.onTap,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide:
                const BorderSide(color: Color.fromRGBO(188, 186, 186, 1)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide:
                const BorderSide(color: Color.fromRGBO(188, 186, 186, 1)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide:
                const BorderSide(color: Color.fromRGBO(188, 186, 186, 1)),
          ),
          contentPadding: widget.contentPadding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _isObscured ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                )
              : null,
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
