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

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(30.0),
              child: AnimatedBuilder(
                animation: _slideAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _slideAnimation.value),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo Card
                        Container(
                          padding: EdgeInsets.all(40),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.home_repair_service,
                                size: 80,
                                color: Color(0xFF1976D2),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Urban Services',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'आपके आसपास की सेवाएं',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 40),

                        // Login Form Card
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
                                Text(
                                  'स्वागत है / Welcome',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 30),

                                // Email Field
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Colors.grey[200]!,
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(fontSize: 16),
                                    decoration: InputDecoration(
                                      labelText: 'ईमेल / Email',
                                      labelStyle: TextStyle(fontSize: 16),
                                      prefixIcon: Icon(
                                        Icons.email_outlined,
                                        color: Color(0xFF1976D2),
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 20,
                                        horizontal: 20,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'कृपया ईमेल डालें';
                                      }
                                      return null;
                                    },
                                  ),
                                ),

                                SizedBox(height: 20),

                                // Password Field
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Colors.grey[200]!,
                                    ),
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
                                            _obscurePassword =
                                                !_obscurePassword;
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

                                // Login Button
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
                                            color: Color(
                                              0xFF1976D2,
                                            ).withOpacity(0.3),
                                            blurRadius: 10,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                          onTap: _isLoading
                                              ? null
                                              : () async {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    setState(
                                                      () => _isLoading = true,
                                                    );
                                                    final authService = ref
                                                        .read(
                                                          authServiceProvider,
                                                        );
                                                    try {
                                                      await authService.login(
                                                        _emailController.text
                                                            .trim(),
                                                        _passwordController.text
                                                            .trim(),
                                                      );
                                                      ref.invalidate(
                                                        userProvider,
                                                      );
                                                      if (context.mounted) {
                                                        context.go('/');
                                                      }
                                                    } on AppwriteException catch (
                                                      e
                                                    ) {
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
                                                    } finally {
                                                      setState(
                                                        () =>
                                                            _isLoading = false,
                                                      );
                                                    }
                                                  }
                                                },

                                          child: Center(
                                            child: _isLoading
                                                ? CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                          Color
                                                        >(Colors.white),
                                                  )
                                                : Text(
                                                    'लॉगिन करें / Login',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),

                                SizedBox(height: 20),

                                // Forgot Password
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'पासवर्ड भूल गए? / Forgot Password?',
                                    style: TextStyle(
                                      color: Color(0xFF1976D2),
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 30),

                        // Sign Up Link
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'नया यूजर हैं? ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.push('/signup');
                                },
                                child: Text(
                                  'खाता बनाएं / Sign Up',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF1976D2),
                                    fontWeight: FontWeight.bold,
                                  ),
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
            ),
          ),
        ),
      ),
    );
  }
}
