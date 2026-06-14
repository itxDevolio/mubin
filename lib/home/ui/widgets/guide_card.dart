import 'package:auraq/core/app_colors.dart';
import 'package:auraq/core/services/dark_&_light_theme.dart';
import 'package:auraq/core/services/haptic_feedback.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoGuideCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String imageUrl;
  final VoidCallback onTap;

  const InfoGuideCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isDark = themeDark(context);

    const double componentHeight = 105.0;

    // 🔥 Fix: UnconstrainedBox lagaya taake ListView card ko niche ki taraf zardasti stretch na kare
    return UnconstrainedBox(
      alignment: Alignment.topCenter, // Card ko top par align rakhega
      child: GestureDetector(
        onTap: () {
          hapticFeedBack();
          onTap();
        },
        child: Container(
          width: screenWidth * 0.82,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: isDark ? Colors.black54 : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.08)
                  : Colors.black.withOpacity(0.05),
            ),
            boxShadow: isDark
                ? []
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // Sirf utna size lo jitna maal andar hai
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. IMAGE SECTION
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
                child: Image.network(
                  imageUrl,
                  height: componentHeight,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: componentHeight,
                      color: isDark ? Colors.grey[800] : Colors.grey[200],
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 20,
                        ),
                      ),
                    );
                  },
                ),
              ),

              // 2. TEXT CONTENT SECTION (Neeche se padding tight)
              Padding(
                // bottom padding ko mazeed tight (6.0) kar diya taake ganda space bilkul bache hi na
                padding: const EdgeInsets.only(
                  left: 12.0,
                  right: 12.0,
                  top: 8.0,
                  bottom: 6.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TITLE
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 13.5,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 1),

                    // SUBTITLE
                    Text(
                      subTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w400,
                        color: isDark ? Colors.white60 : Colors.black54,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
