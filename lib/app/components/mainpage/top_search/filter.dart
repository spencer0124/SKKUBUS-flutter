import 'package:flutter/material.dart';
import 'package:skkumap/app_theme.dart';

class CustomFilter extends StatelessWidget {
  const CustomFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: AppColors.green_main,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: AppColors.green_main.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      width: 49,
      height: 49,
      child: const Column(
        children: [
          Spacer(),
          Icon(
            Icons.filter_alt,
            color: Colors.white,
            size: 18,
          ),
          Text(
            '필터',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'CJKMedium',
              fontSize: 8,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
