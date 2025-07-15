import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/auth_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(30.0),
            child: Column(
              children: [
                // Header
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'नया खाता बनाएं',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 48),
                  ],
                ),

                SizedBox(height: 30),

                // Form Card
                Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Icon(
                          Icons.person_add_alt_1,
                          size: 80,
                          color: Color(0xFF1976D2),
                        ),
                        SizedBox(height: 20),

                        Text(
                          'जुड़िए हमारे साथ',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 30),

                        // Name Field
                        _buildTextField(
                          controller: _nameController,
                          label: 'पूरा नाम / Full Name',
                          icon: Icons.person_outline,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'कृपया नाम डालें';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 20),

                        // Phone Field
                        _buildTextField(
                          controller: _phoneController,
                          label: 'फोन नंबर / Phone Number',
                          icon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'कृपया फोन नंबर डालें';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 20),

                        // Email Field
                        _buildTextField(
                          controller: _emailController,
                          label: 'ईमेल / Email',
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'कृपया ईमेल डालें';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 20),

                        // Password Field
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            style: TextStyle(fontSize: 16),
                            decoration: InputDecoration(
                              labelText: 'पासवर्ड / Password',
                              labelStyle: TextStyle(fontSize: 16),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Color(0xFF1976D2),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey[600],
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 20,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'कृपया पासवर्ड डालें';
                              }
                              return null;
                            },
                          ),
                        ),

                        SizedBox(height: 30),

                        // Sign Up Button
                        Consumer(
                          builder: (context, ref, child) {
                            return Container(
                              width: double.infinity,
                              height: 55,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF1976D2),
                                    Color(0xFF42A5F5),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF1976D2).withOpacity(0.3),
                                    blurRadius: 10,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(15),
                                  onTap: _isLoading
                                      ? null
                                      : () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() => _isLoading = true);
                                            final authService = ref.read(
                                              authServiceProvider,
                                            );
                                            try {
                                              await authService.signup(
                                                _emailController.text.trim(),
                                                _passwordController.text.trim(),
                                                _nameController.text.trim(),
                                              );
                                              if (context.mounted) {
                                                context.go('/');
                                              }
                                            } on AppwriteException catch (e) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    e.message ?? 'Login failed',
                                                  ),
                                                ),
                                              );
                                            } finally {
                                              setState(
                                                () => _isLoading = false,
                                              );
                                            }
                                          }
                                        },
                                  child: Center(
                                    child: _isLoading
                                        ? CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  Colors.white,
                                                ),
                                          )
                                        : Text(
                                            'खाता बनाएं / Sign Up',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(fontSize: 16),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 16),
          prefixIcon: Icon(icon, color: Color(0xFF1976D2)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        ),
        validator: validator,
      ),
    );
  }
}
