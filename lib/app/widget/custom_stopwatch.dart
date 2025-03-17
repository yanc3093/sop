import 'package:flutter/material.dart';
import 'package:sop/app/utils/constants.dart';

class CustomStopwatch extends StatelessWidget {
  final Duration elapsedTime;

  const CustomStopwatch({super.key, required this.elapsedTime});

  @override
  Widget build(BuildContext context) {
    final hours = elapsedTime.inHours.remainder(60).toString().padLeft(2, '0');
    final minutes = elapsedTime.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    final seconds = elapsedTime.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: primaryColor,
              ),
              margin: const EdgeInsets.only(right: 8, bottom: 12),
              padding: const EdgeInsets.only(
                left: 25,
                top: 12,
                right: 25,
                bottom: 12,
              ),
              child: Text(
                hours,
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Text('HOURS'),
          ],
        ),
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: primaryColor,
              ),
              margin: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
              padding: const EdgeInsets.only(
                left: 25,
                top: 12,
                right: 25,
                bottom: 12,
              ),
              child: Text(
                minutes,
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Text('MINUTES'),
          ],
        ),
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: primaryColor,
              ),
              margin: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
              padding: const EdgeInsets.only(
                left: 25,
                top: 12,
                right: 25,
                bottom: 12,
              ),
              child: Text(
                seconds,
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Text('SECONDS'),
          ],
        ),
      ],
    );
  }
}
