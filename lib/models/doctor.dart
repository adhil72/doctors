import 'dart:math' as math;

class Doctor {
  const Doctor({
    required this.name,
    required this.specialty,
    required this.imagePath,
    required this.latitude,
    required this.longitude,
    required this.rating,
    required this.reviewCount,
    required this.openAt,
  });

  final String name;
  final String specialty;
  final String imagePath;
  final double latitude;
  final double longitude;
  final double rating;
  final int reviewCount;
  final String openAt;

  /// Great-circle distance in kilometres (haversine formula).
  double distanceKmFrom(double fromLatitude, double fromLongitude) {
    const earthRadiusKm = 6371.0;
    final dLat = _toRadians(latitude - fromLatitude);
    final dLon = _toRadians(longitude - fromLongitude);
    final a = math.pow(math.sin(dLat / 2), 2) +
        math.cos(_toRadians(fromLatitude)) *
            math.cos(_toRadians(latitude)) *
            math.pow(math.sin(dLon / 2), 2);
    return 2 * earthRadiusKm * math.asin(math.sqrt(a));
  }

  static double _toRadians(double degrees) => degrees * math.pi / 180;
}

/// Mock doctors. Portraits are placeholder images from randomuser.me.
/// Replace with data from a backend when one exists.
const List<Doctor> sampleDoctors = [
  Doctor(
    name: 'Dr. Joseph Brostito',
    specialty: 'Dental Specialist',
    imagePath: 'assets/images/doctor_1.jpg',
    latitude: 3.1412,
    longitude: 101.6865,
    rating: 4.8,
    reviewCount: 120,
    openAt: '17.00',
  ),
  Doctor(
    name: 'Dr. Imran Syahir',
    specialty: 'General Doctor',
    imagePath: 'assets/images/doctor_2.jpg',
    latitude: 3.1478,
    longitude: 101.7011,
    rating: 4.6,
    reviewCount: 86,
    openAt: '09.00',
  ),
  Doctor(
    name: 'Dr. Aisha Rahman',
    specialty: 'Cardiologist',
    imagePath: 'assets/images/doctor_3.jpg',
    latitude: 3.1569,
    longitude: 101.7123,
    rating: 4.9,
    reviewCount: 204,
    openAt: '13.00',
  ),
  Doctor(
    name: 'Dr. Daniel Tan',
    specialty: 'Eye Specialist',
    imagePath: 'assets/images/doctor_4.jpg',
    latitude: 3.1275,
    longitude: 101.6702,
    rating: 4.7,
    reviewCount: 97,
    openAt: '10.00',
  ),
  Doctor(
    name: 'Dr. Nur Iman',
    specialty: 'Pediatrician',
    imagePath: 'assets/images/doctor_5.jpg',
    latitude: 3.1820,
    longitude: 101.7150,
    rating: 4.5,
    reviewCount: 61,
    openAt: '08.30',
  ),
  Doctor(
    name: 'Dr. Lee Wei Ming',
    specialty: 'Dermatologist',
    imagePath: 'assets/images/doctor_6.jpg',
    latitude: 3.1002,
    longitude: 101.6598,
    rating: 4.4,
    reviewCount: 45,
    openAt: '15.00',
  ),
];

/// Placeholder user location until a real location source is added.
const double userLatitude = 3.1390;
const double userLongitude = 101.6869;

/// Returns the [limit] doctors closest to the given point, nearest first.
List<Doctor> nearestDoctors(
  List<Doctor> doctors, {
  required double fromLatitude,
  required double fromLongitude,
  int limit = 5,
}) {
  final sorted = [...doctors]..sort((a, b) =>
      a
          .distanceKmFrom(fromLatitude, fromLongitude)
          .compareTo(b.distanceKmFrom(fromLatitude, fromLongitude)));
  return sorted.take(limit).toList();
}
