import 'package:flutter/widgets.dart';
import 'package:line_icons/line_icons.dart';

class TextFilesPage extends StatelessWidget {
  const TextFilesPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(children: [
      SizedBox(width: 15),
      Text(
        "Date Modified",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      SizedBox(width: 2),
      Icon(LineIcons.arrowDown, size: 20)
    ]);
  }
}
