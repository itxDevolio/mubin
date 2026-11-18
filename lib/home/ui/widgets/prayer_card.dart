import 'package:mubin/core/app_colors.dart';
import 'package:mubin/core/services/dark_and_light_theme.dart';
import 'package:mubin/core/services/haptic_feedback.dart';
import 'package:mubin/core/widgets/loading_widget.dart';
import 'package:mubin/home/controllers/prayer_provider.dart';
import 'package:mubin/home/service/hijri_date_service.dart';
import 'package:mubin/home/ui/widgets/prayer_time_card.dart';
import 'package:mubin/features/settings/presentation/notification_settings_screen.dart';
import 'package:mubin/core/services/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:adhan_dart/adhan_dart.dart';

class PrayerCard extends ConsumerWidget {
  final DateTime date;

  const PrayerCard({super.key, required this.date});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prayer = ref.watch(prayerTimesProvider(date));
    final settings = ref.watch(settingsControllerProvider);
    final bool isUrdu = settings.language == 'ur';
    final bool isPashto = settings.language == 'ps';
    final bool isRtl = isUrdu || isPashto;

    return prayer.when(
      data: (d) {
        if (d == null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                isUrdu
                    ? "براہِ کرم لوکیشن کی اجازت فراہم کریں۔"
                    : (isPashto
                        ? "مهرباني وکئ د موقعیت (Location) اجازه ورکړئ."
                        : "Please enable location settings."),
                style: TextStyle(
                  fontFamily: isRtl ? 'NotoNastaliqUrdu' : 'Poppins',
                ),
              ),
            ),
          );
        }

        Prayer active = d.currentPrayer(date: date.toLocal());

        final bool isAnyNotificationEnabled =
            settings.notificationsEnabled &&
            (settings.fajrNotification ||
                settings.dhuhrNotification ||
                settings.asrNotification ||
                settings.maghribNotification ||
                settings.ishaNotification ||
                settings.morningAdhkarNotification ||
                settings.eveningAdhkarNotification);

        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: getThemeColor(
              context,
              light: Colors.white,
              dark: Colors.black54,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: getThemeColor(
                context,
                light: Colors.black.withValues(alpha: 0.05),
                dark: Colors.white.withValues(alpha: 0.08),
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      textDirection:
                          isRtl ? TextDirection.rtl : TextDirection.ltr,
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
                            textAlign:
                                isRtl ? TextAlign.right : TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
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
                      onPressed: () {
                        hapticFeedBack();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const NotificationSettingsScreen(),
                          ),
                        );
                      },
                      icon: Icon(
                        isAnyNotificationEnabled
                            ? Icons.notifications_active
                            : Icons.notifications_off,
                        size: 20,
                        color: isAnyNotificationEnabled
                            ? AppColors.primaryTeal
                            : Colors.grey,
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
                textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                children: [
                  PrayerTimeCard(
                    prayerName: isUrdu ? "فجر" : (isPashto ? "سهار" : "Fajr"),
                    prayerTime: d.fajr,
                    activePrayer: active,
                    currentCardPrayer: Prayer.fajr,
                    isRtl: isRtl,
                  ),
                  PrayerTimeCard(
                    prayerName: isUrdu ? "ظہر" : (isPashto ? "ماسپښین" : "Dhuhr"),
                    prayerTime: d.dhuhr,
                    activePrayer: active,
                    currentCardPrayer: Prayer.dhuhr,
                    isRtl: isRtl,
                  ),
                  PrayerTimeCard(
                    prayerName: isUrdu ? "عصر" : (isPashto ? "مازدیګر" : "Asr"),
                    prayerTime: d.asr,
                    activePrayer: active,
                    currentCardPrayer: Prayer.asr,
                    isRtl: isRtl,
                  ),
                  PrayerTimeCard(
                    prayerName: isUrdu ? "مغرب" : (isPashto ? "ماښام" : "Maghrib"),
                    prayerTime: d.maghrib,
                    activePrayer: active,
                    currentCardPrayer: Prayer.maghrib,
                    flexValue: 13,
                    isRtl: isRtl,
                  ),
                  PrayerTimeCard(
                    prayerName: isUrdu ? "عشاء" : (isPashto ? "ماخوستن" : "Isha"),
                    prayerTime: d.isha,
                    activePrayer: active,
                    currentCardPrayer: Prayer.isha,
                    isRtl: isRtl,
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
