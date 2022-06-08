import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';

class AnimatedTetrisBackground extends StatefulWidget {
  const AnimatedTetrisBackground({Key? key, required this.child})
      : super(key: key);
  final Widget child;

  @override
  _AnimatedTetrisBackgroundState createState() =>
      _AnimatedTetrisBackgroundState();
}

class _AnimatedTetrisBackgroundState extends State<AnimatedTetrisBackground>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      behaviour: RandomParticleBehaviour(
        options: ParticleOptions(
          baseColor: Colors.cyan,
          image: Image.network(
              'https://i.pinimg.com/originals/af/37/54/af3754293e36740068bb6983aeb941d0.jpg'),
          spawnOpacity: 0.0,
          opacityChangeRate: 0.25,
          minOpacity: 0.1,
          maxOpacity: 0.4,
          particleCount: 70,
          spawnMaxRadius: 15.0,
          spawnMaxSpeed: 100.0,
          spawnMinSpeed: 30,
          spawnMinRadius: 7.0,
        ),
      ),
      vsync: this,
      child: widget.child,
    );
  }
}
