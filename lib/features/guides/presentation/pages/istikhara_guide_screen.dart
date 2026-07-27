import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/settings_controller.dart';
import '../widgets/guide_step_widget.dart';
import '../../data/models/istikhara_data.dart';

class IstikharaGuideScreen extends ConsumerWidget {
  const IstikharaGuideScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final settings = ref.watch(settingsControllerProvider);
    final isUrdu = settings.language == 'ur';

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          isUrdu ? "استخارہ کا طریقہ" : "Istikhara Prayer Guide",
          style: isUrdu 
            ? const TextStyle(fontFamily: 'NotoNastaliqUrdu', fontWeight: FontWeight.bold, fontSize: 18)
            : const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        itemCount: IstikharaData.getSteps().length,
        itemBuilder: (context, index) {
          final steps = IstikharaData.getSteps();
          return GuideStepWidget(step: steps[index], isUrdu: isUrdu);
        },
      ),
    );
  }
}
