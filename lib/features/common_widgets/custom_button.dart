
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final double? width;
  final Color? color;
  final String text;
  final double? height;
  final VoidCallback ontap;
  final double? buttonRadius;
  final Color? textColor;
  final double? elevation;
  final TextStyle? buttonTextStyle;
  
  CustomButton({
    super.key,
    required this.text,
    this.buttonRadius,
    this.width,
    this.color,
    this.height,
    required this.ontap,
    this.textColor,
    this.elevation,
    this.buttonTextStyle,
  });

  @override
  State<CustomButton> createState() => _CustomButtonBlackState();
}

class _CustomButtonBlackState extends State<CustomButton> {

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: widget.ontap,
      child: Material(
        elevation: widget.elevation ?? 10,
        color: widget.color ?? Colors.black,
        borderRadius: BorderRadius.circular(widget.buttonRadius ?? 10),
        child: Container(
          width: widget.width ?? size.width * 0.9,
          height: widget.height ?? size.height * 0.08,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.buttonRadius ?? 10),
            color: Colors.red,
          ),
          child: Center(
            child: Text(
              widget.text,
              style: widget.buttonTextStyle ?? TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: widget.textColor ?? Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
