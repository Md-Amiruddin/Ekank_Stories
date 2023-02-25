import 'package:flutter/material.dart';

class TopProgressBar extends StatefulWidget {

  late double maxWidth;
  double width = 0.0;

  @override
  State<TopProgressBar> createState() => _TopProgressBarState();
}

class _TopProgressBarState extends State<TopProgressBar> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        widget.width=widget.maxWidth;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    widget.maxWidth=MediaQuery.of(context).size.width;

    return Container(
        child: Center(
          child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  height: 6,
                  width: widget.maxWidth,
                ),
                AnimatedContainer(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  duration: const Duration(seconds: 7),
                  height: 6,
                  width: widget.width,
                ),
              ]
          ),
        ),
      );
  }
}

