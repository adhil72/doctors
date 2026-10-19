import 'package:Doctors/models/doctor.dart';
import 'package:flutter/foundation.dart';

/// Doctors booked in this app session. Kept in memory only, so bookings are
/// lost when the app closes. Replace with a backend call when one exists.
final ValueNotifier<List<Doctor>> bookedDoctors =
    ValueNotifier<List<Doctor>>([]);

bool isBooked(Doctor doctor) {
  return bookedDoctors.value.any((d) => d.name == doctor.name);
}

void bookDoctor(Doctor doctor) {
  if (isBooked(doctor)) return;
  bookedDoctors.value = [...bookedDoctors.value, doctor];
}
