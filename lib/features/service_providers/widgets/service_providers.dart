import 'package:flutter/material.dart';
import 'package:sewaxpress/features/services/models/service_model.dart';

// Model for Service Provider
class ServiceProvider {
  final String id;
  final String name;
  final double rating;
  final int reviewCount;
  final String image;
  final String experience;
  final double price;
  final String priceUnit;
  final bool isVerified;
  final String distance;
  final List<String> specialties;
  final bool isAvailable;

  ServiceProvider({
    required this.id,
    required this.name,
    required this.rating,
    required this.reviewCount,
    required this.image,
    required this.experience,
    required this.price,
    required this.priceUnit,
    required this.isVerified,
    required this.distance,
    required this.specialties,
    required this.isAvailable,
  });
}

class ServiceProvidersScreen extends StatefulWidget {
  final Service service;

  const ServiceProvidersScreen({super.key, required this.service});

  @override
  _ServiceProvidersScreenState createState() => _ServiceProvidersScreenState();
}

class _ServiceProvidersScreenState extends State<ServiceProvidersScreen> {
  String selectedFilter = 'सभी';
  String searchQuery = '';
  TextEditingController searchController = TextEditingController();

  final List<String> filters = [
    'सभी',
    'टॉप रेटेड',
    'कम कीमत',
    'ज्यादा कीमत',
    'नजदीकी',
    'अनुभवी',
  ];

  // Sample service providers data
  List<ServiceProvider> serviceProviders = [
    ServiceProvider(
      id: '1',
      name: 'राजेश कुमार',
      rating: 4.8,
      reviewCount: 245,
      image: 'assets/images/provider1.jpg',
      experience: '5 साल',
      price: 500,
      priceUnit: 'प्रति घंटा',
      isVerified: true,
      distance: '0.5 किमी',
      specialties: ['घरेलू मरम्मत', 'इलेक्ट्रिकल'],
      isAvailable: true,
    ),
    ServiceProvider(
      id: '2',
      name: 'सुरेश शर्मा',
      rating: 4.6,
      reviewCount: 189,
      image: 'assets/images/provider2.jpg',
      experience: '8 साल',
      price: 400,
      priceUnit: 'प्रति घंटा',
      isVerified: true,
      distance: '1.2 किमी',
      specialties: ['पाइपलाइन', 'वाटर हीटर'],
      isAvailable: false,
    ),
    ServiceProvider(
      id: '3',
      name: 'मनोज वर्मा',
      rating: 4.9,
      reviewCount: 312,
      image: 'assets/images/provider3.jpg',
      experience: '10 साल',
      price: 600,
      priceUnit: 'प्रति घंटा',
      isVerified: true,
      distance: '2.1 किमी',
      specialties: ['सभी प्रकार की मरम्मत'],
      isAvailable: true,
    ),
    ServiceProvider(
      id: '4',
      name: 'अमित सिंह',
      rating: 4.3,
      reviewCount: 156,
      image: 'assets/images/provider4.jpg',
      experience: '3 साल',
      price: 350,
      priceUnit: 'प्रति घंटा',
      isVerified: false,
      distance: '0.8 किमी',
      specialties: ['मरम्मत', 'रखरखाव'],
      isAvailable: true,
    ),
    ServiceProvider(
      id: '5',
      name: 'विकास गुप्ता',
      rating: 4.7,
      reviewCount: 203,
      image: 'assets/images/provider5.jpg',
      experience: '6 साल',
      price: 550,
      priceUnit: 'प्रति घंटा',
      isVerified: true,
      distance: '1.5 किमी',
      specialties: ['इमरजेंसी सर्विस'],
      isAvailable: true,
    ),
  ];

  List<ServiceProvider> get filteredProviders {
    List<ServiceProvider> filtered = List.from(serviceProviders);

    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((provider) {
        return provider.name.toLowerCase().contains(
              searchQuery.toLowerCase(),
            ) ||
            provider.specialties.any(
              (specialty) =>
                  specialty.toLowerCase().contains(searchQuery.toLowerCase()),
            );
      }).toList();
    }

