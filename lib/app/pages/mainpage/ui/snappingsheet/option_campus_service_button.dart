import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomServiceBtn extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;
  final double size;

  const CustomServiceBtn({
    Key? key,
    required this.title,
    required this.iconPath,
    required this.onTap,
    this.size = 77, // 기본 크기
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: size,
        height: size,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 30,
              height: 30,
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(
                fontFamily: "ProductSansRegular",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
