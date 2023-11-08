import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skkumap/app_theme.dart';

class ScrollRowContainer extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final bool ischecked;

  const ScrollRowContainer({
    Key? key,
    required this.text,
    required this.icon,
    required this.ischecked,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      height: 30.h,
      decoration: BoxDecoration(
        color: ischecked ? AppColors.green_main : color,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 10,
            blurRadius: 55,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              color: ischecked ? Colors.white : Colors.black, size: 15.sp),
          SizedBox(width: 8.w),
          Text(
            text,
            style: TextStyle(
              color: ischecked ? Colors.white : Colors.black,
              fontFamily: 'CJKMedium',
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
