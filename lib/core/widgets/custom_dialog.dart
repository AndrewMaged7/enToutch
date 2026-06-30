import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  CustomDialog({super.key,
    required this.labelOption1,
    required this.labelOption2,
    // required this.labelOption3,
    // required this.labelOption4,
    required this.option1,
    required this.option2,
    // required this.option3,
    // required this.option4,
  });
  final String labelOption1;
  final String labelOption2;
  // final String labelOption3;
  // final String labelOption4;
  final Function() option1;
  final Function() option2;
  // final Function() option3;
  // final Function() option4;

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      title: const Text('Choose Option'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(labelOption1),
            onTap: () {
              Navigator.pop(context);
              option1();
            },
          ),
          ListTile(
            title: Text(labelOption2),
            onTap: () {
              Navigator.pop(context);
              option2();
            },
          ),
          // ListTile(
          //   title: Text(labelOption3),
          //   onTap: () {
          //     Navigator.pop(context);
          //     option3();
          //   },
          // ),
          // ListTile(
          //   title: Text(labelOption4),
          //   onTap: () {
          //     Navigator.pop(context);
          //     option4();
          //   },
          // ),
        ],
      ),
    );
  }
}