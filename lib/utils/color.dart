import 'dart:ui';

Color colorFromHex(String hex) {
  var value = hex.replaceAll('#', '').replaceAll('0x', '').toUpperCase();
  if (value.length == 6) value = 'FF$value';
  return Color(int.parse(value, radix: 16));
}