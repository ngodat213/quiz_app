import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/themes/txt_style.dart';

class TextIcon extends StatelessWidget {
  const TextIcon(
    this.text, {
    super.key,
    this.suffix,
    this.prefix,
    this.width,
  });

  final String text;
  final double? width;
  final SvgPicture? suffix;
  final SvgPicture? prefix;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Row(
        children: [
          if (prefix != null) prefix!,
          SizedBox(width: 4),
          Text(
            text,
            style: TxtStyle.font14(Color(0xff999999)),
          ),
          SizedBox(width: 4),
          if (suffix != null) suffix!,
        ],
      ),
    );
  }
}
