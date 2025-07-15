import 'package:flutter/material.dart';
import 'models/booking_model.dart';
import 'widgets/booking_card.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  BookingScreenState createState() => BookingScreenState();
}

class BookingScreenState extends State<BookingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Booking> activeBookings = [
    Booking(
      id: 'B001',
      serviceName: 'नल की मरम्मत',
      providerName: 'राजेश कुमार',
      date: '15 जुलाई, 2025',
      time: '10:00 AM',
      status: 'Confirmed',
      price: '₹500',
      address: 'गली नं. 5, मॉडल टाउन, लुधियाना',
    ),
    Booking(
      id: 'B002',
      serviceName: 'सफाई सेवा',
      providerName: 'विकास शर्मा',
      date: '16 जुलाई, 2025',
      time: '2:00 PM',
      status: 'In Progress',
      price: '₹300',
      address: 'फ्लैट 201, रॉयल रेजिडेंसी, लुधियाना',
    ),
  ];

  final List<Booking> completedBookings = [
    Booking(
      id: 'B003',
      serviceName: 'बिजली का काम',
      providerName: 'सुरेश सिंह',
      date: '10 जुलाई, 2025',
      time: '3:00 PM',
      status: 'Completed',
      price: '₹600',
      address: 'हाउस नं. 45, सिविल लाइन्स, लुधियाना',
    ),
    Booking(
      id: 'B004',
      serviceName: 'AC मरम्मत',
      providerName: 'अमित गुप्ता',
      date: '8 जुलाई, 2025',
      time: '11:00 AM',
      status: 'Completed',
      price: '₹800',
      address: 'ऑफिस 12, व्यापार भवन, लुधियाना',
    ),
  ];

  final List<Booking> cancelledBookings = [
    Booking(
      id: 'B005',
      serviceName: 'पेंटिंग',
      providerName: 'मनोज कुमार',
      date: '5 जुलाई, 2025',
      time: '9:00 AM',
      status: 'Cancelled',
      price: '₹1200',
      address: 'हाउस नं. 23, न्यू कॉलोनी, लुधियाना',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1976D2), Colors.grey[50]!],
            stops: [0.0, 0.25],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text(
                      'बुकिंग / Bookings',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        Icons.calendar_today,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),

              // Main Content
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),

                      // Tab Bar
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: TabBar(
                          controller: _tabController,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                            color: Color(0xFF1976D2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.grey[600],
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          tabs: [
                            Tab(text: 'सक्रिय'),
                            Tab(text: 'पूर्ण'),
                            Tab(text: 'रद्द'),
                          ],
                        ),
                      ),

                      SizedBox(height: 20),

                      // Tab Content
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            // Active Bookings
                            ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              itemCount: activeBookings.length,
                              itemBuilder: (context, index) {
                                return BookingCard(
                                  booking: activeBookings[index],
                                );
                              },
                            ),
                            // Completed Bookings
                            ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              itemCount: completedBookings.length,
                              itemBuilder: (context, index) {
                                return BookingCard(
                                  booking: completedBookings[index],
                                );
                              },
                            ),
                            // Cancelled Bookings
                            ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              itemCount: cancelledBookings.length,
                              itemBuilder: (context, index) {
                                return BookingCard(
                                  booking: cancelledBookings[index],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
