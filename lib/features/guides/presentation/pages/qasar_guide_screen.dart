import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/settings_controller.dart';
import '../widgets/guide_step_widget.dart';
import '../../data/models/qasar_data.dart';
import '../../../../core/widgets/ad_banner_widget.dart';

class QasarGuideScreen extends ConsumerWidget {
  const QasarGuideScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final settings = ref.watch(settingsControllerProvider);
    final isUrdu = settings.language == 'ur';

    final steps = QasarData.getSteps();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          isUrdu ? "نمازِ قصر کا طریقہ" : "Qasar Prayer Guide",
          style: isUrdu 
            ? const TextStyle(fontFamily: 'NotoNastaliqUrdu', fontWeight: FontWeight.bold, fontSize: 18)
            : const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        itemCount: steps.length + 1,
        itemBuilder: (context, index) {
          if (index == steps.length) {
            return const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: AdBannerWidget(),
            );
          }
          return GuideStepWidget(step: steps[index], isUrdu: isUrdu);
        },
      ),
    );
  }
}
