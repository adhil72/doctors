import 'package:Doctors/models/booking.dart';
import 'package:Doctors/models/doctor.dart';
import 'package:Doctors/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorDetailScreen extends StatelessWidget {
  const DoctorDetailScreen({
    super.key,
    required this.doctor,
    required this.distanceKm,
  });

  final Doctor doctor;
  final double distanceKm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: colorFromHex("#0D1B34")),
        title: Text(
          'Doctor Detail',
          style: GoogleFonts.poppins(
            color: colorFromHex("#0D1B34"),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 56,
                backgroundImage: AssetImage(doctor.imagePath),
              ),
              const SizedBox(height: 16),
              Text(
                doctor.name,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: colorFromHex("#0D1B34"),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                doctor.specialty,
                style: GoogleFonts.poppins(
                  color: colorFromHex("#8696BB"),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              _InfoRow(
                icon: Icons.star_rounded,
                label: 'Rating',
                value: '${doctor.rating.toStringAsFixed(1)} (${doctor.reviewCount} Reviews)',
                color: colorFromHex("#FEB052"),
              ),
              _InfoRow(
                icon: Icons.access_time_rounded,
                label: 'Opens at',
                value: doctor.openAt,
                color: colorFromHex("#4894FE"),
              ),
              _InfoRow(
                icon: Icons.location_on_outlined,
                label: 'Distance',
                value: '${distanceKm.toStringAsFixed(1)} KM away',
                color: colorFromHex("#8696BB"),
              ),
              const SizedBox(height: 12),
              ValueListenableBuilder<List<Doctor>>(
                valueListenable: bookedDoctors,
                builder: (context, _, _) {
                  final booked = isBooked(doctor);
                  return SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: booked
                          ? null
                          : () {
                              bookDoctor(doctor);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Booked ${doctor.name}')),
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorFromHex("#4894FE"),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        booked ? 'Booked' : 'Book appointment',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Text(
            label,
            style: GoogleFonts.poppins(color: color, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: GoogleFonts.poppins(color: colorFromHex("#0D1B34")),
            ),
          ),
        ],
      ),
    );
  }
}
