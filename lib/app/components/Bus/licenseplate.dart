import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LicensePlate extends StatelessWidget {
  final String plateNumber;
  final Color textColor;
  final Color borderColor;

  const LicensePlate({
    Key? key,
    required this.plateNumber,
    this.textColor = Colors.black,
    this.borderColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        // Assuming you have an image named 'license_plate.png' in your assets
        SvgPicture.asset(
          'assets/images/LicensePlate.svg', // Update with your actual image asset path
          colorFilter: ColorFilter.mode(borderColor, BlendMode.srcIn),
          height: 24,
        ),
        Positioned(
          left: 5,
          child: Text(
            plateNumber,
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }
}
