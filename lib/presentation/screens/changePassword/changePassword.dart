import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testfile/presentation/widgets/InputTextField.dart';
import 'package:testfile/services/auth.dart';
import 'package:testfile/services/user.dart';
import 'package:testfile/theme/text_styles.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  Map<String, String> errors = {
    "current_password": '',
    "confirm_password": ''
  };
  bool _isLoading = false;

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void handleError(dynamic errorResponse){
    String error= '';
    if(errorResponse is List){
      error = errorResponse[0]['msg'];
      final field = errorResponse[0]['loc'][1];
      setState(() {
        errors[field] = '$error!';
      });
    }else{
      error = errorResponse.toString();
      setState(() {
        errors['current_password'] = '$error!';
      });
    }
  }

  bool checkPassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
    required void Function(Map<String, String>) setErrors,
  }) {
    Map<String, String> errorMap = {};

    if (newPassword != confirmPassword) {
      errorMap['confirm_password'] = 'Password confirmation does not match.';
    }

    if (currentPassword == newPassword) {
      errorMap['confirm_password'] = 'New password must be different from the current password.';
    }

    if (errorMap.isNotEmpty) {
      setErrors(errorMap);
      return false;
    }

    return true;
  }

  void fetchChangePassword() async {
    setState(() {
      _isLoading = true;
      errors = {
        'current_password': '',
        'confirm_password': '',
        'new_password': ''
      };
    });
    String currentPassword = currentPasswordController.text;
    String newPassword = newPasswordController.text;
    String confirmPassword = confirmPasswordController.text;

    bool isValid = checkPassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
      setErrors: (Map<String, String> newErrors) {
        setState(() {
          errors.addAll(newErrors);
        });
      },
    );

    if (!isValid) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      String? userJson = await AuthService().getUser();
      Map<String, dynamic> user = jsonDecode(userJson!);
      String idToken = user['idToken'];

      await UserService().changePassword(currentPassword, newPassword, idToken);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password changed successfully!')),
      );

      currentPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
    } catch (e) {
      try {
        final errorResponse = jsonDecode(e.toString())['detail'];
        handleError(errorResponse);
      } catch (e) {
        throw Exception(e);
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: false,
        title: Transform.translate(
          offset: Offset(-20, 0),
          child: Text(
            AppLocalizations.of(context)!.changePassword,
            style: AppTextStyles.title,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: AppTextStyles.sizeIconSmall),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputTextField(
              label: AppLocalizations.of(context)!.currentPassword,
              placeholder: AppLocalizations.of(context)!.enterCurrentPassword,
              hideText: true,
              controller: currentPasswordController,
            ),
            if (errors['current_password']!.isNotEmpty)
              Column(
                children: [
                  Text(
                    errors['current_password']!,
                    style: TextStyle(
                      fontSize: AppTextStyles.sizeSubtitle,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 10,)
                ],
              ),
            InputTextField(
              label: AppLocalizations.of(context)!.newPassword,
              placeholder: AppLocalizations.of(context)!.enterNewPassword,
              hideText: true,
              controller: newPasswordController,
            ),
            InputTextField(
              placeholder: AppLocalizations.of(context)!.reEnterNewPassword,
              hideText: true,
              controller: confirmPasswordController,
            ),
            if (errors['confirm_password']!.isNotEmpty)
              Text(
                errors['confirm_password']!,
                style: TextStyle(
                  fontSize: AppTextStyles.sizeSubtitle,
                  color: Colors.red,
                ),
              ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: fetchChangePassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0E70CB),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                ),
                child: Text(
                  AppLocalizations.of(context)!.saveChanges,
                  style: TextStyle(fontSize: AppTextStyles.sizeContent, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
