import 'package:flutter/material.dart';

import '../models/booking_model.dart';

class BookingCard extends StatelessWidget {
  final Booking booking;

  const BookingCard({Key? key, required this.booking}) : super(key: key);

  Color _getStatusColor() {
    switch (booking.status) {
      case 'Confirmed':
        return Colors.green;
      case 'In Progress':
        return Colors.orange;
      case 'Completed':
        return Colors.blue;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    booking.serviceName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor().withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    booking.status,
                    style: TextStyle(
                      color: _getStatusColor(),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.person, size: 16, color: Colors.grey[600]),
                SizedBox(width: 8),
                Text(
                  booking.providerName,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                SizedBox(width: 8),
                Text(
                  '${booking.date} • ${booking.time}',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    booking.address,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  booking.price,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1976D2),
                  ),
                ),
                Row(
                  children: [
                    if (booking.status == 'Confirmed')
                      TextButton(
                        onPressed: () {
                          // Handle cancel booking
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    if (booking.status == 'Completed')
                      TextButton(
                        onPressed: () {
                          // Handle rating
                        },
                        child: Text(
                          'Rate',
                          style: TextStyle(color: Color(0xFF1976D2)),
                        ),
                      ),
                    TextButton(
                      onPressed: () {
                        // Handle view details
                      },
                      child: Text(
                        'Details',
                        style: TextStyle(color: Color(0xFF1976D2)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
