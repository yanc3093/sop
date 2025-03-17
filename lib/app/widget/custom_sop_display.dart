import 'package:flutter/material.dart';
import 'package:sop/app/utils/constants.dart';

class CustomSopDisplay extends StatelessWidget {
  final bool completedStep;
  final String title;
  final String content;

  const CustomSopDisplay({
    super.key,
    required this.completedStep,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: completedStep ? primaryColor : Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: ListTile(
        isThreeLine: true,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(content),
        trailing:
            completedStep
                ? const Icon(Icons.check_circle, color: primaryColor)
                : const SizedBox.shrink(),
      ),
    );
  }
}
