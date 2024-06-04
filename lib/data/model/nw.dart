// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

enum HeightEnum { height, width, max, value }

class Height {
  HeightEnum heightEnum = HeightEnum.max;
  int value = 50;
}

class NW extends StatelessWidget {
  NW({
    super.key,
    this.heightKey,
    this.pixel = 10,
    this.color,
    this.child = const SizedBox(),
    this.mode = true,
    this.nightMode = true,
    this.alignment = AlignmentDirectional.center,
    this.padding,
  });
  final int pixel;
  Height? heightKey;
  Color? color;
  final Widget child;
  final bool mode;
  final bool nightMode;
  final AlignmentDirectional alignment;
  EdgeInsets? padding;
  static late int height;
  static late int x100;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int heightH = (size.height).toInt();
    int heightW = (size.width).toInt();

    x100 = -pixel;

    heightKey ??= Height();
    color ??= (nightMode) ? Colors.white : Colors.black;
    padding ??= EdgeInsets.only(
      top: heightKey!.value.toDouble() / 2 * (alignment.y + 1),
      bottom: heightKey!.value.toDouble() / 2 * (alignment.y - 1).abs(),
      left: heightKey!.value.toDouble() / 2 * (alignment.start + 1),
      right: heightKey!.value.toDouble() / 2 * (alignment.start - 1).abs(),
    );

    switch (heightKey!.heightEnum) {
      case HeightEnum.value:
        height = heightKey!.value;
        break;
      case HeightEnum.height:
        height = heightH;
        break;
      case HeightEnum.width:
        height = heightW;
        break;
      case HeightEnum.max:
        height = (heightH > heightW) ? heightW : heightH;
        break;
    }
    return Stack(
      // TextDirection? textDirection,
      alignment: alignment,
      fit: StackFit.loose,
      children: [
        for (int index = 0; index < height / pixel; index++) container(size),
        SizedBox(
          height: size.height,
          width: size.width,
          child: Padding(
            padding: padding!,
            child: child,
          ),
        )
      ],
    );
  }

  Widget container(Size size) {
    x100 += pixel;
    bool keyHeight = size.height - x100 > 0;
    bool keyWidth = size.width - x100 > 0;
    double valueNightMode = (nightMode) ? 0 : 255;
    double valueMode =
        (mode) ? x100 / (height - pixel) : (x100 / (height - pixel) * -1) + 1;
    return (keyHeight && keyWidth && height - pixel >= x100)
        ? Container(
            height: size.height - x100,
            width: size.width - x100,
            color: Color.fromRGBO(
                (valueMode * (color!.red - valueNightMode) + valueNightMode)
                    .toInt(),
                (valueMode * (color!.green - valueNightMode) + valueNightMode)
                    .toInt(),
                (valueMode * (color!.blue - valueNightMode) + valueNightMode)
                    .toInt(),
                1))
        : const SizedBox();
  }
}
