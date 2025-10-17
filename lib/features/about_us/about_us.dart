import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AboutUsScreen extends ConsumerWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isDesktop = screenWidth > 1200;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color(0xFF1976D2), Colors.grey[50]!],
            stops: const [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(isTablet ? 30 : 10),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    Text(
                      'हमारे बारे में / About Us',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isTablet ? 32 : 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Main Content
              Expanded(
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    maxWidth: isDesktop ? 800 : double.infinity,
                  ),
                  margin: isDesktop
                      ? const EdgeInsets.symmetric(horizontal: 24)
                      : EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(isTablet ? 40 : 30),
                      topRight: Radius.circular(isTablet ? 40 : 30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(isTablet ? 40 : 20),
                      child: Column(
                        children: [
                          SizedBox(height: isTablet ? 20 : 10),

                          // Logo/Brand Section
                          _buildBrandSection(isTablet),

                          SizedBox(height: isTablet ? 40 : 30),

                          // Mission Section
                          _buildMissionSection(isTablet),

                          SizedBox(height: isTablet ? 40 : 30),

                          // Services Section
                          _buildServicesSection(isTablet),

                          SizedBox(height: isTablet ? 40 : 30),

                          // Team Section
                          _buildTeamSection(isTablet),

                          SizedBox(height: isTablet ? 40 : 30),

                          // Features Section
                          _buildFeaturesSection(isTablet),

                          SizedBox(height: isTablet ? 40 : 30),

                          // App Info Section
                          _buildAppInfoSection(isTablet),
                        ],
                      ),
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

  Widget _buildBrandSection(bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 30 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isTablet ? 25 : 20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: isTablet ? 20 : 15,
            offset: Offset(0, isTablet ? 10 : 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: isTablet ? 120 : 100,
            height: isTablet ? 120 : 100,
            decoration: BoxDecoration(
              color: const Color(0xFF1976D2),
              borderRadius: BorderRadius.circular(isTablet ? 25 : 20),
            ),
            child: Icon(
              Icons.local_laundry_service,
              size: isTablet ? 60 : 50,
              color: Colors.white,
            ),
          ),
          SizedBox(height: isTablet ? 20 : 15),
          Text(
            'SewaxPress',
            style: TextStyle(
              fontSize: isTablet ? 32 : 28,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1976D2),
            ),
          ),
          SizedBox(height: isTablet ? 10 : 8),
          Text(
            'आपकी सुविधा हमारी प्राथमिकता',
            style: TextStyle(
              fontSize: isTablet ? 16 : 14,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMissionSection(bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 30 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isTablet ? 25 : 20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: isTablet ? 20 : 15,
            offset: Offset(0, isTablet ? 10 : 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.rocket_launch,
                color: const Color(0xFF1976D2),
                size: isTablet ? 28 : 24,
              ),
              SizedBox(width: isTablet ? 12 : 10),
              Text(
                'हमारा मिशन / Our Mission',
                style: TextStyle(
                  fontSize: isTablet ? 22 : 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          SizedBox(height: isTablet ? 20 : 15),
          Text(
            'SewaxPress का मुख्य लक्ष्य आपके घर की सफाई और कपड़ों की धुलाई को आसान बनाना है। हम आधुनिक तकनीक का उपयोग करके सबसे बेहतर और किफायती सेवाएं प्रदान करते हैं।',
            style: TextStyle(
              fontSize: isTablet ? 16 : 14,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
          SizedBox(height: isTablet ? 15 : 12),
          Text(
            'Our mission is to revolutionize laundry and cleaning services by providing convenient, reliable, and eco-friendly solutions right at your doorstep. We believe in saving your time while delivering exceptional quality.',
            style: TextStyle(
              fontSize: isTablet ? 16 : 14,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesSection(bool isTablet) {
    final services = [
      {
        'icon': Icons.local_laundry_service,
        'title': 'कपड़े धोना',
        'subtitle': 'Laundry Service',
        'description': 'Professional washing and cleaning',
      },
      {
        'icon': Icons.iron,
        'title': 'प्रेसिंग',
        'subtitle': 'Ironing Service',
        'description': 'Perfect pressing and finishing',
      },
      {
        'icon': Icons.cleaning_services,
        'title': 'ड्राई क्लीनिंग',
        'subtitle': 'Dry Cleaning',
        'description': 'Specialized fabric care',
      },
      {
        'icon': Icons.home_repair_service,
        'title': 'घर की सफाई',
        'subtitle': 'Home Cleaning',
        'description': 'Complete household cleaning',
      },
    ];

    return Container(
      padding: EdgeInsets.all(isTablet ? 30 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isTablet ? 25 : 20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: isTablet ? 20 : 15,
            offset: Offset(0, isTablet ? 10 : 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.miscellaneous_services,
                color: const Color(0xFF1976D2),
                size: isTablet ? 28 : 24,
              ),
              SizedBox(width: isTablet ? 12 : 10),
              Text(
                'हमारी सेवाएं / Our Services',
                style: TextStyle(
                  fontSize: isTablet ? 22 : 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          SizedBox(height: isTablet ? 25 : 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isTablet ? 2 : 1,
              crossAxisSpacing: isTablet ? 20 : 0,
              mainAxisSpacing: isTablet ? 20 : 15,
              childAspectRatio: isTablet ? 2.5 : 4,
            ),
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];
              return Container(
                padding: EdgeInsets.all(isTablet ? 20 : 15),
                decoration: BoxDecoration(
                  color: const Color(0xFF1976D2).withOpacity(0.05),
                  borderRadius: BorderRadius.circular(isTablet ? 15 : 12),
                  border: Border.all(
                    color: const Color(0xFF1976D2).withOpacity(0.1),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(isTablet ? 12 : 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1976D2).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(isTablet ? 12 : 10),
                      ),
                      child: Icon(
                        service['icon'] as IconData,
                        color: const Color(0xFF1976D2),
                        size: isTablet ? 24 : 20,
                      ),
                    ),
                    SizedBox(width: isTablet ? 15 : 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${service['title']}',
                            style: TextStyle(
                              fontSize: isTablet ? 16 : 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          Text(
                            '${service['subtitle']}',
                            style: TextStyle(
                              fontSize: isTablet ? 14 : 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          if (isTablet)
                            Text(
                              '${service['description']}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTeamSection(bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 30 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isTablet ? 25 : 20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: isTablet ? 20 : 15,
            offset: Offset(0, isTablet ? 10 : 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.group,
                color: const Color(0xFF1976D2),
                size: isTablet ? 28 : 24,
              ),
              SizedBox(width: isTablet ? 12 : 10),
              Text(
                'हमारी टीम / Our Team',
                style: TextStyle(
                  fontSize: isTablet ? 22 : 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          SizedBox(height: isTablet ? 20 : 15),
          Text(
            'हमारी अनुभवी और प्रशिक्षित टीम आपकी सेवा के लिए हमेशा तैयार है। हम गुणवत्ता और समय की पाबंदी को प्राथमिकता देते हैं।',
            style: TextStyle(
              fontSize: isTablet ? 16 : 14,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
          SizedBox(height: isTablet ? 20 : 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatCard('50+', 'कर्मचारी\nEmployees', isTablet),
              _buildStatCard('5+', 'साल अनुभव\nYears Experience', isTablet),
              _buildStatCard('1000+', 'खुश ग्राहक\nHappy Customers', isTablet),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String number, String label, bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 20 : 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1976D2).withOpacity(0.05),
        borderRadius: BorderRadius.circular(isTablet ? 15 : 12),
      ),
      child: Column(
        children: [
          Text(
            number,
            style: TextStyle(
              fontSize: isTablet ? 24 : 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1976D2),
            ),
          ),
          SizedBox(height: isTablet ? 8 : 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isTablet ? 12 : 10,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection(bool isTablet) {
    final features = [
      {
        'icon': Icons.schedule,
        'title': 'समय की पाबंदी',
        'subtitle': 'On-Time Delivery',
      },
      {
        'icon': Icons.eco,
        'title': 'पर्यावरण अनुकूल',
        'subtitle': 'Eco-Friendly',
      },
      {
        'icon': Icons.verified,
        'title': 'गुणवत्ता आश्वासन',
        'subtitle': 'Quality Assured',
      },
      {
        'icon': Icons.support_agent,
        'title': '24/7 सहायता',
        'subtitle': '24/7 Support',
      },
    ];

    return Container(
      padding: EdgeInsets.all(isTablet ? 30 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isTablet ? 25 : 20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: isTablet ? 20 : 15,
            offset: Offset(0, isTablet ? 10 : 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.star,
                color: const Color(0xFF1976D2),
                size: isTablet ? 28 : 24,
              ),
              SizedBox(width: isTablet ? 12 : 10),
              Flexible(
                // or use Expanded
                child: Text(
                  'हमारी विशेषताएं / Our Features',
                  style: TextStyle(
                    fontSize: isTablet ? 22 : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              ),
            ],
          ),
          SizedBox(height: isTablet ? 25 : 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isTablet ? 2 : 1,
              crossAxisSpacing: isTablet ? 20 : 0,
              mainAxisSpacing: isTablet ? 20 : 15,
              childAspectRatio: isTablet ? 3 : 4,
            ),
            itemCount: features.length,
            itemBuilder: (context, index) {
              final feature = features[index];
              return Container(
                padding: EdgeInsets.all(isTablet ? 20 : 15),
                decoration: BoxDecoration(
                  color: const Color(0xFF1976D2).withOpacity(0.05),
                  borderRadius: BorderRadius.circular(isTablet ? 15 : 12),
                  border: Border.all(
                    color: const Color(0xFF1976D2).withOpacity(0.1),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(isTablet ? 12 : 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1976D2).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(isTablet ? 12 : 10),
                      ),
                      child: Icon(
                        feature['icon'] as IconData,
                        color: const Color(0xFF1976D2),
                        size: isTablet ? 24 : 20,
                      ),
                    ),
                    SizedBox(width: isTablet ? 15 : 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${feature['title']}',
                            style: TextStyle(
                              fontSize: isTablet ? 16 : 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          Text(
                            '${feature['subtitle']}',
                            style: TextStyle(
                              fontSize: isTablet ? 14 : 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAppInfoSection(bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 30 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isTablet ? 25 : 20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: isTablet ? 20 : 15,
            offset: Offset(0, isTablet ? 10 : 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: const Color(0xFF1976D2),
                size: isTablet ? 28 : 24,
              ),
              SizedBox(width: isTablet ? 12 : 10),
              Flexible(
                // or use Expanded
                child: Text(
                  'ऐप की जानकारी / App Information',
                  style: TextStyle(
                    fontSize: isTablet ? 22 : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              ),
            ],
          ),
          SizedBox(height: isTablet ? 20 : 15),
          _buildInfoRow('Version', '1.0.0', isTablet),
          _buildInfoRow('Developer', 'SewaxPress Team', isTablet),
          _buildInfoRow('Release Date', 'January 2025', isTablet),
          _buildInfoRow('Platform', 'iOS & Android', isTablet),
          _buildInfoRow('License', 'Proprietary', isTablet),
          SizedBox(height: isTablet ? 20 : 15),
          Container(
            padding: EdgeInsets.all(isTablet ? 20 : 15),
            decoration: BoxDecoration(
              color: const Color(0xFF1976D2).withOpacity(0.05),
              borderRadius: BorderRadius.circular(isTablet ? 15 : 12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: isTablet ? 24 : 20,
                ),
                SizedBox(width: isTablet ? 12 : 10),
                Expanded(
                  child: Text(
                    'लुधियाना में स्थानीय रूप से विकसित और संचालित\nMade with ❤️ in Ludhiana, Punjab',
                    style: TextStyle(
                      fontSize: isTablet ? 14 : 12,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, bool isTablet) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isTablet ? 8 : 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTablet ? 16 : 14,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTablet ? 16 : 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}
