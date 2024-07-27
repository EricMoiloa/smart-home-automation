// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  double height;
  //TextOverflow overFlow;
  SmallText(
      {Key? key,
      this.color = const Color(0xffccc7c5),
      required this.text,
      this.size = 12.0,
      this.height = 1.2
      //this.overFlow = TextOverflow.ellipsis
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      style: TextStyle(
        fontFamily: 'serif',
        color: color,
        fontSize: size,

        ///fontWeight: FontWeight.w400,
        height: height,
      ),
    );
  }
}
