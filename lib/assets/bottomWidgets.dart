import 'package:flutter/material.dart';

class BottomWidgets extends StatefulWidget {

  dynamic onPress;

  BottomWidgets({required this.onPress});

  @override
  State<BottomWidgets> createState() => _BottomWidgetsState();
}

class _BottomWidgetsState extends State<BottomWidgets>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _arrowAnimation;
  late Animation<double> _pillAnimation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _arrowAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 0), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 1), weight: 50)
    ]).animate(_controller);

    _pillAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 0.9), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 0.9, end: 1), weight: 50),
    ]).animate(
        CurvedAnimation(parent: _controller, curve: Curves.bounceInOut));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _controller.forward();
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, _) {
              return Opacity(
                opacity: _arrowAnimation.value,
                child: Padding(
                  padding:
                      EdgeInsets.only(bottom: (1 - _arrowAnimation.value) * 10),
                  child: const Icon(
                    Icons.arrow_drop_up,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
          GestureDetector(
            onTap: widget.onPress,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, _) {
                return SizedBox(
                  width: _pillAnimation.value * 138,
                  height: _pillAnimation.value * 35,
                  child: Container(
                    padding: const EdgeInsets.only(left: 8, right: 13),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(50)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: CircleAvatar(
                            radius: 15,
                            child: const Icon(Icons.link),
                            backgroundColor: Colors.grey.shade200,
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        const Expanded(
                          child: Center(
                            child: Text(
                              'Read More',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
