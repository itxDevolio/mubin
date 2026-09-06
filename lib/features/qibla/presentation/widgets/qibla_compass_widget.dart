import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:mubin/core/app_colors.dart';
import '../controller/qibla_controller.dart';

class QiblaCompassWidget extends ConsumerWidget {
  const QiblaCompassWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qiblaState = ref.watch(qiblaProvider);
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Dynamic sizing with a minimum threshold and maximum cap
        final availableHeight = constraints.maxHeight;
        final availableWidth = constraints.maxWidth;
        final size = min(
          min(availableWidth * 0.8, availableHeight * 0.5),
          280.0,
        );

        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          // Compass shouldn't scroll usually, but this prevents overflow
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: availableHeight),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Minimal Status
                  _buildStatusHeader(qiblaState, theme),
                  const SizedBox(height: 20),

                  // Realistic Minimal Compass
                  SizedBox(
                    width: size + 30,
                    height: size + 30,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Subtle Glow Effect
                        if (qiblaState.isAligned)
                          Container(
                            width: size + 20,
                            height: size + 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.greenAccent.withValues(alpha: 0.15),
                                  blurRadius: 40,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                          ),

                        // Outer Ring
                        Container(
                          width: size + 10,
                          height: size + 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: theme.colorScheme.outlineVariant
                                  .withValues(alpha: 0.1),
                              width: 1,
                            ),
                          ),
                        ),

                        // Rotating Compass Face
                        TweenAnimationBuilder<double>(
                          tween: Tween<double>(
                            begin: 0,
                            end: qiblaState.currentHeading,
                          ),
                          duration: const Duration(milliseconds: 250), // Responsive but smooth
                          curve: Curves.easeOut,
                          builder: (context, heading, child) {
                            return Transform.rotate(
                              angle: (heading * (pi / 180) * -1),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CustomPaint(
                                    size: Size(size, size),
                                    painter: CompassDialPainter(
                                      color: theme.colorScheme.onSurface
                                          .withValues(alpha: 0.1),
                                      tickColor: theme.colorScheme.onSurface
                                          .withValues(alpha: 0.2),
                                    ),
                                  ),
                                  ..._buildCardinalDirections(theme, size),
                                  Transform.rotate(
                                    angle:
                                        qiblaState.qiblaDirection * (pi / 180),
                                    child: Column(
                                      children: [
                                        AnimatedContainer(
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: qiblaState.isAligned
                                                ? Colors.greenAccent.shade700
                                                : theme.colorScheme.onSurface
                                                      .withValues(alpha: 0.8),
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withValues(alpha: 
                                                  0.15,
                                                ),
                                                blurRadius: 8,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: const Icon(
                                            FlutterIslamicIcons.kaaba,
                                            color: Colors.white,
                                            size: 22,
                                          ),
                                        ),
                                        Container(
                                          width: 1.5,
                                          height: size / 2 - 30,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                qiblaState.isAligned
                                                    ? Colors
                                                          .greenAccent
                                                          .shade700
                                                    : theme
                                                          .colorScheme
                                                          .onSurface
                                                          .withValues(alpha: 0.15),
                                                Colors.transparent,
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: size / 2 - 30),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),

                        // FIXED TOP SIGHT
                        Positioned(
                          top: 0,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: 2.5,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: qiblaState.isAligned
                                  ? Colors.greenAccent.shade700
                                  : Colors.redAccent.withValues(alpha: 0.8),
                            ),
                          ),
                        ),

                        // Center Cap
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.onSurface,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: theme.colorScheme.surface,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                  // Precision Readout
                  _buildPrecisionReadout(qiblaState, theme),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusHeader(dynamic state, ThemeData theme) {
    String status = state.isAligned ? "ALIGNED" : "LOCATING";
    Color statusColor = state.isAligned ? Colors.greenAccent.shade700 : AppColors.primaryTeal;
    
    // If accuracy is explicitly low (Android specific values usually 15+)
    if (state.sensorAccuracy != null && state.sensorAccuracy! > 15) {
      status = "CALIBRATE SENSOR";
      statusColor = Colors.orangeAccent;
    }

    return Column(
      children: [
        Text(
          status,
          style: TextStyle(
            fontSize: 11,
            letterSpacing: 4,
            fontWeight: FontWeight.w900,
            color: statusColor,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          state.isAligned ? "Mecca Found" : "Rotate Phone",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w300,
            letterSpacing: -0.5,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildPrecisionReadout(dynamic state, ThemeData theme) {
    final double offset = state.offset;
    final bool turnRight = offset <= 180;
    final double displayDegrees = turnRight ? offset : 360 - offset;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.isAligned ? "0" : displayDegrees.toStringAsFixed(0),
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      height: 1,
                      color: state.isAligned
                          ? Colors.greenAccent.shade700
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    "°",
                    style: TextStyle(
                      fontSize: 20,
                      height: 1.2,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                state.isAligned ? "SUCCESS" : "BEARING",
                style: TextStyle(
                  fontSize: 9,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w900,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                ),
              ),
            ],
          ),
          if (!state.isAligned) ...[
            const SizedBox(width: 24),
            Container(
              width: 1,
              height: 40,
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.2),
            ),
            const SizedBox(width: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  turnRight
                      ? Icons.rotate_right_rounded
                      : Icons.rotate_left_rounded,
                  color: AppColors.primaryTeal,
                  size: 24,
                ),
                Text(
                  "Turn ${turnRight ? 'Right' : 'Left'}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryTeal,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  List<Widget> _buildCardinalDirections(ThemeData theme, double size) {
    return [
      _positionDirection("N", 0, Colors.redAccent, size),
      _positionDirection(
        "E",
        90,
        theme.colorScheme.onSurface.withValues(alpha: 0.5),
        size,
      ),
      _positionDirection(
        "S",
        180,
        theme.colorScheme.onSurface.withValues(alpha: 0.5),
        size,
      ),
      _positionDirection(
        "W",
        270,
        theme.colorScheme.onSurface.withValues(alpha: 0.5),
        size,
      ),
    ];
  }

  Widget _positionDirection(
    String label,
    double degree,
    Color color,
    double size,
  ) {
    return Transform.rotate(
      angle: degree * (pi / 180),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: color,
              ),
            ),
          ),
          SizedBox(height: size - 48),
        ],
      ),
    );
  }
}

class CompassDialPainter extends CustomPainter {
  final Color color;
  final Color tickColor;

  CompassDialPainter({required this.color, required this.tickColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw Main Circle
    final circlePaint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, circlePaint);

    final tickPaint = Paint()
      ..color = tickColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 360; i += 2) {
      double tickLength = 4;
      if (i % 30 == 0) {
        tickLength = 12;
        tickPaint.strokeWidth = 1.5;
      } else if (i % 10 == 0) {
        tickLength = 8;
        tickPaint.strokeWidth = 1;
      } else {
        tickLength = 4;
        tickPaint.strokeWidth = 0.5;
      }

      final angle = i * pi / 180;
      final start = Offset(
        center.dx + (radius - tickLength) * cos(angle),
        center.dy + (radius - tickLength) * sin(angle),
      );
      final end = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
      canvas.drawLine(start, end, tickPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
