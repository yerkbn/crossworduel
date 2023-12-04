import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ConfettiWrapper extends StatefulWidget {
  final Widget child;
  const ConfettiWrapper({
    super.key,
    required this.child,
  });

  @override
  State<ConfettiWrapper> createState() => _ConfettiWrapperState();
}

class _ConfettiWrapperState extends State<ConfettiWrapper> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 10));
    _startConfetti();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  Future<void> _startConfetti() async {
    while (!mounted) {
      await Future.delayed(const Duration(milliseconds: 300));
    }
    _confettiController.play();
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        _buildConfetti(),
      ],
    );
  }

  Widget _buildConfetti() {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        confettiController: _confettiController,
        numberOfParticles: 100,
        blastDirectionality: BlastDirectionality
            .explosive, // don't specify a direction, blast randomly
        shouldLoop: true, // start again as soon as the animation is finished
        // colors: const [
        //   Colors.white,
        //   Colors.red,
        //   Colors.green
        // ], // manually specify the colors to be used
        createParticlePath: drawStar, // define a custom shape/path.
      ),
    );
  }
}
