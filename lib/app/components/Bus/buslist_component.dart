import 'package:flutter/material.dart';

class BusListComponent extends StatelessWidget {
  final String stationName;
  final String? stationNumber;
  final String eta;
  final bool isFirstStation;
  final bool isLastStation;
  final bool isRotationStation;
  final Color color;

  const BusListComponent({
    Key? key,
    required this.stationName,
    this.stationNumber,
    required this.eta,
    required this.isFirstStation,
    required this.isLastStation,
    required this.isRotationStation,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 50),
            // Left side shape UI
            SizedBox(
              height: 66,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 2,
                    height: 26,
                    color: isFirstStation ? Colors.white : color,
                  ),
                  if (isRotationStation)
                    Container(
                      width: 34,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(color: color),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                "회차",
                                style: TextStyle(
                                    color: color,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.u_turn_right_rounded,
                                size: 12,
                                color: color,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  else
                    Container(
                      alignment: Alignment.center,
                      width: 34,
                      height: 14,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: color),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        size: 12,
                        color: color,
                      ),
                    ),
                  Container(
                    width: 2,
                    height: 26,
                    color: isLastStation ? Colors.white : color,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            // Right side text UI
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(stationName,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500)),
                      if (stationName == "혜화역4번출구" ||
                          stationName == "혜화역1번출구" ||
                          stationName == "혜화역.마로니에공원")
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 1),
                          margin: const EdgeInsets.only(left: 2),
                          alignment: Alignment.center,
                          width: 13,
                          height: 13,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.purple),
                          child: const Text(
                            "4",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (stationNumber != null)
                        Text(stationNumber!,
                            style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey)),
                      if (stationNumber != null)
                        Text(" | ",
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.withOpacity(0.3))),
                      Text(
                        eta,
                        style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey.withOpacity(0.5),
            ),
            const SizedBox(
              width: 3,
            ),
          ],
        ),
        if (!isLastStation)
          Padding(
            padding: const EdgeInsets.only(left: 50 + 15),
            child: Divider(
              color: Colors.grey.withOpacity(0.4),
              height: 0,
            ),
          ),
      ],
    );
  }
}
