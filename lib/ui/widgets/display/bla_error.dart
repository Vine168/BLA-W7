import 'package:flutter/material.dart';
import '../../theme/theme.dart';
class BlaError extends StatelessWidget {
  final String message;

  const BlaError({super.key, required this.message});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: BlaTextStyles.body.copyWith(color: BlaColors.textNormal),
      ),
    );
  }
}