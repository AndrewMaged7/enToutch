

import 'package:easy_localization/easy_localization.dart';
import 'package:en_touch/features/setting/presentation/cubit/setting_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingCustomForm extends StatelessWidget {
  final SettingCubit settingCubit;
  SettingCustomForm({super.key, required this.settingCubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      bloc: settingCubit,
      builder: (context, state) {
        return TextFormField(
          controller: settingCubit.searchController,
          textAlignVertical: TextAlignVertical.center,

          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              vertical: 12.h,
              horizontal: 12.w,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: Theme.of(context).iconTheme.color!,
                width: 3.sp,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: Theme.of(context).iconTheme.color!,
                width: 3.sp,
              ),
            ),

            // prefixIcon: IconButton(
            //   icon: Icon(
            //     Icons.search,
            //     color: Theme.of(context).iconTheme.color,
            //     size: 25.sp,
            //   ),
            //   onPressed: () async {
            //     await settingCubit.recordToText();
            //   },
            // ),
            hintText: "home.SEARCH".tr(),
          ),
          onChanged: (value) {
            settingCubit.searchFriends(value);
          },
        );
      },
    );
  }
}
