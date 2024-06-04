import 'package:flutter/material.dart';
import 'dart:math';

import '../../data/model/nw.dart';

class OneGame extends StatelessWidget {
  const OneGame({super.key});

  @override
  Widget build(BuildContext context) {
    return NW(
      color: Colors.indigo,
      heightKey: Height()
        ..heightEnum = HeightEnum.value
        ..value = 90,
      pixel: 10,
      mode: true,
      nightMode: true,
      padding: null,
      alignment: AlignmentDirectional.center,
      child: const MyHomePage(),
    );
  }
}

//--------------------------------------------------------------------

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Widget> tiles;

  @override
  void initState() {
    super.initState();
    tiles = [
      const Expanded(child: SizedBox()),
      const Expanded(child: SizedBox()),
      const Expanded(child: SizedBox()),
      const Expanded(child: SizedBox()),
      const Expanded(child: SizedBox()),
      const Expanded(child: SizedBox()),
      const Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.up, // <-- reverse direction
          children: [
            Text(
              '17:59',
              style: TextStyle(
                fontSize: 25,
                color: Color.fromARGB(255, 255, 214, 79),
              ),
            ),
            Icon(Icons.timer, color: Color.fromARGB(255, 255, 214, 79)),
          ],
        ),
      ),
      const Expanded(child: SizedBox()),
      const Expanded(child: SizedBox()),
      const Expanded(child: SizedBox()),
      const Expanded(child: SizedBox()),
      const Expanded(child: SizedBox()),
      const Expanded(child: SizedBox()),
    ];
  }

  final List<int> _img = [9, 20, 22, 28, 31];
  int _x = Random().nextInt(5), _y = Random().nextInt(5);
  final List<int> _imgNum = [0, 0, 0, 0, 0];
  int _num = 0;

  TextStyle style({Color? color}) {
    color ??= Colors.amber;
    return TextStyle(
      fontSize: 35,
      height: 1,
      foreground: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = color,
      shadows: <Shadow>[Shadow(color: color, blurRadius: 6)],
      fontFeatures: const <FontFeature>[FontFeature.enable('smcp')],
      fontVariations: const <FontVariation>[
        FontVariation('wght', 900),
      ],
      fontFamily: "RobotoSlab",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Stack(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: tiles,
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            color: Colors.white,
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ]),
        backgroundColor: Colors.indigo[800],
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text.rich(TextSpan(
          text: ">",
          children: [
            TextSpan(text: " data", style: style(color: Colors.white)),
            TextSpan(text: " 12", style: style(color: Colors.cyan)),
          ],
          style: style(color: Colors.pink),
          // GestureRecognizer? recognizer,
          // MouseCursor? mouseCursor,
          // onEnter: (event) => print(event),
          // onExit: (event) => print(event),
          // String? semanticsLabel,
          // Locale? locale,
          // bool? spellOut,
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 30,
              height: 30,
              child: CustomPaint(
                painter: MyPainter2(),
                child: Container(),
              ),
            ),
            Text(" $_num", style: style()),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: newMethod(0) +
              newMethod(1) +
              newMethod(2) +
              newMethod(3) +
              newMethod(4),
        ),
        Row(children: <Expanded>[button(_x), button(_y)]),
        Row(children: [button(0, k: false)])
      ]),
    );
  }

  Expanded button(int index, {bool? k, Key? key}) {
    k ??= true;
    return Expanded(
      flex: 1,
      key: key,
      child: ElevatedButton(
        onPressed: (k)
            ? () {
                setState(() {
                  random();
                });
              }
            : () {
                setState(() {
                  tiles.insert(tiles.length - 1, tiles.removeAt(0));
                });
              },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
        ),
        child: (k)
            ? Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Image.asset('images/${_img[index]}.png'),
              )
            : null,
      ),
    );
  }

  List<Widget> newMethod(int index) {
    return [
      Padding(
        padding: const EdgeInsets.all(7),
        child: Image.asset('images/${_img[index]}.png', height: 30),
      ),
      Text(
        "${_imgNum[index]}",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 21,
          fontFamily: "RobotoSlab",
        ),
      ),
    ];
  }

  random() {
    _x = Random().nextInt(5);
    _y = Random().nextInt(5);
    if (_x == _y) {
      _num++;
      for (var i = 0; i <= 4; i++) {
        if (_x == i) {
          _imgNum[i]++;
          break;
        }
      }
    }
  }
}

//--------------------------------------------------------------------

class StatefulColorfulTile extends StatefulWidget {
  const StatefulColorfulTile({super.key});

  @override
  State<StatefulColorfulTile> createState() => _StatefulColorfulTileState();
}

class _StatefulColorfulTileState extends State<StatefulColorfulTile> {
  final Color myColor = UniqueColorGenerator.getColor();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 50,
      color: myColor,
    );
  }
}

class UniqueColorGenerator {
  static Random random = Random();
  static Color getColor() {
    return Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }
}

//--------------------------------------------------------------------

class MyPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double radius = min(size.width, size.height) / 2;
    Offset center = Offset(size.width / 2, size.height / 2);
    Paint paint = Paint()..color = Colors.amber;
    canvas.drawCircle(center, radius, paint);
    Paint smilePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawCircle(
      Offset(center.dx - radius * 1.5 / 4, center.dy - radius * 1.5 / 4),
      3,
      Paint(),
    );
    canvas.drawCircle(
      Offset(center.dx + radius * 1.5 / 4, center.dy - radius * 1.5 / 4),
      3,
      Paint(),
    );
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height * 2.2 / 4),
        radius: radius / 2,
      ),
      0,
      pi,
      false,
      smilePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
