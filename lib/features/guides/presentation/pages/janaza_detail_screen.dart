import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/services/settings_controller.dart';
import '../widgets/guide_step_widget.dart';
import '../../data/models/janaza_data.dart';
import '../../../../core/widgets/ad_banner_widget.dart';

class JanazaDetailScreen extends ConsumerWidget {
  final bool isAdult;
  const JanazaDetailScreen({super.key, required this.isAdult});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final settings = ref.watch(settingsControllerProvider);
    final isUrdu = settings.language == 'ur';
    final isPashto = settings.language == 'ps';
    final isRtl = isUrdu || isPashto;

    final appTitle = isUrdu
        ? (isAdult ? "نمازِ جنازہ (بالغ)" : "نمازِ جنازہ (نابالغ)")
        : (isPashto
            ? (isAdult ? "د جنازې لمونځ (لویان)" : "د جنازې لمونځ (ماشومان)")
            : (isAdult ? "Adult Funeral Prayer" : "Child Funeral Prayer"));

    final manTitle = isUrdu
        ? (isAdult ? "مرد (بالغ)" : "لڑکا (نابالغ)")
        : (isPashto
            ? (isAdult ? "نارینه (لوی)" : "هلک (ماشوم)")
            : (isAdult ? "Man" : "Boy"));

    final womanTitle = isUrdu
        ? (isAdult ? "عورت (بالغہ)" : "لڑکی (نابالغہ)")
        : (isPashto
            ? (isAdult ? "ښځه (لویه)" : "نجلی (ماشومه)")
            : (isAdult ? "Woman" : "Girl"));

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            appTitle,
            style: TextStyle(
              fontFamily: isRtl ? 'NotoNastaliqUrdu' : 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: isRtl ? 16 : 18,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Directionality(
              textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
              child: TabBar(
                indicatorColor: AppColors.primaryTeal,
                indicatorWeight: 3,
                labelColor: AppColors.primaryTeal,
                unselectedLabelColor: Colors.grey.withValues(alpha: 0.6),
                labelStyle: TextStyle(
                  fontFamily: isRtl ? 'NotoNastaliqUrdu' : 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                tabs: [
                  Tab(
                    text: manTitle,
                    icon: Icon(
                      isAdult
                          ? FlutterIslamicIcons.muslim
                          : FlutterIslamicIcons.muslim2,
                      size: 24,
                    ),
                  ),
                  Tab(
                    text: womanTitle,
                    icon: Icon(
                      isAdult
                          ? FlutterIslamicIcons.muslimah
                          : FlutterIslamicIcons.muslimah2,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Directionality(
          textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
          child: TabBarView(
            children: [
              _JanazaContent(
                steps: isAdult
                    ? JanazaData.getAdultSteps(true, settings.madhab)
                    : JanazaData.getChildSteps(true, settings.madhab),
              ),
              _JanazaContent(
                steps: isAdult
                    ? JanazaData.getAdultSteps(false, settings.madhab)
                    : JanazaData.getChildSteps(false, settings.madhab),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _JanazaContent extends StatelessWidget {
  final List<dynamic> steps;
  const _JanazaContent({required this.steps});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
        return GuideStepWidget(step: steps[index]);
      },
    );
  }
}
