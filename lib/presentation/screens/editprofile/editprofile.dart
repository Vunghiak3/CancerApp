import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testfile/presentation/widgets/BirthdayInput.dart';
import 'package:testfile/presentation/widgets/CustomTopNotification.dart';
import 'package:testfile/presentation/widgets/GetProgressBar.dart';
import 'package:testfile/presentation/widgets/InputTextField.dart';
import 'package:testfile/services/auth.dart';
import 'package:testfile/services/user.dart';
import 'package:testfile/theme/text_styles.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool isUpdating = false;
  final _controllers = {
    'nickName': TextEditingController(),
    'name': TextEditingController(),
    'phone': TextEditingController(),
    'dob': TextEditingController(),
  };
  DateTime? _selectedDate;
  Map<String, dynamic> _initialValues = {};

  @override
  void initState() {
    super.initState();
    loadUser().then((_) {
      _controllers.forEach((key, controller) {
        controller.addListener(_checkForChanges);
      });
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> loadUser() async {
    try {
      final userString = await AuthService().getUser();
      if (userString == null) return;

      final user = jsonDecode(userString);

      _initialValues = Map<String, dynamic>.from(user);

      setState(() {
        _controllers.forEach((key, controller) {
          final value = user[key];
          if (key == 'dob' && value != null) {
            try {
              final date = DateTime.parse(value);
              _selectedDate = date;
              controller.text = _formatDate(date);
            } catch (_) {
              controller.clear();
            }
          } else {
            controller.text = user[key]?.toString() ?? '';
          }
        });
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  void fetchUpdateUser() async {
    String phone = _controllers['phone']?.text.trim() ?? '';

    if (phone.isNotEmpty && !isValidPhoneNumber(phone)) {
      CustomTopNotification.show(context,
          message: 'Số điện thoại không hợp lệ!',
          color: Colors.red,
          icon: Icons.cancel);
      return;
    }

    setState(() {
      isUpdating = true;
    });

    final data = <String, dynamic>{
      for (var e in _controllers.entries)
        if (e.key != 'dob' && e.value.text.isNotEmpty) e.key: e.value.text,
      if(_selectedDate != null) 'dob': _formatDateIso(_selectedDate!),
    };

    try {
      print(data);
      await UserService().updateUser(data);
      CustomTopNotification.show(context,
          message: 'Cập nhật thông tin thành công!');
      Navigator.pop(context);
    } catch (e) {
      CustomTopNotification.show(context,
          message: 'Cập nhật thông tin thất bại!');
      throw Exception(e);
    } finally {
      setState(() {
        isUpdating = false;
      });
    }
  }

  String _formatDate(DateTime date) => '${date.day}/${date.month}/${date.year}';
  String _formatDateIso(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  bool _hasChanges = false;

  void _checkForChanges() {
    final currentData = {
      for (var entry in _controllers.entries) entry.key: entry.value.text,
    };

    final currentDob = _formatDateIso(_selectedDate ?? DateTime(1900));
    final originalDob = _formatDateIso(
        DateTime.tryParse(_initialValues['dob'] ?? '') ?? DateTime(1900));

    final hasChanged = currentData.entries.any((e) {
      if (e.key == 'dob') return currentDob != originalDob;
      return e.value != (_initialValues[e.key]?.toString() ?? '');
    });

    if (_hasChanges != hasChanged) {
      setState(() => _hasChanges = hasChanged);
    }
  }

  bool isValidPhoneNumber(String phone) {
    final phoneRegex = RegExp(r'^(0|\+84)[1-9][0-9]{8}$');
    return phoneRegex.hasMatch(phone);
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
            AppLocalizations.of(context)!.editProfile,
            style: AppTextStyles.title,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
              size: AppTextStyles.sizeIconSmall,
            )),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputTextField(
              placeholder: AppLocalizations.of(context)!.nickname,
              icon: Icons.person_outline_rounded,
              controller: _controllers['nickName'],
            ),
            InputTextField(
              placeholder: AppLocalizations.of(context)!.name,
              icon: Icons.badge_outlined,
              controller: _controllers['name'],
            ),
            InputTextField(
              placeholder: 'Phone',
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
              controller: _controllers['phone'],
            ),
            BirthdayInput(
              initialDate: _selectedDate,
              onDateSelected: (DateTime newDate) {
                setState(() {
                  _selectedDate = newDate;
                  _controllers['dob']!.text =
                      '${newDate.day}/${newDate.month}/${newDate.year}';
                });
              },
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: isUpdating
                  ? GetProgressBar()
                  : ElevatedButton(
                      onPressed: _hasChanges ? fetchUpdateUser : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0E70CB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 40),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.saveChanges,
                        style: TextStyle(
                          fontSize: AppTextStyles.sizeContent,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
