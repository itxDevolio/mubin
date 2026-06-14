import 'package:auraq/core/app_colors.dart';
import 'package:auraq/core/services/dark_&_light_theme.dart';
import 'package:auraq/core/services/haptic_feedback.dart';
import 'package:auraq/core/widgets/loading_widget.dart';
import 'package:auraq/home/controllers/prayer_provider.dart';
import 'package:auraq/home/service/hijri_date_service.dart';
import 'package:auraq/home/ui/widgets/prayer_time_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adhan_dart/adhan_dart.dart';

class PrayerCard extends ConsumerWidget {
  final DateTime date;

  const PrayerCard({super.key, required this.date});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prayer = ref.watch(prayerTimesProvider);

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

              // 🔥 PERMANENT FIXED HEADER: Bari screen par corners par rahega, choti screen par icon nahi gayab hoga!
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  // 1. LEFT SIDE GROUP: Icon + Hijri Text (Expanded lagaya taake text icon ko push na kare)
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

                        // 🔥 Expanded + Flexible Text padding safety ke sath
                        Expanded(
                          child: Text(
                            getHijriDate(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis, // Agar screen choti hui to date ke aage ... aa jayega par crash nahi hoga
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: themeDark(context) ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Bari screens par left aur right ke beech thoda munasib gap rakhne ke liye
                  const SizedBox(width: 16),

                  // 2. RIGHT SIDE GROUP: Notification Button (Iska size fixed hai, ye kabhi nahi chhupega)
                  Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.center,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        hapticFeedBack();
                      },
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

              // Horizontal Row of 5 Prayer Cards
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
      error: (e, s) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                e.toString(),
                style: const TextStyle(color: Colors.redAccent),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              TextButton.icon(
                onPressed: () {
                  ref.refresh(prayerTimesProvider);
                },
                label: const Text("Retry"),
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
        );
      },
      loading: () {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: loading(),
          ),
        );
      },
    );
  }
}