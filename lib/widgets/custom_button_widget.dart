import 'package:Tirthankar/core/const.dart';
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final Widget? child;
  final double? size;
  final double? borderWidth;
  final String? image;
  final bool? isActive;
  final VoidCallback? onTap;

  CustomButtonWidget(
      {this.child,
      @required this.size,
      @required this.onTap,
      this.borderWidth = 2,
      this.image,
      this.isActive = false});

  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(200),
      ),
      border: Border.all(
        width: borderWidth!,
        color: isActive! ? AppColors.darkBlue : AppColors.mainColor,
      ),
      boxShadow: [
        BoxShadow(
          color: AppColors.lightBlueShadow,
          blurRadius: 10,
          offset: Offset(5, 5),
          spreadRadius: 3,
        ),
        BoxShadow(
          color: Colors.white60,
          blurRadius: 10,
          offset: Offset(-5, -5),
          spreadRadius: 3,
        )
      ],
    );

    if (image != null) {
      boxDecoration = boxDecoration.copyWith(
        image:
            DecorationImage(image: ExactAssetImage(image!), fit: BoxFit.cover),
      );
    }
    if (isActive!) {
      boxDecoration = boxDecoration.copyWith(
        gradient: RadialGradient(colors: [
          AppColors.lightBlue,
          AppColors.darkBlue,
        ]),
      );
    } else {
      boxDecoration = boxDecoration.copyWith(
        gradient: RadialGradient(colors: [
          AppColors.mainColor,
          AppColors.mainColor,
          AppColors.mainColor,
          Colors.white
        ]),
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: boxDecoration,
      child: TextButton(
        style: flatButtonStyle,
        // padding: EdgeInsets.all(0),

        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.all(Radius.circular(200),)
        // ),
        onPressed: onTap,
        child: child ?? Container(),
      ),
    );
  }

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    primary: Colors.white,
    // minimumSize: Size(88, 44),
    // padding: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(200)),
    ),
    backgroundColor: Colors.blue,
  );
}
