import 'package:flutter/material.dart';
import 'package:testfile/theme/text_styles.dart';

class InputTextField extends StatefulWidget {
  final String? label;
  final String? placeholder;
  final IconData? icon;
  final TextInputType? keyboardType;
  final bool? hideText;
  final TextEditingController? controller;

  const InputTextField({
    super.key,
    this.placeholder,
    this.icon,
    this.keyboardType,
    this.controller,
    this.hideText,
    this.label,
  });

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.hideText ?? false;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isPassword = widget.hideText ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null && widget.label!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              widget.label!,
              style: TextStyle(
                fontSize: AppTextStyles.sizeContent,
                color: Color(0xFF0E70CB),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TextField(
            controller: widget.controller,
            obscureText: isPassword ? _obscureText : false,
            keyboardType: widget.keyboardType ?? TextInputType.text,
            decoration: InputDecoration(
              labelText: widget.placeholder,
              labelStyle: TextStyle(fontSize: AppTextStyles.sizeContent),
              prefixIcon: widget.icon == null
                  ? null
                  : Icon(widget.icon, color: Colors.grey, size: 24),
              suffixIcon: isPassword
                  ? IconButton(
                icon: Icon(
                  _obscureText
                      ? Icons.visibility_off
                      : Icons.visibility,
                    size: AppTextStyles.sizeIcon,
                ),
                onPressed: _togglePasswordVisibility,
              )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFF0E70CB), width: 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
