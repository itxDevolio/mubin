import 'package:auraq/core/app_colors.dart';
import 'package:auraq/core/services/dark_and_light_theme.dart';
import 'package:auraq/core/services/haptic_feedback.dart';
import 'package:auraq/core/widgets/loading_widget.dart';
import 'package:auraq/home/controllers/prayer_provider.dart';
import 'package:auraq/home/service/hijri_date_service.dart';
import 'package:auraq/home/ui/widgets/prayer_time_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adhan_dart/adhan_dart.dart';

class PrayerCard extends ConsumerWidget {
  final DateTime date; // HomeScreen se aane wali live date

  const PrayerCard({super.key, required this.date});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 🔥 Dynamic date parameter provider ko pass kiya taake cache refresh sync ho sake
    final prayer = ref.watch(prayerTimesProvider(date));

    return prayer.when(
      data: (d) {
        if (d == null) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("Please enable location settings."),
            ),
          );
        }

        Prayer active = d.currentPrayer(date: date.toLocal());

        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: themeDark(context) ? Colors.black54 : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: themeDark(context)
                  ? Colors.white.withOpacity(0.08)
                  : Colors.black.withOpacity(0.05),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          FlutterIslamicIcons.mosque,
                          size: 18,
                          color: themeDark(context)
                              ? AppColors.primaryTeal
                              : AppColors.success,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            getHijriDate(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: themeDark(context)
                                  ? Colors.white
                                  : Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.center,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => hapticFeedBack(),
                      icon: Icon(
                        Icons.notifications_active,
                        size: 20,
                        color: themeDark(context)
                            ? AppColors.primaryTeal
                            : AppColors.success,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Divider(
                  color: themeDark(context) ? Colors.white10 : Colors.black12,
                  height: 1,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrayerTimeCard(
                    prayerName: "Fajr",
                    prayerTime: d.fajr,
                    activePrayer: active,
                    currentCardPrayer: Prayer.fajr,
                  ),
                  PrayerTimeCard(
                    prayerName: "Dhuhr",
                    prayerTime: d.dhuhr,
                    activePrayer: active,
                    currentCardPrayer: Prayer.dhuhr,
                  ),
                  PrayerTimeCard(
                    prayerName: "Asr",
                    prayerTime: d.asr,
                    activePrayer: active,
                    currentCardPrayer: Prayer.asr,
                  ),
                  PrayerTimeCard(
                    prayerName: "Maghrib",
                    prayerTime: d.maghrib,
                    activePrayer: active,
                    currentCardPrayer: Prayer.maghrib,
                    flexValue: 13,
                  ),
                  PrayerTimeCard(
                    prayerName: "Isha",
                    prayerTime: d.isha,
                    activePrayer: active,
                    currentCardPrayer: Prayer.isha,
                  ),
                ],
              ),
            ],
          ),
        );
      },
      error: (e, s) => Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            e.toString(),
            style: const TextStyle(color: Colors.redAccent),
          ),
        ),
      ),
      loading: () => Center(
        child: Padding(padding: const EdgeInsets.all(24.0), child: loading()),
      ),
    );
  }
}
