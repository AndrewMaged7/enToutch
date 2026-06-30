import 'package:en_touch/features/setting/presentation/cubit/setting_cubit.dart';
import 'package:en_touch/features/setting/presentation/widgets/search_result_widget.dart';
import 'package:en_touch/features/setting/presentation/widgets/setting_custom_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchFriendScreen extends StatefulWidget {
  const SearchFriendScreen({super.key});

  @override
  State<SearchFriendScreen> createState() => _SearchFriendScreenState();
}

class _SearchFriendScreenState extends State<SearchFriendScreen> {
  late SettingCubit settingCubit;

  @override
  void initState() {
    super.initState();
    settingCubit = context.read<SettingCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Friends'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Image.asset(
            "images/profile_icon.png",
            color: Theme.of(context).iconTheme.color,
          ),
          SizedBox(width: 20.w),
        ],
      ),
      body: BlocConsumer<SettingCubit, SettingState>(
        listener: (context, state) {
          if (state is SearchFriendsError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(height: 40.h),
              SizedBox(
                height: 45.h,
                width: 317.w,
                child: SettingCustomForm(settingCubit: settingCubit),
              ),
              if (state is SearchFriendsLoading)
                const CircularProgressIndicator(),
              Expanded(
                child: ListView.builder(
                  itemCount: settingCubit.searchResults.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      SizedBox(height: 20.h),
                      SearchResultsWidget(
                        settingCubit: settingCubit,
                        index: index,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}