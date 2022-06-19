import 'package:flutter_neumorphic/flutter_neumorphic.dart';
//****

typedef OnPressed = void Function()?;

Widget renderButton({
  @required double? width,
  @required double? height,
  @required EdgeInsets? padding,
  @required Widget? child,
  @required OnPressed onTap,
  @required Color? iconColor,
  @required double? iconSize,
  @required IconData? icon,
  bool isAnimate = false,
  bool useButton = true,
  double radiusContainer = 25,
  NeumorphicShape buttonShape = NeumorphicShape.convex,
  Color? buttonColor = const Color.fromARGB(47, 80, 80, 80),
  EdgeInsetsGeometry robbonThickness = const EdgeInsets.all(5),
}) {
  return Padding(
    padding: padding!,
    child: SizedBox(
      width: width,
      height: height,
      child: Neumorphic(
        style: NeumorphicStyle(
          boxShape: useButton
              ? const NeumorphicBoxShape.circle()
              : NeumorphicBoxShape.roundRect(
                  BorderRadius.all(
                    Radius.circular(radiusContainer),
                  ),
                ),
          intensity: 0.5,
          shadowLightColor: useButton
              ? const Color.fromARGB(200, 130, 130, 130)
              : const Color.fromARGB(118, 130, 130, 130),
          shadowDarkColor: Colors.black,
          depth: useButton ? 9 : 12,
          color: buttonColor,
        ),
        child: Padding(
          padding: robbonThickness,
          child: useButton
              ? NeumorphicButton(
                  onPressed: onTap,
                  style: NeumorphicStyle(
                    boxShape: const NeumorphicBoxShape.circle(),
                    shape: buttonShape,
                    intensity: 0.6,
                    surfaceIntensity: 0.5,
                    depth: 1.5,
                    shadowLightColor: const Color.fromARGB(200, 255, 255, 255),
                  ),
                  padding: const EdgeInsets.only(right: 0),
                  child: isAnimate
                      ? child
                      : Icon(
                          icon,
                          color: iconColor,
                          size: iconSize,
                        ),
                )
              : Neumorphic(
                  style: NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.all(
                        Radius.circular(radiusContainer),
                      ),
                    ),
                    shape: NeumorphicShape.concave,
                    intensity: 0.0,
                    surfaceIntensity: 0.3,
                    depth: 8,
                    shadowLightColor: const Color.fromARGB(200, 255, 255, 255),
                  ),
                  padding: const EdgeInsets.only(right: 3),
                  child: child,
                ),
        ),
      ),
    ),
  );
}
