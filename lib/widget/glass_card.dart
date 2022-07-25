import 'dart:ui';
import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  final double? height, width;
  final Widget? child;
  final EdgeInsetsGeometry? margin, padding;
  final BorderRadiusGeometry? borderRadius;
  final Clip? clipBehavior;

  const GlassCard({
    Key? key,
    this.height,
    this.width,
    this.margin,
    this.padding,
    this.borderRadius,
    this.clipBehavior,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: ClipRect(
        clipBehavior: clipBehavior ?? Clip.hardEdge,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            width: width ?? double.maxFinite,
            height: height ?? double.maxFinite,
            //margin: margin,
            padding: padding,
            decoration: BoxDecoration(
              color: Colors.grey.shade100.withOpacity(0.15),
              borderRadius: borderRadius,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
