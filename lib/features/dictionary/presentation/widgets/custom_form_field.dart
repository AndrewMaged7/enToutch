import 'package:easy_localization/easy_localization.dart';
import 'package:en_touch/features/dictionary/presentation/cubit/dictionary_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFormField extends StatelessWidget {
  final DictionaryCubit dictionaryCubit;
  CustomFormField({super.key, required this.dictionaryCubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DictionaryCubit, DictionaryState>(
      bloc: dictionaryCubit,
      builder: (context, state) {
        return TextFormField(
          controller: dictionaryCubit.text,
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

            prefixIcon: IconButton(
              icon: Icon(
                Icons.search,
                color: Theme.of(context).iconTheme.color,
                size: 25.sp,
              ),
              onPressed: () async {
                await dictionaryCubit.recordToText();
              },
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () async {
                  await dictionaryCubit.recordToText();
                },
                child: Image.asset(
                  "images/mic_icon.png",
                  color: state is RecordLoading ? Colors.green : Theme.of(context).iconTheme.color,
                  fit: BoxFit.contain,
                  height: state is RecordLoading ? 25.h : 20.h,
                  width: state is RecordLoading ? 19.w : 20.w,
                ),
              ),
            ),
            hintText: "home.SEARCH".tr(),
          ),
          onChanged: (value) {
            dictionaryCubit.getDictionaryData(value);
          },
        );
      },
    );
  }
}
