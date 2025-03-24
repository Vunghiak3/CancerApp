import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String? label;
  final String placeholder;
  final IconData? icon;
  final TextInputType? keyboardType;
  final bool? hideText;
  final TextEditingController? controller;
  const InputText({super.key, required this.placeholder, this.icon, this.keyboardType, this.controller, this.hideText, this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(label != null && label!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              label!,
              style: TextStyle(color: Color(0xFF0E70CB), fontWeight: FontWeight.w500),
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextField(
            controller: controller,
            obscureText: hideText ?? false,
            keyboardType: keyboardType ?? TextInputType.text,
            decoration: InputDecoration(
              labelText: placeholder,
              prefixIcon: icon == null ? null : Icon(icon, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFF0E70CB), width: 2),
              ),
              suffixIcon: null
            ),
          ),
        ),
      ],
    );
  }
}
