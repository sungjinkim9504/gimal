import 'package:flutter/material.dart';

class EmotionBadge extends StatelessWidget {
  final String emotion;
  final double size;

  const EmotionBadge({super.key, required this.emotion, this.size = 32});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(emotion, style: TextStyle(fontSize: size * 0.55)),
    );
  }
}
