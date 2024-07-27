import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icons_and_text_widget.dart';
import 'small_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BigText(
          text: text,
          size: Dimensions.font26,
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        SmallText(
            text: "lorem ipsum lorem ipsum lorem ipsum hejhwejewjegbjjh "),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                5,
                (index) => Icon(
                  Icons.star,
                  color: AppColors.mainColor,
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            SmallText(text: "4.5"),
            SizedBox(
              width: 10.0,
            ),
            SmallText(text: "1287"),
            SizedBox(
              width: 10.0,
            ),
            SmallText(text: "Comments"),
          ],
        ),
        SizedBox(
          height: Dimensions.height20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndtextWidget(
                icon: Icons.circle_sharp,
                text: "Normal",
                iconColor: AppColors.iconColor1),
            IconAndtextWidget(
                icon: Icons.location_on,
                text: "1.8km",
                iconColor: AppColors.mainColor),
            IconAndtextWidget(
                icon: Icons.access_time_rounded,
                text: "32min",
                iconColor: AppColors.iconColor2),
          ],
        )
      ],
    );
  }
}
