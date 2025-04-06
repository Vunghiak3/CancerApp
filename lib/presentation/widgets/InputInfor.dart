import 'package:flutter/material.dart';
import '../../theme/text_styles.dart';

class InputInfor extends StatefulWidget {
  final String label;
  final TextInputType inputType;
  final bool? isPassword;
  final TextEditingController? controller;
  final String? textError;

  const InputInfor({
    super.key,
    required this.label,
    required this.inputType,
    this.isPassword,
    this.controller,
    this.textError,
  });

  @override
  _InputInforState createState() => _InputInforState();
}

class _InputInforState extends State<InputInfor> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final isPassword = widget.isPassword ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppTextStyles.content,
        ),
        TextField(
          controller: widget.controller,
          obscureText: isPassword && !_isPasswordVisible,
          style: AppTextStyles.content,
          keyboardType: widget.inputType,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            suffixIcon: isPassword
                ? IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                size: AppTextStyles.sizeIcon,
              ),
              onPressed: () => setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              }),
            )
                : null,
          ),
        ),
        if (widget.textError != null && widget.textError!.isNotEmpty)
          Text(
            widget.textError!,
            style: TextStyle(
              fontSize: AppTextStyles.sizeSubtitle,
              color: Colors.red,
            ),
          ),
      ],
    );
  }
}
