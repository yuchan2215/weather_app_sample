import 'package:flutter/material.dart';

class ToastWidget extends StatelessWidget {
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;
  final String message;

  const ToastWidget({
    Key? key,
    required this.message,
    this.backgroundColor,
    this.textColor,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: backgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          icon == null ? Container() : Icon(icon, color: textColor),
          Text(
            message,
            style: TextStyle(color: textColor),
          )
        ],
      ),
    );
  }
}
