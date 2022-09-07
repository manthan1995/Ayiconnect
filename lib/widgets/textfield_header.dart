import 'package:flutter/material.dart';

class TextfieldHeader extends StatelessWidget {
  const TextfieldHeader({
    super.key,
    required this.child,
    required this.title,
  });

  final Widget child;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8.0),
        child,
      ],
    );
  }
}
