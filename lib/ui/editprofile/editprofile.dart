import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nickname'
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
            Text(
              'Name'
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
            Text(
              'Email'
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
            BirthdayInput(),
            Text(
                'Region'
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0E70CB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                        minimumSize: Size(double.minPositive, 50)
                    ),
                    child: Text(
                      'Save changes',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                      ),
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                    tempDate = newDate; // Lưu ngày tạm thời
                  },
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context), // Đóng dialog khi hủy
                      child: Text("Cancel", style: TextStyle(color: Colors.red, fontSize: 16)),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          selectedDate = tempDate; // Cập nhật ngày đã chọn
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Save",
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Birthday'),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () => _showDatePicker(context),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
              style: TextStyle(fontSize: 16),
            ),
          ),
        )
      ],
    );
  }
}


// class BirthdayDropdownPicker extends StatefulWidget {
//   @override
//   _BirthdayDropdownPickerState createState() => _BirthdayDropdownPickerState();
// }
//
// class _BirthdayDropdownPickerState extends State<BirthdayDropdownPicker> {
//   int selectedDay = 1;
//   int selectedMonth = 1;
//   int selectedYear = 2000;
//
//   List<int> days = List.generate(31, (index) => index + 1);
//   List<int> months = List.generate(12, (index) => index + 1);
//   List<int> years = List.generate(100, (index) => 1925 + index);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("Birthday", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//         SizedBox(height: 8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // Dropdown chọn Ngày
//             Expanded(
//               child: DropdownButtonFormField<int>(
//                 value: selectedDay,
//                 onChanged: (value) => setState(() => selectedDay = value!),
//                 items: days.map((day) => DropdownMenuItem(value: day, child: Text("$day"))).toList(),
//                 decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
//               ),
//             ),
//             SizedBox(width: 10),
//             // Dropdown chọn Tháng
//             Expanded(
//               child: DropdownButtonFormField<int>(
//                 value: selectedMonth,
//                 onChanged: (value) => setState(() => selectedMonth = value!),
//                 items: months.map((month) => DropdownMenuItem(value: month, child: Text("$month"))).toList(),
//                 decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
//               ),
//             ),
//             SizedBox(width: 10),
//             // Dropdown chọn Năm
//             Expanded(
//               child: DropdownButtonFormField<int>(
//                 value: selectedYear,
//                 onChanged: (value) => setState(() => selectedYear = value!),
//                 items: years.map((year) => DropdownMenuItem(value: year, child: Text("$year"))).toList(),
//                 decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

