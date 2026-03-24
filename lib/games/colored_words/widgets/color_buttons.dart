import 'package:flutter/material.dart';

class ColorButtons extends StatelessWidget {
  final Map<String, Color> colorOptions;
  final Function(String) onColorSelected;

  const ColorButtons({
    super.key,
    required this.colorOptions,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: colorOptions.entries.map((entry) {
        return InkWell(
          onTap: () => onColorSelected(entry.key),
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: entry.value,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
