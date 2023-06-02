import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imgPath;
  const NoDataPage({Key? key,
    required this.text,
    this.imgPath = "assets/image/empty_cart.png",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          imgPath,
          height: Dimensions.height30 * 5, //~150
          width: Dimensions.width30 * 5, //~150
        ),
        SizedBox(height: Dimensions.height10,),
        Text(
          text,
          style: TextStyle(
            fontSize: Dimensions.font12,
            color: Theme.of(context).disabledColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
