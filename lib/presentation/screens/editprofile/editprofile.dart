import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testfile/presentation/widgets/BirthdayInput.dart';
import 'package:testfile/presentation/widgets/InputTextField.dart';
import 'package:testfile/theme/text_styles.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

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
            ),
            InputTextField(
              placeholder: AppLocalizations.of(context)!.name,
              icon: Icons.badge_outlined,
            ),
            InputTextField(
              placeholder: AppLocalizations.of(context)!.email,
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            BirthdayInput(),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0E70CB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                ),
                child: Text(
                  AppLocalizations.of(context)!.saveChanges,
                  style: TextStyle(
                    fontSize: AppTextStyles.sizeContent,
                    color: Colors.white,
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
