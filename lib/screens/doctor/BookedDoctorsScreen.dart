import 'package:Doctors/models/booking.dart';
import 'package:Doctors/models/doctor.dart';
import 'package:Doctors/screens/doctor/DoctorDetailScreen.dart';
import 'package:Doctors/screens/main/componentss/DoctorListCard.dart';
import 'package:Doctors/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookedDoctorsScreen extends StatelessWidget {
  const BookedDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: colorFromHex("#0D1B34")),
        title: Text(
          'Booked Doctors',
          style: GoogleFonts.poppins(
            color: colorFromHex("#0D1B34"),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: ValueListenableBuilder<List<Doctor>>(
          valueListenable: bookedDoctors,
          builder: (context, booked, _) {
            if (booked.isEmpty) {
              return Center(
                child: Text(
                  'No booked doctors yet',
                  style: GoogleFonts.poppins(color: colorFromHex("#8696BB")),
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: booked.length,
              itemBuilder: (context, index) {
                final doctor = booked[index];
                final distanceKm = doctor.distanceKmFrom(
                  userLatitude,
                  userLongitude,
                );
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DoctorDetailScreen(
                          doctor: doctor,
                          distanceKm: distanceKm,
                        ),
                      ),
                    ),
                    child: DoctorListCard(
                      doctor: doctor,
                      distanceKm: distanceKm,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
