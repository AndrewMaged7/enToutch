import 'package:flutter/material.dart';

class ChooseVideoFromGalleryOrPic extends StatelessWidget {
  ChooseVideoFromGalleryOrPic({super.key,
    required this.labelOption1,
    required this.labelOption2,
    required this.option1,
    required this.option2,
  });
  final String labelOption1;
  final String labelOption2;
  final Function() option1;
  final Function() option2;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
              // Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}