    // Apply sorting filter
    switch (selectedFilter) {
      case 'टॉप रेटेड':
        filtered.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'कम कीमत':
        filtered.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'ज्यादा कीमत':
        filtered.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'नजदीकी':
        filtered.sort(
          (a, b) => double.parse(
            a.distance.split(' ')[0],
          ).compareTo(double.parse(b.distance.split(' ')[0])),
        );
        break;
      case 'अनुभवी':
        filtered.sort(
          (a, b) => int.parse(
            b.experience.split(' ')[0],
          ).compareTo(int.parse(a.experience.split(' ')[0])),
        );
        break;
      default:
        // No sorting for 'सभी'
        break;
    }

    return filtered;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Color(0xFF1976D2),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.service.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Filter Section
          Container(
            height: 60,
            margin: EdgeInsets.symmetric(vertical: 4),
            color: Colors.white,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];
                final isSelected = selectedFilter == filter;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedFilter = filter;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 12),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xFF1976D2) : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? Color(0xFF1976D2)
                            : Colors.grey[300]!,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        filter,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[700],
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Search Section
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'सर्विस प्रोवाइडर का नाम खोजें...',
                hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: Colors.grey[600]),
                        onPressed: () {
                          searchController.clear();
                          setState(() {
                            searchQuery = '';
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xFF1976D2), width: 2),
                ),
              ),
            ),
          ),

          // Results Count
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  '${filteredProviders.length} सर्विस प्रोवाइडर मिले',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Providers List
          Expanded(
            child: filteredProviders.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'कोई सर्विस प्रोवाइडर नहीं मिला',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'कृपया अपना खोज शब्द बदलें या फिल्टर साफ़ करें',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: filteredProviders.length,
                    itemBuilder: (context, index) {
                      final provider = filteredProviders[index];
                      return ServiceProviderCard(provider: provider);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class ServiceProviderCard extends StatelessWidget {
  final ServiceProvider provider;

  const ServiceProviderCard({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Navigate to provider details
          },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    // Provider Image
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.grey[600],
                      ),
                    ),

                    SizedBox(width: 16),

                    // Provider Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                provider.name,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(width: 8),
                              if (provider.isVerified)
                                Icon(
                                  Icons.verified,
                                  color: Color(0xFF1976D2),
                                  size: 18,
                                ),
                            ],
                          ),

                          SizedBox(height: 4),

                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 16),
                              SizedBox(width: 4),
                              Text(
                                '${provider.rating}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(width: 4),
                              Text(
                                '(${provider.reviewCount} रिव्यू)',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 4),

                          Row(
                            children: [
                              Icon(
                                Icons.work,
                                color: Colors.grey[600],
                                size: 14,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'अनुभव: ${provider.experience}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),

                              // SizedBox(width: 16),
                            ],
                          ),
                          Icon(
                            Icons.location_on,
                            color: Colors.grey[600],
                            size: 14,
                          ),
                          SizedBox(width: 4),
                          Text(
                            provider.distance,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Price & Availability
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '₹${provider.price}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1976D2),
                          ),
                        ),
                        Text(
                          provider.priceUnit,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 4),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: provider.isAvailable
                                ? Colors.green[100]
                                : Colors.red[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            provider.isAvailable ? 'उपलब्ध' : 'व्यस्त',
                            style: TextStyle(
                              fontSize: 10,
                              color: provider.isAvailable
                                  ? Colors.green[700]
                                  : Colors.red[700],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 12),

                // Specialties
                Wrap(
                  spacing: 8,
                  children: provider.specialties.map((specialty) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        specialty,
                        style: TextStyle(fontSize: 10, color: Colors.grey[700]),
                      ),
                    );
                  }).toList(),
                ),

                SizedBox(height: 12),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // Call functionality
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xFF1976D2)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.call,
                              color: Color(0xFF1976D2),
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'कॉल करें',
                              style: TextStyle(
                                color: Color(0xFF1976D2),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(width: 12),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: provider.isAvailable
                            ? () {
                                // Book service functionality
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1976D2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'बुक करें',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
