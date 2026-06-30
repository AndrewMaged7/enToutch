import 'package:en_touch/features/dictionary/presentation/cubit/dictionary_cubit.dart';
import 'package:en_touch/features/dictionary/presentation/widgets/custom_form_field.dart';
import 'package:en_touch/features/dictionary/presentation/widgets/dictionary_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DictionaryScreen extends StatelessWidget {
  DictionaryScreen({super.key});
  final DictionaryCubit dictionaryCubit = DictionaryCubit();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: dictionaryCubit,
      listener: (context, state) {
        if (state is DictionaryError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is DictionaryLoading) {
          return Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            SizedBox(height: 84.h),
            Container(
              height: 45.h,
              width: 317.w,
              child: CustomFormField(dictionaryCubit: dictionaryCubit),
            ), 
            Expanded(
              child: ListView.builder(
                itemCount: dictionaryCubit.youtubeVideoModel?.length ?? 0,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(height: 20.h),
                      Visibility(
                        visible: dictionaryCubit.youtubeVideoModel != null,
                        child: DictionaryWidget(
                          dictionaryCubit: dictionaryCubit,
                          index: index,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
