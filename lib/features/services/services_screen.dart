import 'package:flutter/material.dart';
import 'package:sewaxpress/features/services/models/service_model.dart';
import 'package:sewaxpress/features/services/widgets/service_card.dart';
import 'package:sewaxpress/widgets/custom_gridview.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final List<String> categories = [
    'सभी',
    'घरेलू',
    'इलेक्ट्रिकल',
    'पाइपलाइन',
    'मरम्मत',
    'सफाई',
  ];

  final List<Service> allServices = [
    Service(
      'नल की मरम्मत\nPlumbing',
      Icons.plumbing,
      Colors.blue[600]!,
      'Expert plumbers available 24/7',
    ),
    Service(
      'बिजली का काम\nElectrical',
      Icons.electrical_services,
      Colors.orange[600]!,
      'Certified electricians for all needs',
    ),
    Service(
      'सफाई सेवा\nCleaning',
      Icons.cleaning_services,
      Colors.green[600]!,
      'Professional cleaning services',
    ),
    Service(
      'पेंटिंग\nPainting',
      Icons.format_paint,
      Colors.purple[600]!,
      'Interior & exterior painting',
    ),
    Service(
      'बढ़ईगीरी\nCarpentry',
      Icons.handyman,
      Colors.brown[600]!,
      'Furniture & woodwork experts',
    ),
    Service(
      'AC मरम्मत\nAC Repair',
      Icons.ac_unit,
      Colors.cyan[600]!,
      'Quick AC repair & maintenance',
    ),
    Service(
      'कार सर्विस\nCar Service',
      Icons.car_repair,
      Colors.red[600]!,
      'Professional car servicing',
    ),
    Service(
      'बागवानी\nGardening',
      Icons.grass,
      Colors.green[700]!,
      'Garden maintenance & landscaping',
    ),
    Service(
      'पेस्ट कंट्रोल\nPest Control',
      Icons.bug_report,
      Colors.grey[700]!,
      'Safe pest control solutions',
    ),
    Service(
      'मसाज\nMassage',
      Icons.spa,
      Colors.pink[600]!,
      'Professional massage therapy',
    ),
    Service(
      'बाल काटना\nHair Cut',
      Icons.content_cut,
      Colors.indigo[600]!,
      'Home salon services',
    ),
    Service(
      'योग\nYoga',
      Icons.self_improvement,
      Colors.teal[600]!,
      'Personal yoga instructor',
    ),
  ];

  String selectedCategory = 'सभी';

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
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'सेवाएं / Services',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Search Bar
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey[600], size: 24),
                          SizedBox(width: 15),
                          Expanded(
                            child: TextField(
                              style: TextStyle(fontSize: 16),
                              decoration: InputDecoration(
                                hintText: 'सेवा खोजें... / Search services',
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16,
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
                      // Category Tabs
                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            final isSelected = selectedCategory == category;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCategory = category;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 15),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Color(0xFF1976D2)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: isSelected
                                        ? Color(0xFF1976D2)
                                        : Colors.grey[300]!,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 5,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    category,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.grey[700],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 20),

                      Expanded(
                        child: CustomGridView(
                          list: allServices,
                          itemBuilder: (item) => ServiceCard(service: item),
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
