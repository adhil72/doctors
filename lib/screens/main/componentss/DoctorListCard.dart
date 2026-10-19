import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Doctors/models/doctor.dart';
import 'package:Doctors/utils/color.dart';

class DoctorListCard extends StatelessWidget {
  const DoctorListCard({super.key, required this.doctor, required this.distanceKm});

  final Doctor doctor;
  final double distanceKm;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A5A75A7),
            offset: Offset(2, 12),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: colorFromHex("#C4C4C4"),
                      backgroundImage: AssetImage(doctor.imagePath),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctor.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              color: colorFromHex("#0D1B34"),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            doctor.specialty,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              color: colorFromHex("#8696BB"),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _Meta(
                icon: Icons.location_on_outlined,
                text: '${distanceKm.toStringAsFixed(1)} KM',
                color: colorFromHex("#8696BB"),
                iconSize: 16,
                fontSize: 14,
                gap: 8,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Divider(height: 1, thickness: 1, color: colorFromHex("#F5F5F5")),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _Pill(
                icon: Icons.star_rounded,
                text: '${doctor.rating.toStringAsFixed(1)} (${doctor.reviewCount} Reviews)',
                color: colorFromHex("#FEB052"),
              ),
              _Pill(
                icon: Icons.access_time_rounded,
                text: 'Open at ${doctor.openAt}',
                color: colorFromHex("#4894FE"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Meta extends StatelessWidget {
  const _Meta({
    required this.icon,
    required this.text,
    required this.color,
    required this.iconSize,
    required this.fontSize,
    required this.gap,
  });

  final IconData icon;
  final String text;
  final Color color;
  final double iconSize;
  final double fontSize;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: iconSize),
        SizedBox(width: gap),
        Flexible(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              color: color,
              fontSize: fontSize,
            ),
          ),
        ),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
    required this.icon,
    required this.text,
    required this.color,
  });

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 6),
          Text(
            text,
            style: GoogleFonts.poppins(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}