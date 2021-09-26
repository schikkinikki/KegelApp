import 'package:flutter/material.dart';

class DynamicBar extends StatefulWidget {
  final double barWidth;
  final String playerName;
  final int count;

  DynamicBar({this.barWidth, this.playerName, this.count});

  @override
  _DynamicBarState createState() => _DynamicBarState();
}

class _DynamicBarState extends State<DynamicBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 120,
          child: Text(
            widget.playerName,
            style: TextStyle(fontSize: 13),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Container(
          height: 20,
          width: widget.barWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.grey),
        ),
        Expanded(child: Container()),
        Text(
          widget.count.toString(),
          style: TextStyle(fontSize: 14),
        )
      ],
    );
  }
}
