import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends ConsumerStatefulWidget {
  const ContactUsScreen({super.key});

  @override
  ConsumerState<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends ConsumerState<ContactUsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      'संपर्क करें / Contact Us',
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

                          // Contact Information Cards
                          _buildContactInfo(isTablet),

                          SizedBox(height: isTablet ? 40 : 30),

                          // Contact Form
                          _buildContactForm(isTablet),

                          SizedBox(height: isTablet ? 40 : 30),

                          // Social Media Links
                          _buildSocialMedia(isTablet),
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

  Widget _buildContactInfo(bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'संपर्क विवरण / Contact Details',
          style: TextStyle(
            fontSize: isTablet ? 24 : 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: isTablet ? 20 : 15),

        // Phone Card
        _buildContactCard(
          icon: Icons.phone,
          title: 'फोन / Phone',
          subtitle: '+91 98765 43210',
          onTap: () => _launchPhone('+919876543210'),
          isTablet: isTablet,
        ),

        SizedBox(height: isTablet ? 15 : 12),

        // Email Card
        _buildContactCard(
          icon: Icons.email,
          title: 'ईमेल / Email',
          subtitle: 'support@sewaxpress.com',
          onTap: () => _launchEmail('support@sewaxpress.com'),
          isTablet: isTablet,
        ),

        SizedBox(height: isTablet ? 15 : 12),

        // Address Card
        _buildContactCard(
          icon: Icons.location_on,
          title: 'पता / Address',
          subtitle: 'Civil Lines, Ludhiana, Punjab 141001',
          onTap: () => _launchMaps('Civil Lines, Ludhiana, Punjab 141001'),
          isTablet: isTablet,
        ),

        SizedBox(height: isTablet ? 15 : 12),

        // Working Hours Card
        _buildContactCard(
          icon: Icons.access_time,
          title: 'कार्य समय / Working Hours',
          subtitle: 'सोमवार - शनिवार: 9:00 AM - 8:00 PM',
          onTap: null,
          isTablet: isTablet,
        ),
      ],
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback? onTap,
    required bool isTablet,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isTablet ? 20 : 15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: isTablet ? 15 : 10,
            offset: Offset(0, isTablet ? 5 : 3),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: EdgeInsets.all(isTablet ? 12 : 10),
          decoration: BoxDecoration(
            color: const Color(0xFF1976D2).withOpacity(0.1),
            borderRadius: BorderRadius.circular(isTablet ? 12 : 10),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF1976D2),
            size: isTablet ? 24 : 20,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: isTablet ? 16 : 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: isTablet ? 14 : 12,
            color: Colors.grey[600],
          ),
        ),
        trailing: onTap != null
            ? Icon(
                Icons.arrow_forward_ios,
                size: isTablet ? 16 : 14,
                color: Colors.grey[400],
              )
            : null,
        contentPadding: EdgeInsets.symmetric(
          horizontal: isTablet ? 20 : 16,
          vertical: isTablet ? 16 : 12,
        ),
      ),
    );
  }

  Widget _buildContactForm(bool isTablet) {
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
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'हमें संदेश भेजें / Send us a Message',
              style: TextStyle(
                fontSize: isTablet ? 20 : 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: isTablet ? 25 : 20),

            // Name Field
            _buildFormField(
              controller: _nameController,
              label: 'नाम / Name',
              icon: Icons.person_outline,
              isTablet: isTablet,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'कृपया अपना नाम दर्ज करें';
                }
                return null;
              },
            ),

            SizedBox(height: isTablet ? 20 : 15),

            // Email Field
            _buildFormField(
              controller: _emailController,
              label: 'ईमेल / Email',
              icon: Icons.email_outlined,
              isTablet: isTablet,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'कृपया अपना ईमेल दर्ज करें';
                }
                if (!value.contains('@')) {
                  return 'कृपया वैध ईमेल दर्ज करें';
                }
                return null;
              },
            ),

            SizedBox(height: isTablet ? 20 : 15),

            // Message Field
            _buildFormField(
              controller: _messageController,
              label: 'संदेश / Message',
              icon: Icons.message_outlined,
              isTablet: isTablet,
              maxLines: 4,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'कृपया अपना संदेश दर्ज करें';
                }
                return null;
              },
            ),

            SizedBox(height: isTablet ? 30 : 25),

            // Send Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _sendMessage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1976D2),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: isTablet ? 18 : 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(isTablet ? 15 : 12),
                  ),
                ),
                child: Text(
                  'संदेश भेजें / Send Message',
                  style: TextStyle(
                    fontSize: isTablet ? 18 : 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool isTablet,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTablet ? 16 : 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: isTablet ? 8 : 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          style: TextStyle(fontSize: isTablet ? 16 : 14),
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: const Color(0xFF1976D2),
              size: isTablet ? 22 : 20,
            ),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(isTablet ? 12 : 10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(isTablet ? 12 : 10),
              borderSide: const BorderSide(color: Color(0xFF1976D2), width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: isTablet ? 16 : 14,
              vertical: isTablet ? 16 : 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialMedia(bool isTablet) {
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
          Text(
            'सोशल मीडिया / Follow Us',
            style: TextStyle(
              fontSize: isTablet ? 20 : 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: isTablet ? 20 : 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSocialButton(
                icon: Icons.facebook,
                color: Colors.blue[600]!,
                onTap: () => _launchUrl('https://facebook.com/sewaxpress'),
                isTablet: isTablet,
              ),
              _buildSocialButton(
                icon: Icons.camera_alt,
                color: Colors.purple[400]!,
                onTap: () => _launchUrl('https://instagram.com/sewaxpress'),
                isTablet: isTablet,
              ),
              _buildSocialButton(
                icon: Icons.alternate_email,
                color: Colors.blue[400]!,
                onTap: () => _launchUrl('https://twitter.com/sewaxpress'),
                isTablet: isTablet,
              ),
              _buildSocialButton(
                icon: Icons.video_library,
                color: Colors.red[600]!,
                onTap: () => _launchUrl('https://youtube.com/sewaxpress'),
                isTablet: isTablet,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    required bool isTablet,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(isTablet ? 16 : 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(isTablet ? 15 : 12),
        ),
        child: Icon(icon, color: color, size: isTablet ? 28 : 24),
      ),
    );
  }

  void _sendMessage() {
    if (_formKey.currentState!.validate()) {
      // Handle message sending logic here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('संदेश भेजा गया! / Message sent!'),
          backgroundColor: Colors.green,
        ),
      );
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  Future<void> _launchPhone(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch phone dialer';
    }
  }

  Future<void> _launchEmail(String email) async {
    final Uri launchUri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch email app';
    }
  }

  Future<void> _launchMaps(String address) async {
    final Uri launchUri = Uri.parse(
      'geo:0,0?q=${Uri.encodeComponent(address)}',
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch maps';
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch URL';
    }
  }
}
