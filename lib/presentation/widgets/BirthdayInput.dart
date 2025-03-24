import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BirthdayInput extends StatefulWidget {
  const BirthdayInput({super.key});

  @override
  State<BirthdayInput> createState() => _BirthdayInputState();
}

class _BirthdayInputState extends State<BirthdayInput> {
  DateTime selectedDate = DateTime.now();
  DateTime tempDate = DateTime.now();

  void _showDatePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext builder) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 200,
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
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          selectedDate = tempDate;
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.save,
                        style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () => _showDatePicker(context),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.birthday,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: Icon(Icons.calendar_today_outlined, color: Colors.grey),
          ),
          child: Text(
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}