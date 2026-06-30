import 'package:en_touch/core/cache/hive_cach_helper.dart';
import 'package:en_touch/features/auth/data/models/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeMessage extends StatelessWidget {
  final AuthModel? userModel = HiveCacheHelper.getData<AuthModel>("authData");
  WelcomeMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi, ${userModel?.fullName ?? "user name"}",
                  style: Theme.of(context).textTheme.bodyLarge,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  "Ready to translate signs today!",
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          CircleAvatar(
            backgroundImage: AssetImage("images/img_profile.png"),
            radius: 25.r,
          ),
        ],
      ),
    );
  }
}
