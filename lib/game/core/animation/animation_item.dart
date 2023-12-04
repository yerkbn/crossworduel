import 'package:crossworduel/core/local-pub/vector/vector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum CustomAnimationStatus {
  initialRendered, // This will be called when our object is rendered
  toPositionFinished,
  toAngleFinished,
  toSizeFinished,
}

void defaultStatusListener(CustomAnimationStatus state) {}

/// This is parameters which will be changes over animation
class AnimationParameters {
  final Vector position;
  final double angle;
  final Vector size;
  final int positionDuration;
  final int angleDuration;
  final int sizeDuration;
  final Curve curve;
  final Function(CustomAnimationStatus status)
      onStatus; // This is listener when some animation finished this will be called

  final Color hilightColor;
  final bool view2Open; // in card items if we want to be opend as default

  AnimationParameters(
      {required this.position,
      required this.angle,
      required this.size,
      this.positionDuration = 400,
      this.angleDuration = 100,
      this.sizeDuration = 100,
      this.curve = Curves.easeOutQuad,
      this.onStatus = defaultStatusListener,
      this.hilightColor = Colors.red,
      this.view2Open = false});

  AnimationParameters getCopy({Vector? position, double? angle, Vector? size}) {
    return AnimationParameters(
      position: position ?? this.position,
      angle: angle ?? this.angle,
      size: size ?? this.size,
      positionDuration: positionDuration,
      angleDuration: angleDuration,
      sizeDuration: sizeDuration,
      curve: curve,
      onStatus: onStatus,
      hilightColor: hilightColor,
    );
  }
}

class AnimationItem extends StatefulWidget {
  final AnimationParameters initialParameters;
  final Widget child1;
  final Widget child2;

  const AnimationItem({
    required super.key,
    required this.initialParameters,
    required this.child2,
    required this.child1,
  });
  @override
  State<StatefulWidget> createState() {
    return AnimationItemState();
  }
}

class AnimationItemState extends State<AnimationItem>
    with TickerProviderStateMixin {
  // Animation stuff
  late final Animation _positionAnimation;
  late final AnimationController _positionController;
  late final Animation _angleAnimation;
  late final AnimationController _angleController;
  late final Animation _sizeAnimation;
  late final AnimationController _sizeController;

  // Local parameters
  AnimationParameters? _initial; // This is used to animation porposes
  AnimationParameters? _final; // This is used to animation porposes

  AnimationParameters get _parameters => widget.initialParameters;

  bool _isChild1 = true; // It will be define which child to show
  bool _isHilight = false;

  @override
  void initState() {
    super.initState();
    _createAnimations();

    setState(() {
      // We set each item to its initial poisitions
      _initial = widget.initialParameters;
      _final = widget.initialParameters;
    });

    SchedulerBinding.instance.addPostFrameCallback(

        ///Widget build is completed
        /// This will be trigger when annimation is started
        (_) => _parameters.onStatus(CustomAnimationStatus.initialRendered));
  }

  @override
  void dispose() {
    _positionController.dispose();
    _angleController.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  void _createAnimations() {
    // Position controller
    _positionController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: _parameters.positionDuration));
    final Animation<double> curve =
        CurvedAnimation(parent: _positionController, curve: _parameters.curve);
    _positionAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(curve)
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          _positionController.reset();
          setState(() {
            _initial = _initial!.getCopy(position: _final!.position.getCopy);
          });
          _parameters.onStatus(CustomAnimationStatus.toPositionFinished);
        }
      });

    // Angle Controller
    _angleController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: _parameters.angleDuration));
    _angleAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_angleController)
          ..addStatusListener((AnimationStatus status) {
            if (status == AnimationStatus.completed) {
              _angleController.reset();
              setState(() {
                _initial = _initial!.getCopy(angle: _final!.angle);
              });
              _parameters.onStatus(CustomAnimationStatus.toAngleFinished);
            }
          });

    // Size Controller
    _sizeController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: _parameters.sizeDuration));
    _sizeAnimation = Tween<double>(begin: .0, end: 1).animate(_sizeController)
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          _sizeController.reset();
          setState(() {
            _initial = _initial!.getCopy(size: _final!.size);
          });
          _parameters.onStatus(CustomAnimationStatus.toSizeFinished);
        }
      });
  }

  // PUBLIC API

  TickerFuture toPosition(Vector position) {
    setState(() {
      _final = _final!.getCopy(position: position);
    });
    return _positionController.forward();
  }

  void toAngle(double angle) {
    setState(() {
      _final = _final!.getCopy(angle: angle);
    });
    _angleController.forward();
  }

  void toSize(Vector size) {
    setState(() {
      _final = _final!.getCopy(size: size);
    });
    _sizeController.forward();
  }

  void toHilight(Vector size) {
    setState(() {
      _final = _final!.getCopy(size: size);
      _isHilight = true;
    });
    _sizeController.forward();
  }

  /// Instants mean that there no any animationn it will happen instantly
  void toPositionInstant(Vector position) {
    setState(() {
      _final = _final!.getCopy(position: position);
      _initial = _initial!.getCopy(position: position);
    });
  }

  void toAngleInstant(double angle) {
    setState(() {
      _final = _final!.getCopy(angle: angle);
      _initial = _initial!.getCopy(angle: angle);
    });
  }

  void toSizeInstant(Vector size) {
    setState(() {
      _final = _final!.getCopy(size: size);
      _initial = _initial!.getCopy(size: size);
    });
  }

  void openChild1() => setState(() => _isChild1 = true);
  void openChild2() => setState(() => _isChild1 = false);

  @override
  Widget build(BuildContext context) {
    return _AnimatedPosition(
      a: _initial!,
      b: _final!,
      animation: _positionAnimation,
      child: _AnimatedAngle(
        b: _final!,
        a: _initial!,
        animation: _angleAnimation,
        child: _AnimatedSize(
          b: _final!,
          a: _initial!,
          animation: _sizeAnimation,
          child: Container(
            decoration: _isHilight
                ? BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setWidth(20)),
                    boxShadow: [
                        BoxShadow(
                          color: _parameters.hilightColor,
                          spreadRadius: ScreenUtil().setWidth(7),
                          blurRadius: ScreenUtil().setWidth(5),
                        )
                      ])
                : null,
            child: _isChild1 ? widget.child1 : widget.child2,
          ),
        ),
      ),
    );
  }
}

