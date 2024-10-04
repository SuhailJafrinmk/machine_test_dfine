import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final double? width;
  final Color? color;
  final Widget? text;
  final double? height;
  final VoidCallback ontap;
  final double? buttonRadius;
  final Color? textColor;
  final double? elevation;
  final TextStyle? buttonTextStyle;
  final bool isLoading;
  final String buttonLabel;

  CustomButton({
    super.key,
    this.text,
    this.buttonRadius,
    this.width,
    this.color,
    this.height,
    required this.ontap,
    this.textColor,
    this.elevation,
    this.buttonTextStyle,
    this.isLoading = false,
    required this.buttonLabel,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextStyle defaultTextStyle = widget.buttonTextStyle ??
        TextStyle(
            color: widget.textColor ?? Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold);

    return InkWell(
      onTap: widget.isLoading ? null : widget.ontap, // Disable tap if loading
      child: Material(
        elevation: widget.elevation ?? 10,
        color: widget.color ?? Colors.black,
        borderRadius: BorderRadius.circular(widget.buttonRadius ?? 10),
        child: Container(
          width: widget.width ?? size.width * 0.9,
          height: widget.height ?? size.height * 0.08,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.buttonRadius ?? 10),
            color: widget.color ?? Colors.red, // Default button color
          ),
          child: Center(
            child: widget.isLoading
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          widget.textColor ?? Colors.white),
                    ),
                  )
                : widget.text ??
                    Text(
                      widget.buttonLabel,
                      style: defaultTextStyle,
                    ),
          ),
        ),
      ),
    );
  }
}
