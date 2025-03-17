import 'package:flutter/material.dart';
import 'package:sop/app/utils/constants.dart';

class CustomPageNumber extends StatelessWidget {
  final String? pageNumber;
  final bool isSelected;
  final bool isCompleted;

  const CustomPageNumber({
    super.key,
    required this.pageNumber,
    required this.isSelected,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? primaryColor : Colors.grey.shade300,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
            color: isSelected ? primaryColor : Colors.grey.shade300,
          ),
          margin: const EdgeInsets.all(5),
          height: 40,
          width: 40,
          child: Center(
            child: Text(
              pageNumber ?? '',
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
        isCompleted
            ? Positioned(
              right: 0,
              top: 0,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    height: 18,
                    width: 18,
                  ),
                  const Icon(Icons.check_circle, color: primaryColor, size: 18),
                ],
              ),
            )
            : Container(),
      ],
    );
  }
}

class DiagonalLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white
          ..strokeWidth = 5;

    canvas.drawLine(
      Offset(6, size.height - 6),
      Offset(size.width - 6, 6),
      paint,
    );

    canvas.drawLine(
      const Offset(6, 6),
      Offset(size.width - 6, size.height - 6),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
