import 'package:flutter/material.dart';

class SpinnerSmall extends StatelessWidget {
  const SpinnerSmall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          color: Colors.black,
          strokeWidth: 1,
        ),
      ),
    );
  }
}
