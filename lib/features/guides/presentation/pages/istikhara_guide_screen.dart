import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/settings_controller.dart';
import '../../../../core/services/ad_helper.dart';
import '../widgets/guide_step_widget.dart';
import '../../data/models/istikhara_data.dart';
import '../../../../core/widgets/ad_banner_widget.dart';

class IstikharaGuideScreen extends ConsumerStatefulWidget {
  const IstikharaGuideScreen({super.key});

  @override
  ConsumerState<IstikharaGuideScreen> createState() => _IstikharaGuideScreenState();
}

class _IstikharaGuideScreenState extends ConsumerState<IstikharaGuideScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AdHelper.maybeShowGuideAd(
        context,
        onContinue: () {},
        onSkip: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settings = ref.watch(settingsControllerProvider);
    final isUrdu = settings.language == 'ur';
    final isPashto = settings.language == 'ps';
    final isRtl = isUrdu || isPashto;
    final String fontFamily = isPashto ? 'Amiri' : (isUrdu ? 'NotoNastaliqUrdu' : 'Poppins');
    final textDirection = isRtl ? TextDirection.rtl : TextDirection.ltr;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          isUrdu
              ? "استخارہ کا طریقہ"
              : (isPashto ? "د استخارې لمانځه طريقه" : "Istikhara Prayer Guide"),
          style: TextStyle(
            fontFamily: fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: isRtl ? 16 : 18,
          ),
        ),
      ),
      body: Directionality(
        textDirection: textDirection,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          itemCount: IstikharaData.getSteps().length + 1,
          itemBuilder: (context, index) {
            final steps = IstikharaData.getSteps();
            if (index == steps.length) {
              return const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: AdBannerWidget(),
              );
            }
            return GuideStepWidget(step: steps[index], isUrdu: isUrdu);
          },
        ),
      ),
    );
  }
}
