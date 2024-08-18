import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  const AppShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300] ?? Colors.transparent,
      highlightColor: Colors.grey[100] ?? Colors.transparent,
      enabled: true,
      child: Container(),
    );
  }
}
