import 'package:flutter/material.dart';

class Heart extends StatefulWidget {
  const Heart({super.key});

  @override
  HeartState createState() => HeartState();
}

class HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  bool isFav = false;
  AnimationController? _controller;
  Animation<Color?>? _colorAnimation;
  Animation<double>? _sizeAnimation;
  Animation<double>? _curve;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _curve = CurvedAnimation(parent: _controller!, curve: Curves.easeInOutCirc);

    _colorAnimation = ColorTween(
      begin: Colors.grey[400],
      end: Colors.red,
    ).animate(_curve!);

    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 30.0, end: 50.0),
        weight: 50,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 50.0, end: 30.0),
        weight: 50,
      ),
    ]).animate(_curve!);

    _controller!.addListener(() {
      debugPrint(_controller!.value.toString());
      debugPrint(_colorAnimation!.value.toString());
    });

    _controller!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isFav = true;
        });
      }
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isFav = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller!,
      builder: (context, _) {
        return IconButton(
          icon: Icon(
            Icons.favorite,
            color: _colorAnimation!.value,
            size: _sizeAnimation!.value,
          ),
          onPressed: () {
            isFav ? _controller!.reverse() : _controller!.forward();
          },
        );
      },
    );
  }
}
