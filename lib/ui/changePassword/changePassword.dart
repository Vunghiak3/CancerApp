import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testfile/presentation/widgets/InputText.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
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
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputText(
              label: AppLocalizations.of(context)!.currentPassword,
              placeholder: AppLocalizations.of(context)!.enterCurrentPassword,
              hideText: true,
              controller: currentPasswordController,
            ),
            InputText(
              label: AppLocalizations.of(context)!.newPassword,
              placeholder: AppLocalizations.of(context)!.enterNewPassword,
              hideText: true,
              controller: newPasswordController,
            ),
            InputText(
              placeholder: AppLocalizations.of(context)!.reEnterNewPassword,
              hideText: true,
              controller: confirmPasswordController,
            ),

            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0E70CB),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                ),
                child: Text(
                  AppLocalizations.of(context)!.saveChanges,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildTextField({
  //   required TextEditingController controller,
  //   required String label,
  // }) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 10),
  //     child: TextField(
  //       controller: controller,
  //       obscureText: true,
  //       decoration: InputDecoration(
  //         labelText: label,
  //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
  //         focusedBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(12),
  //           borderSide: BorderSide(color: Color(0xFF0E70CB), width: 2),
  //         ),
  //         suffixIcon: controller.text.isNotEmpty
  //             ? IconButton(
  //           icon: Icon(Icons.clear),
  //           onPressed: () {
  //             setState(() {
  //               controller.clear();
  //             });
  //           },
  //         )
  //             : null,
  //       ),
  //       onChanged: (text) {
  //         setState(() {});
  //       },
  //     ),
  //   );
  // }
}
