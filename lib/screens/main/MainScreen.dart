import 'package:Doctors/models/doctor.dart';
import 'package:Doctors/screens/doctor/BookedDoctorsScreen.dart';
import 'package:Doctors/screens/doctor/DoctorDetailScreen.dart';
import 'package:Doctors/screens/main/componentss/DoctorCard.dart';
import 'package:Doctors/screens/main/componentss/DoctorListCard.dart';
import 'package:Doctors/screens/main/componentss/SearchField.dart';
import 'package:Doctors/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Doctors/screens/main/componentss/AppBar.dart' as AppBar;
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainScreen();
  }
}

class _MainScreen extends State<MainScreen> {
  String name = "Random";

  @override
  Widget build(BuildContext context) {
    final nearby = nearestDoctors(
      sampleDoctors,
      fromLatitude: userLatitude,
      fromLongitude: userLongitude,
    );
    // The blue card at the top shows this doctor.
    final featuredDoctor =
        sampleDoctors.firstWhere((d) => d.name == 'Dr. Imran Syahir');

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: colorFromHex("ffffff")),
          child: CustomScrollView(
            slivers: [
              // Greeting and blue card scroll away.
              SliverPadding(
                padding: const EdgeInsets.only(top: 20, left: 24, right: 24),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      AppBar.AppBar(name: name),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DoctorDetailScreen(
                              doctor: featuredDoctor,
                              distanceKm: featuredDoctor.distanceKmFrom(
                                userLatitude,
                                userLongitude,
                              ),
                            ),
                          ),
                        ),
                        child: DoctorCard(doctor: featuredDoctor),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              // Search field stays pinned at the top.
              SliverPersistentHeader(
                pinned: true,
                delegate: _SearchHeaderDelegate(),
              ),

              // Title and doctor cards scroll under the search bar.
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverList.list(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Near Doctor",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const BookedDoctorsScreen(),
                            ),
                          ),
                          child: const Text("My bookings"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    for (final doctor in nearby)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DoctorDetailScreen(
                                doctor: doctor,
                                distanceKm: doctor.distanceKmFrom(
                                  userLatitude,
                                  userLongitude,
                                ),
                              ),
                            ),
                          ),
                          child: DoctorListCard(
                            doctor: doctor,
                            distanceKm: doctor.distanceKmFrom(
                              userLatitude,
                              userLongitude,
                            ),
                          ),
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

class _SearchHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 76;

  @override
  double get maxExtent => 76;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      // Same colour as the page so list items don't show through.
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      alignment: Alignment.center,
      child: SearchField(),
    );
  }
}
