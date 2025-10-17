import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sewaxpress/features/auth/providers/auth_provider.dart';
import 'package:sewaxpress/features/services/models/service_model.dart';
import 'package:sewaxpress/widgets/custom_gridview.dart';
import '../services/widgets/service_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final PageController _pageController = PageController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;

  final List<Service> featuredServices = [
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
      'AC मरम्मत\nAC Repair',
      Icons.ac_unit,
      Colors.cyan[600]!,
      'Quick AC repair & maintenance',
    ),
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

  final List<ServiceProvider> topProviders = [
    ServiceProvider(
      'राजेश कुमार',
      'नल की मरम्मत',
      4.8,
      'Available',
      '₹500/hr',
      'assets/avatar1.jpg',
    ),
    ServiceProvider(
      'सुरेश सिंह',
      'बिजली का काम',
      4.9,
      'Available',
      '₹600/hr',
      'assets/avatar2.jpg',
    ),
    ServiceProvider(
      'विकास शर्मा',
      'सफाई सेवा',
      4.7,
      'Busy',
      '₹300/hr',
      'assets/avatar3.jpg',
    ),
    ServiceProvider(
      'अमित गुप्ता',
      'पेंटिंग',
      4.6,
      'Available',
      '₹400/hr',
      'assets/avatar4.jpg',
    ),
    ServiceProvider(
      'संजय यादव',
      'बढ़ईगीरी',
      4.9,
      'Available',
      '₹800/hr',
      'assets/avatar5.jpg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1976D2), Colors.grey[50]!],
            stops: [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom App Bar
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'नमस्ते! Good Morning',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white70,
                                  size: 16,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'लुधियाना, पंजाब',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.push('/notifications');
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Icon(
                                      Icons.notifications_outlined,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                  ),
                                  Positioned(
                                    right: 8,
                                    top: 8,
                                    child: Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Consumer(
                              builder: (context, ref, child) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                    onPressed: () async {
                                      final user = await ref.read(
                                        userProvider.future,
                                      );

                                      if (user == null && context.mounted) {
                                        context.push('/login');
                                        return;
                                      }

                                      if (context.mounted) {
                                        await context.push('/profile');
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 25),

                    // Search Bar
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
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
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFF1976D2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.tune,
                              color: Colors.white,
                              size: 20,
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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),

                        // Featured Services Carousel
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'विशेष सेवाएं / Featured',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'सभी देखें',
                                  style: TextStyle(
                                    color: Color(0xFF1976D2),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 15),

                        Container(
                          height: 200,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: featuredServices.length,
                            onPageChanged: (index) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              final service = featuredServices[index];
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      service.color,
                                      service.color.withOpacity(0.7),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: service.color.withOpacity(0.3),
                                      blurRadius: 15,
                                      offset: Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      right: -20,
                                      top: -20,
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.1),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(25),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            service.icon,
                                            size: 50,
                                            color: Colors.white,
                                          ),
                                          SizedBox(height: 15),
                                          Text(
                                            service.name,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            service.description,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white.withOpacity(
                                                0.9,
                                              ),
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),

                        SizedBox(height: 15),

                        // Page Indicators
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            featuredServices.length,
                            (index) => AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              height: 8,
                              width: _currentIndex == index ? 24 : 8,
                              decoration: BoxDecoration(
                                color: _currentIndex == index
                                    ? Color(0xFF1976D2)
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 40),

                        // All Services Section
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'सभी सेवाएं / All Services',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: featuredServices.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.8,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 20,
                                  ),
                              itemBuilder: (context, index) {
                                final item = featuredServices[index];
                                return ServiceCard(service: item);
                              },
                            ),
                          ),
                        ),

                        SizedBox(height: 40),

                        // Top Rated Providers
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'टॉप रेटेड / Top Rated',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'सभी देखें',
                                  style: TextStyle(
                                    color: Color(0xFF1976D2),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20),

                        // Providers List
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          itemCount: topProviders.length,
                          itemBuilder: (context, index) {
                            final provider = topProviders[index];
                            return ProviderCard(provider: provider);
                          },
                        ),

                        SizedBox(height: 30),
                      ],
                    ),
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

class ProviderCard extends StatelessWidget {
  final ServiceProvider provider;

  const ProviderCard({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            _showProviderProfile(context, provider);
          },
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.grey[600],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: provider.status == 'Available'
                              ? Colors.green
                              : Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        provider.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        provider.service,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 16),
                          SizedBox(width: 5),
                          Text(
                            '${provider.rating}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(width: 15),
                          Text(
                            provider.price,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1976D2),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: BoxDecoration(
                    color: provider.status == 'Available'
                        ? Colors.green[100]
                        : Colors.red[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    provider.status == 'Available' ? 'उपलब्ध' : 'व्यस्त',
                    style: TextStyle(
                      fontSize: 12,
                      color: provider.status == 'Available'
                          ? Colors.green[700]
                          : Colors.red[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showProviderProfile(BuildContext context, ServiceProvider provider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Profile Header
            Container(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.grey[600],
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: provider.status == 'Available'
                                ? Colors.green
                                : Colors.red,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    provider.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    provider.service,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 20),
                      SizedBox(width: 5),
                      Text(
                        '${provider.rating}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        provider.price,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1976D2),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Action Buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        // Handle call
                      },
                      icon: Icon(Icons.phone),
                      label: Text('कॉल करें'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        // Handle message
                      },
                      icon: Icon(Icons.message),
                      label: Text('मैसेज'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1976D2),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // Additional Details
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Professional service provider with 5+ years of experience. Certified and insured. Available for emergency services.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Services',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 100,
                      child: Center(
                        child: Text(
                          'Service details loading...',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceProvider {
  final String name;
  final String service;
  final double rating;
  final String status;
  final String price;
  final String avatar;

  ServiceProvider(
    this.name,
    this.service,
    this.rating,
    this.status,
    this.price,
    this.avatar,
  );
}
