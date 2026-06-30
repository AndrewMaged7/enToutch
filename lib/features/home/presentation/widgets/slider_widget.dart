import 'package:carousel_slider/carousel_slider.dart';
import 'package:en_touch/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliderWidget extends StatelessWidget {
  SliderWidget({super.key});

  final HomeCubit homeCubit = HomeCubit();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(height: 164.h,autoPlay: true,viewportFraction: 1),
      items: homeCubit.sliderImages.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Image.asset(i,width: double.infinity, fit: BoxFit.cover);
          },
        );
      }).toList(),
    );
  }
}
