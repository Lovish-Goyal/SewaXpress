import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
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
                      'SewaXPress',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1976D2),
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

          // Right side - Login form
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 30),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    'Welcome Back',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF1976D2),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Center(
                                  child: Text(
                                    'अपने खाते में लॉगिन करें',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 40),

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
                          SizedBox(height: 15),

                          // Forgot password
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(color: Color(0xFF1976D2)),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),

                          // Login button
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
                                              await authService.login(
                                                _emailController.text.trim(),
                                                _passwordController.text.trim(),
                                              );
                                              ref.invalidate(userProvider);
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
                                                          'Login failed',
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
                                          'Login',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 30),

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
                          SizedBox(height: 30),

                          // Sign up
                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                                TextButton(
                                  onPressed: () => context.go('/signup'),
                                  child: Text(
                                    'Sign Up',
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
