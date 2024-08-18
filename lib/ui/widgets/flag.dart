import 'package:flutter/material.dart';

const _defaultHeight = 20.0;

class Flag extends StatelessWidget {
  const Flag({
    Key? key,
    required this.countryCode,
    this.height = _defaultHeight,
  }) : super(key: key);

  final String? countryCode;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 8),
      child: Image.network(
        'https://flagsapi.com/${countryCode?.toUpperCase()}/flat/64.png',
        width: height,
        height: height,
        fit: BoxFit.fill,
        errorBuilder: (c, child, e) {
          return SizedBox(
            width: height,
            height: height,
            child: const ColoredBox(
              color: Colors.black12,
            ),
          );
        },
        loadingBuilder: (c, child, e) {
          if (e?.cumulativeBytesLoaded == e?.expectedTotalBytes) {
            return child;
          }

          return const SizedBox(
            height: 16,
            width: 24,
            child: ColoredBox(
              color: Colors.black12,
            ),
          );
        },
      ),
    );
  }
}
