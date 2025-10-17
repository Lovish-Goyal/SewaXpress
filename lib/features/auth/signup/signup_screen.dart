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
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // Left side - Brand section (visible on larger screens)
          if (MediaQuery.of(context).size.width > 800)
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF0D47A1),
                      Color(0xFF1976D2),
                      Color(0xFF2196F3),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home_repair_service_rounded,
                      size: 120,
                      color: Colors.white,
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Urban Services',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'आपके आसपास की सेवाएं',
                      style: TextStyle(fontSize: 20, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),

          // Right side - Signup form
          Expanded(
            child: Container(
              color: Colors.white,
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    width: 450,
                    padding: EdgeInsets.all(50),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Mobile logo
                          if (MediaQuery.of(context).size.width <= 800)
                            Center(
                              child: Column(
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF1976D2),
                                          Color(0xFF42A5F5),
                                        ],
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.home_repair_service_rounded,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ),

                          Center(
                            child: Column(
                              children: [
                                SizedBox(height: 10),
                                Center(
                                  child: Text(
                                    'Create New Account',
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF1976D2),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Center(
                                  child: Text(
                                    'नया खाता बनाएं',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 40),

                          // Name
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Full Name',
                              hintText: 'पूरा नाम दर्ज करें',
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Color(0xFF1976D2),
                                  width: 2,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: Color(0xFF1976D2),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'नाम आवश्यक है';
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          // Phone
                          TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              hintText: 'फोन नंबर दर्ज करें',
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Color(0xFF1976D2),
                                  width: 2,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.phone_outlined,
                                color: Color(0xFF1976D2),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'फोन नंबर आवश्यक है';
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          // Email
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'ईमेल दर्ज करें',
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Color(0xFF1976D2),
                                  width: 2,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Color(0xFF1976D2),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'ईमेल आवश्यक है';
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          // Password
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'पासवर्ड दर्ज करें',
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Color(0xFF1976D2),
                                  width: 2,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Color(0xFF1976D2),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () => setState(
                                  () => _obscurePassword = !_obscurePassword,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'पासवर्ड आवश्यक है';
                              return null;
                            },
                          ),
                          SizedBox(height: 30),

                          // Signup button
                          Consumer(
                            builder: (context, ref, child) {
                              return SizedBox(
                                width: double.infinity,
                                height: 55,
                                child: ElevatedButton(
                                  onPressed: _isLoading
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
                                              if (context.mounted)
                                                context.go('/');
                                            } on AppwriteException catch (e) {
                                              if (context.mounted) {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      e.message ??
                                                          'Signup failed',
                                                    ),
                                                  ),
                                                );
                                              }
                                            } finally {
                                              if (mounted)
                                                setState(
                                                  () => _isLoading = false,
                                                );
                                            }
                                          }
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF1976D2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: _isLoading
                                      ? SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : Text(
                                          'Sign Up',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 20),

                          // Divider
                          Row(
                            children: [
                              Expanded(child: Divider()),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  'OR',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                              Expanded(child: Divider()),
                            ],
                          ),
                          SizedBox(height: 8),

                          // Login
                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Already have an account?",
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                                TextButton(
                                  onPressed: () => context.go('/login'),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Color(0xFF1976D2),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
