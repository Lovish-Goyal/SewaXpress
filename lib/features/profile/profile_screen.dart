import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sewaxpress/features/auth/providers/auth_provider.dart';
import 'package:sewaxpress/features/auth/user_model/user_model.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _isEditing = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userProvider);
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
          child: userAsync.when(
            data: (user) {
              if (user == null) {
                return const Center(
                  child: Text(
                    'कोई उपयोगकर्ता नहीं मिला (No User Found!)',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }

              // Initialize controllers with user data
              if (!_isEditing) {
                _nameController.text = user.name;
                _phoneController.text = user.phone;
              }

              return Column(
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
                        if (!isDesktop)
                          Text(
                            'प्रोफाइल / Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isTablet ? 32 : 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _isEditing = !_isEditing;
                            });
                          },
                          icon: Icon(
                            _isEditing ? Icons.close : Icons.edit,
                            color: Colors.white,
                            size: isTablet ? 28 : 24,
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

                              // Profile Picture
                              _buildProfilePicture(user, isTablet),

                              SizedBox(height: isTablet ? 40 : 30),

                              // Profile Information
                              _buildProfileInfo(user, isTablet, isDesktop),

                              SizedBox(height: isTablet ? 40 : 30),

                              // Action Buttons
                              _buildActionButtons(isTablet, isDesktop),

                              // Logout Button
                              _isEditing
                                  ? SizedBox.shrink()
                                  : _buildLogoutButton(isTablet),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            error: (e, _) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 60,
                    color: Colors.white.withOpacity(0.8),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'त्रुटि: ${e.toString()}',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePicture(dynamic user, bool isTablet) {
    return Stack(
      children: [
        Container(
          width: isTablet ? 140 : 120,
          height: isTablet ? 140 : 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF1976D2).withOpacity(0.8),
                const Color(0xFF1976D2),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Icon(
            Icons.person,
            size: isTablet ? 70 : 60,
            color: Colors.white,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: isTablet ? 40 : 35,
            height: isTablet ? 40 : 35,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Icon(
              Icons.camera_alt,
              size: isTablet ? 20 : 18,
              color: const Color(0xFF1976D2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileInfo(dynamic user, bool isTablet, bool isDesktop) {
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
          _buildInfoField(
            'नाम / Name',
            _nameController,
            Icons.person_outline,
            isTablet,
          ),
          SizedBox(height: isTablet ? 25 : 20),
          _buildInfoField(
            'ईमेल / Email',
            TextEditingController(text: user.email),
            Icons.email_outlined,
            isTablet,
            enabled: false,
          ),
          SizedBox(height: isTablet ? 25 : 20),
          _buildInfoField(
            'फोन / Phone',
            _phoneController,
            Icons.phone_outlined,
            isTablet,
          ),
          SizedBox(height: isTablet ? 25 : 20),
          _buildInfoField(
            'पता / Address',
            _addressController,
            Icons.location_on_outlined,
            isTablet,
            maxLines: 2,
          ),
          SizedBox(height: isTablet ? 25 : 20),
          _buildInfoField(
            'उपयोगकर्ता ID / User ID',
            TextEditingController(text: user.$id),
            Icons.fingerprint,
            isTablet,
            enabled: false,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoField(
    String label,
    TextEditingController controller,
    IconData icon,
    bool isTablet, {
    bool enabled = true,
    int maxLines = 1,
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
        SizedBox(height: isTablet ? 12 : 8),
        TextFormField(
          controller: controller,
          enabled: _isEditing && enabled,
          maxLines: maxLines,
          style: TextStyle(fontSize: isTablet ? 18 : 16, color: Colors.black87),
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              size: isTablet ? 24 : 20,
              color: _isEditing && enabled
                  ? const Color(0xFF1976D2)
                  : Colors.grey[500],
            ),
            filled: true,
            fillColor: _isEditing && enabled
                ? Colors.grey[50]
                : Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(isTablet ? 15 : 12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(isTablet ? 15 : 12),
              borderSide: const BorderSide(color: Color(0xFF1976D2), width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: isTablet ? 20 : 16,
              vertical: isTablet ? 20 : 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(bool isTablet, bool isDesktop) {
    if (!_isEditing) return const SizedBox.shrink();

    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _isEditing = false;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[400],
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: isTablet ? 18 : 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(isTablet ? 15 : 12),
              ),
            ),
            child: Text(
              'रद्द करें',
              style: TextStyle(
                fontSize: isTablet ? 18 : 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(width: isTablet ? 20 : 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              // Handle save profile
              setState(() {
                _isEditing = false;
              });
              try {
                final auth = ref.read(authServiceProvider);
                final user = UserModel(
                  id: "1213242",
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                  username: _nameController.text,
                  phoneNumber: _phoneController.text,
                  address: _addressController.text,
                );
                await auth.updateProfile(user);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('प्रोफाइल सेव की गई'),
                    backgroundColor: Colors.green,
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed with this error: $e'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1976D2),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: isTablet ? 18 : 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(isTablet ? 15 : 12),
              ),
            ),
            child: Text(
              'सेव करें',
              style: TextStyle(
                fontSize: isTablet ? 18 : 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton(bool isTablet) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          _showLogoutDialog();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red[50],
          foregroundColor: Colors.red,
          padding: EdgeInsets.symmetric(vertical: isTablet ? 20 : 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isTablet ? 15 : 12),
            side: BorderSide(color: Colors.red.withOpacity(0.2)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, size: isTablet ? 24 : 20),
            SizedBox(width: isTablet ? 12 : 8),
            Text(
              'Logout (बाहर निकले)',
              style: TextStyle(
                fontSize: isTablet ? 18 : 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
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
              onPressed: () async {
                try {
                  await ref.read(authServiceProvider).logout();
                  ref.invalidate(userProvider);
                  if (context.mounted) {
                    context.go('/');
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Logout failed: $e')),
                    );
                  }
                }
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
