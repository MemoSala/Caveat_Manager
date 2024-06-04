import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class GetTaps extends StatelessWidget {
  const GetTaps({
    super.key,
    required this.initialPage,
    required this.children,
    required this.onTap,
    this.color = Colors.blue,
  });
  final int initialPage;
  final Function(int index) onTap;
  final List<String> children;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      padding: const EdgeInsets.all(3),
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0x122B2B2B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(children: [
        for (int index = 0; index < children.length; index++)
          Flexible(
            child: GetTap(
              id: index,
              initialPage: initialPage,
              name: children[index],
              onTap: () => onTap(index),
              color: color,
            ),
          ),
      ]),
    );
  }
}

class GetTap extends StatelessWidget {
  const GetTap({
    super.key,
    required this.initialPage,
    required this.id,
    required this.name,
    required this.onTap,
    required this.color,
  });
  final int initialPage, id;
  final String name;
  final Function() onTap;
  final Color color;
  @override
  Widget build(BuildContext context) {
    if (initialPage == id) {
      return ElasticIn(
        child: Container(
          margin: const EdgeInsets.all(3),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          color: const Color(0x00454e9e),
          alignment: Alignment.center,
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0x882B2B2B),
            ),
          ),
        ),
      );
    }
  }
}
