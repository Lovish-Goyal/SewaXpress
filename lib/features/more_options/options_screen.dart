import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sewaxpress/features/auth/providers/auth_provider.dart';

class OptionsScreen extends ConsumerStatefulWidget {
  const OptionsScreen({super.key});

  @override
  ConsumerState<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends ConsumerState<OptionsScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isDesktop = screenWidth > 1200;

    // Calculate grid columns based on screen size
    int crossAxisCount = isDesktop ? 4 : (isTablet ? 3 : 2);

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
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                  children: [
                    SizedBox(width: isTablet ? 16 : 12),
                    Text(
                      'सभी विकल्प / All Options',
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
                    maxWidth: isDesktop ? 1200 : double.infinity,
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

                          // Search Bar
                          _buildSearchBar(isTablet),

                          SizedBox(height: isTablet ? 30 : 20),

                          _buildCategorySection(
                            _getHelpOptions(),
                            crossAxisCount,
                            isTablet,
                          ),

                          SizedBox(height: isTablet ? 30 : 20),

                          _buildCategorySection(
                            _getAppInfoOptions(),
                            crossAxisCount,
                            isTablet,
                          ),

                          SizedBox(height: isTablet ? 40 : 30),
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

  Widget _buildSearchBar(bool isTablet) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isTablet ? 20 : 16),
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
      child: TextField(
        decoration: InputDecoration(
          hintText: 'खोजें / Search options...',
          hintStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: isTablet ? 16 : 14,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey[600],
            size: isTablet ? 24 : 20,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: isTablet ? 20 : 16),
        ),
        onChanged: (value) {
          // Implement search functionality
        },
      ),
    );
  }

  Widget _buildCategorySection(
    List<OptionItem> options,
    int crossAxisCount,
    bool isTablet,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: isTablet ? 20 : 15,
            mainAxisSpacing: isTablet ? 20 : 15,
            childAspectRatio: 1.1,
          ),
          itemCount: options.length,
          itemBuilder: (context, index) {
            return _buildOptionCard(options[index], isTablet);
          },
        ),
      ],
    );
  }

  Widget _buildOptionCard(OptionItem option, bool isTablet) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isTablet ? 20 : 15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: isTablet ? 15 : 10,
            offset: Offset(0, isTablet ? 8 : 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: option.onTap,
          borderRadius: BorderRadius.circular(isTablet ? 20 : 15),
          child: Padding(
            padding: EdgeInsets.all(isTablet ? 20 : 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(isTablet ? 16 : 12),
                  decoration: BoxDecoration(
                    color: option.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(isTablet ? 15 : 12),
                  ),
                  child: Icon(
                    option.icon,
                    size: isTablet ? 32 : 28,
                    color: option.color,
                  ),
                ),
                SizedBox(height: isTablet ? 12 : 8),
                Text(
                  option.title,
                  style: TextStyle(
                    fontSize: isTablet ? 14 : 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (option.subtitle != null) ...[
                  SizedBox(height: isTablet ? 4 : 2),
                  Text(
                    option.subtitle!,
                    style: TextStyle(
                      fontSize: isTablet ? 10 : 9,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<OptionItem> _getHelpOptions() {
    return [
      OptionItem(
        title: 'सहायता केंद्र\nProfile',
        icon: Icons.person,
        color: Colors.blue,
        onTap: () {
          context.push('/profile');
        },
      ),
      OptionItem(
        title: 'लाइव चैट\nLive Chat',
        icon: Icons.chat,
        color: Colors.green,
        onTap: () {
          // Navigate to live chat
        },
      ),
      OptionItem(
        title: 'कॉल सपोर्ट\nCall Support',
        icon: Icons.phone,
        color: Colors.orange,
        onTap: () {
          // Make support call
        },
      ),
      OptionItem(
        title: 'FAQ',
        icon: Icons.quiz,
        color: Colors.purple,
        onTap: () {
          // Navigate to FAQ
        },
      ),
      OptionItem(
        title: 'फीडबैक\nFeedback',
        icon: Icons.feedback,
        color: Colors.teal,
        onTap: () {
          // Navigate to feedback
        },
      ),
      OptionItem(
        title: 'समस्या रिपोर्ट\nReport Issue',
        icon: Icons.report_problem,
        color: Colors.red,
        onTap: () {
          // Navigate to report issue
        },
      ),
    ];
  }

  List<OptionItem> _getAppInfoOptions() {
    return [
      OptionItem(
        title: 'ऐप के बारे में\nAbout App',
        icon: Icons.info,
        color: Colors.blue,
        onTap: () {
          context.push('/about');
        },
      ),
      OptionItem(
        title: 'नियम और शर्तें\nTerms & Conditions',
        icon: Icons.description,
        color: Colors.brown,
        onTap: () {
          // Navigate to terms
        },
      ),
      OptionItem(
        title: 'गोपनीयता नीति\nPrivacy Policy',
        icon: Icons.policy,
        color: Colors.green,
        onTap: () {
          // Navigate to privacy policy
        },
      ),
      OptionItem(
        title: 'ऐप रेट करें\nRate App',
        icon: Icons.star_rate,
        color: Colors.amber,
        onTap: () {
          // Navigate to rate app
        },
      ),
      OptionItem(
        title: 'साझा करें\nShare App',
        icon: Icons.share,
        color: Colors.indigo,
        onTap: () {
          // Share app
        },
      ),
      OptionItem(
        title: 'लॉग आउट\nLogout',
        icon: Icons.logout,
        color: Colors.red,
        onTap: () {
          _showLogoutDialog();
        },
      ),
    ];
  }

  void _showLogoutDialog() {
    final isTablet = MediaQuery.of(context).size.width > 600;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isTablet ? 20 : 15),
          ),
          title: Text(
            'लॉग आउट करें?',
            style: TextStyle(
              fontSize: isTablet ? 22 : 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'क्या आप वाकई लॉग आउट करना चाहते हैं?',
            style: TextStyle(
              fontSize: isTablet ? 16 : 14,
              color: Colors.grey[700],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'रद्द करें',
                style: TextStyle(
                  fontSize: isTablet ? 16 : 14,
                  color: Colors.grey[600],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context); // Go back to previous screen
                // Handle logout
                ref.read(authServiceProvider).logout();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(isTablet ? 10 : 8),
                ),
              ),
              child: Text(
                'लॉग आउट',
                style: TextStyle(
                  fontSize: isTablet ? 16 : 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class OptionItem {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  OptionItem({
    required this.title,
    this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}
