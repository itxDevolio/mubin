import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/services/settings_controller.dart';
import '../widgets/guide_step_widget.dart';
import '../../data/models/janaza_data.dart';

class JanazaDetailScreen extends ConsumerWidget {
  final bool isAdult;
  const JanazaDetailScreen({super.key, required this.isAdult});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final settings = ref.watch(settingsControllerProvider);
    final isUrdu = settings.language == 'ur';

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            isUrdu
              ? (isAdult ? "نمازِ جنازہ (بالغ)" : "نمازِ جنازہ (نابالغ)")
              : (isAdult ? "Adult Funeral Prayer" : "Child Funeral Prayer"),
            style: isUrdu
              ? GoogleFonts.notoNastaliqUrdu(fontWeight: FontWeight.bold, fontSize: 18)
              : const TextStyle(fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
            indicatorColor: AppColors.primaryTeal,
            indicatorWeight: 3,
            labelColor: AppColors.primaryTeal,
            unselectedLabelColor: Colors.grey.withOpacity(0.6),
            tabs: [
              Tab(
                icon: Icon(
                  isAdult ? FlutterIslamicIcons.muslim : FlutterIslamicIcons.muslim2,
                  size: 28,
                ),
              ),
              Tab(
                icon: Icon(
                  isAdult ? FlutterIslamicIcons.muslimah : FlutterIslamicIcons.muslimah2,
                  size: 28,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _JanazaContent(
              steps: isAdult
                ? JanazaData.getAdultSteps(true, settings.madhab)
                : JanazaData.getChildSteps(true, settings.madhab),
              isUrdu: isUrdu
            ),
            _JanazaContent(
              steps: isAdult
                ? JanazaData.getAdultSteps(false, settings.madhab)
                : JanazaData.getChildSteps(false, settings.madhab),
              isUrdu: isUrdu
            ),
          ],
        ),
      ),
    );
  }
}

class _JanazaContent extends StatelessWidget {
  final List<dynamic> steps;
  final bool isUrdu;
  const _JanazaContent({required this.steps, required this.isUrdu});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      itemCount: steps.length,
      itemBuilder: (context, index) {
        return GuideStepWidget(step: steps[index], isUrdu: isUrdu);
      },
    );
  }
}