/// This clalss  is responsible for position animation
/// like from A to B
class _AnimatedPosition extends AnimatedWidget {
  final AnimationParameters a;
  final AnimationParameters b;
  final Widget child;
  const _AnimatedPosition(
      {super.key,
      required Animation animation,
      required this.a,
      required this.child,
      required this.b})
      : super(listenable: animation);

  double calcY(double i) {
    final double difference = b.position.y - a.position.y;
    return a.position.y + i * difference;
  }

  double calcX(double i) {
    final double difference = b.position.x - a.position.x;
    return a.position.x + i * difference;
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    final double i = animation.value;
    return Positioned(
      top: ScreenUtil().setHeight(calcY(i) - (b.size.y / 2)),
      left: ScreenUtil().setWidth(calcX(i) - (b.size.x / 2)),
      child: child,
    );
  }
}

/// This is responsible for rotation
/// of objects
class _AnimatedAngle extends AnimatedWidget {
  final AnimationParameters a;
  final AnimationParameters b;
  final Widget child;
  const _AnimatedAngle(
      {Key? key,
      required Animation animation,
      required this.a,
      required this.child,
      required this.b})
      : super(key: key, listenable: animation);

  double angle(double i) {
    final double difference = b.angle - a.angle;
    return a.angle + i * difference;
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    final double i = animation.value;
    return Transform.rotate(
      alignment: Alignment.center,
      angle: angle(i),
      child: child,
    );
  }
}

/// This is responsible for rotation
/// of objects
class _AnimatedSize extends AnimatedWidget {
  final AnimationParameters a;
  final AnimationParameters b;
  final Widget child;
  _AnimatedSize(
      {Key? key,
      required Animation animation,
      required this.a,
      required this.child,
      required this.b})
      : super(key: key, listenable: animation);

  Vector calcSize(double i) {
    final Vector difference = b.size - a.size;
    return a.size + difference.multiply(i);
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    final double i = animation.value;
    final Vector size = calcSize(i);
    return SizedBox(
      width: ScreenUtil().setWidth(
        size.x,
      ),
      height: ScreenUtil().setHeight(
        size.y,
      ),
      child: child,
    );
  }
}
