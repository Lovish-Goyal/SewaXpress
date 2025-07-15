// Booking model class
class Booking {
  final String id;
  final String serviceName;
  final String providerName;
  final String date;
  final String time;
  final String status;
  final String price;
  final String address;

  Booking({
    required this.id,
    required this.serviceName,
    required this.providerName,
    required this.date,
    required this.time,
    required this.status,
    required this.price,
    required this.address,
  });
}
