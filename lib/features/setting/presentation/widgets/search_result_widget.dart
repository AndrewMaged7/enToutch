import 'package:en_touch/core/cache/hive_cach_helper.dart';
import 'package:en_touch/core/routes/routes.dart';
import 'package:en_touch/features/setting/presentation/cubit/setting_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchResultsWidget extends StatelessWidget {
  final SettingCubit settingCubit;
  final int index;

  const SearchResultsWidget({
    super.key,
    required this.settingCubit,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final result = settingCubit.searchResults[index];

    return BlocBuilder<SettingCubit, SettingState>(
      bloc: settingCubit,
      builder: (context, state) {
        if(state is SearchFriendEmpty) {
          return Text("");
        }
        return InkWell(
          borderRadius: BorderRadius.circular(8.r),
          onTap: () {
            HiveCacheHelper.saveData("chatUserName", result.fullName);
            Navigator.pushNamed(context, Routes.chats, arguments: result.id);
          },
          child: Container(
            height: 50.h,
            width: 327.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                width: 3.sp,
                color: Theme.of(context).iconTheme.color!,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 10.w),
                SizedBox(width: 10.w),
                // Name
                Expanded(
                  child: Text(
                    result.fullName ?? 'Unknown',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(color: Colors.grey[800]),
                  ),
                ),
                // Arrow icon
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16.sp,
                  color: Theme.of(context).iconTheme.color,
                ),
                SizedBox(width: 10.w),
              ],
            ),
          ),
        );
      },
    );
  }
}
