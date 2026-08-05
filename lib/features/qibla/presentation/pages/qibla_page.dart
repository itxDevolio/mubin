import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/qibla_compass_widget.dart';
import '../controller/qibla_controller.dart';

class QiblaPage extends ConsumerWidget {
  const QiblaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final qiblaState = ref.watch(qiblaProvider);

    final double offset = qiblaState.offset;
    final bool turnRight = offset <= 180;
    final double displayDegrees = turnRight ? offset : 360 - offset;
    
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          "Qibla Finder",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: theme.iconTheme,
        actions: [
          IconButton(
            onPressed: () => _showCalibrationDialog(context, theme),
            icon: const Icon(Icons.info_outline),
            tooltip: "Calibration Guide",
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: qiblaState.isLoading
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator.adaptive(),
                      const SizedBox(height: 24),
                      Text(
                        "Fetching Precise Location...",
                        style: TextStyle(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                          fontSize: 14,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      // Minimal Dynamic Info Box
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: qiblaState.isAligned 
                              ? Colors.greenAccent.shade700.withOpacity(0.05)
                              : theme.colorScheme.primaryContainer.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              qiblaState.isAligned ? Icons.check_circle_outline : Icons.explore_outlined, 
                              color: qiblaState.isAligned ? Colors.greenAccent.shade700 : theme.colorScheme.primary,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                qiblaState.isAligned 
                                    ? "Perfect alignment achieved."
                                    : "Turn ${displayDegrees.toStringAsFixed(0)}° ${turnRight ? 'right' : 'left'} for precision.",
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Expanded(
                        child: QiblaCompassWidget(),
                      ),
                      // Minimal Footer
                      Opacity(
                        opacity: 0.5,
                        child: Column(
                          children: [
                            const Text(
                              "MECCA COORDINATES",
                              style: TextStyle(letterSpacing: 2, fontSize: 8, fontWeight: FontWeight.w900),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "21.4225° N, 39.8262° E",
                              style: TextStyle(color: theme.colorScheme.onSurface, fontSize: 10, fontFamily: 'monospace'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  void _showCalibrationDialog(BuildContext context, ThemeData theme) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: theme.colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.vibration, size: 48, color: theme.colorScheme.primary),
              const SizedBox(height: 24),
              const Text(
                "Sensor Calibration",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                "To ensure pinpoint accuracy, please move your phone in a 'Figure 8' motion. This helps reset the internal magnetic sensors.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, height: 1.5,),
              ),
              const SizedBox(height: 32),
              Container(
                width: 80,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.primary.withOpacity(0.2), width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(child: Icon(Icons.loop, size: 24)),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Got it"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
