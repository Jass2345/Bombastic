import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class FloatingBombBackground extends StatefulWidget {
  const FloatingBombBackground({required this.child, super.key});

  final Widget child;

  @override
  State<FloatingBombBackground> createState() => _FloatingBombBackgroundState();
}

class _FloatingBombBackgroundState extends State<FloatingBombBackground>
    with SingleTickerProviderStateMixin {
  late final double _size;
  late double _x;
  late double _y;
  late double _vx; // px/ms
  late double _vy;
  late double _rotAngle;
  late final double _rotSpeed; // rad/ms

  double _screenW = 0;
  double _screenH = 0;
  bool _initialized = false;

  late final Ticker _ticker;
  Duration? _lastElapsed;

  @override
  void initState() {
    super.initState();
    final rng = Random();

    _size = 357 + rng.nextDouble() * 63; // 357~420px (기존 대비 -30%)

    // 속도: 35~50px/s → px/ms
    final speed = (35 + rng.nextDouble() * 15) / 1000.0;
    final angle = rng.nextDouble() * 2 * pi;
    _vx = speed * cos(angle);
    _vy = speed * sin(angle);

    _rotAngle = rng.nextDouble() * 2 * pi;
    // 32~48초 1회전
    _rotSpeed = 2 * pi / ((32000 + rng.nextDouble() * 16000));

    _ticker = createTicker(_onTick)..start();
  }

  void _onTick(Duration elapsed) {
    final last = _lastElapsed;
    _lastElapsed = elapsed;
    if (last == null || !_initialized) return;

    final dt = (elapsed - last).inMicroseconds / 1000.0; // ms
    if (dt <= 0) return;

    _rotAngle = (_rotAngle + _rotSpeed * dt) % (2 * pi);

    double nx = _x + _vx * dt;
    double ny = _y + _vy * dt;

    // 상단만 title 영역 침범 방지, 좌우·하단은 화면 밖으로 여유롭게 허용
    final minX = -_size * 0.4;
    final maxX = _screenW + _size * 0.4;
    final minY = _size / 2;
    final maxY = _screenH + _size * 0.4;

    if (nx < minX) { nx = minX; _vx = _vx.abs(); }
    else if (nx > maxX) { nx = maxX; _vx = -_vx.abs(); }
    if (ny < minY) { ny = minY; _vy = _vy.abs(); }
    else if (ny > maxY) { ny = maxY; _vy = -_vy.abs(); }

    setState(() {
      _x = nx;
      _y = ny;
    });
  }

  void _initPosition(double w, double h) {
    if (_initialized) return;
    _screenW = w;
    _screenH = h;
    final rng = Random();
    _x = w * (0.3 + rng.nextDouble() * 0.4);
    _y = h * (0.25 + rng.nextDouble() * 0.35);
    _initialized = true;
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            _screenW = constraints.maxWidth;
            _screenH = constraints.maxHeight;
            _initPosition(_screenW, _screenH);

            if (!_initialized) return const SizedBox.expand();

            return Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                Positioned(
                  left: _x - _size / 2,
                  top: _y - _size / 2,
                  child: Transform.rotate(
                    angle: _rotAngle,
                    child: Opacity(
                      opacity: 0.19,
                      child: ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          Colors.black45,
                          BlendMode.srcATop,
                        ),
                        child: Image.asset(
                          'assets/image/bomb_Image.png',
                          width: _size,
                          height: _size,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        widget.child,
      ],
    );
  }
}
