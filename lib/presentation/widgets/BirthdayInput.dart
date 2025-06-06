import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testfile/theme/text_styles.dart';

class BirthdayInput extends StatefulWidget {
  final DateTime? initialDate;
  final ValueChanged<DateTime> onDateSelected;

  const BirthdayInput({super.key, required this.initialDate, required this.onDateSelected});

  @override
  State<BirthdayInput> createState() => _BirthdayInputState();
}

class _BirthdayInputState extends State<BirthdayInput> {
  DateTime tempDate = DateTime.now();

  DateTime get selectedDate => widget.initialDate ?? DateTime(2000, 1, 1);

  void _showDatePicker(BuildContext context) {
    tempDate = selectedDate;
    showDialog(
      context: context,
      builder: (BuildContext builder) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 200,
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(
                        fontSize: AppTextStyles.sizeContent,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: selectedDate,
                    minimumDate: DateTime(1900),
                    maximumDate: DateTime.now(),
                    onDateTimeChanged: (DateTime newDate) {
                      tempDate = newDate;
                    },
                  ),
                ),
              ),
              Divider(height: 1, color: Colors.grey.shade300),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        AppLocalizations.of(context)!.cancel,
                        style: TextStyle(color: Colors.red, fontSize: AppTextStyles.sizeContent),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        widget.onDateSelected(tempDate);
                        Navigator.pop(context);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.save,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: AppTextStyles.sizeContent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final date = selectedDate;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () => _showDatePicker(context),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.birthday,
            labelStyle: TextStyle(fontSize: AppTextStyles.sizeContent),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: Icon(Icons.calendar_today_outlined, color: Colors.grey),
          ),
          child: Text(
            "${date.day}/${date.month}/${date.year}",
            style: TextStyle(fontSize: AppTextStyles.sizeContent),
          ),
        ),
      ),
    );
  }
}
