import 'package:flutter/material.dart';
import 'package:project/screens/home/home_screen.dart';
import 'package:project/screens/signup.dart';

class SigninScreen extends StatefulWidget {
  final String? userName;
  final String? empType;

  const SigninScreen({super.key, this.userName, this.empType});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen>
    with TickerProviderStateMixin {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  bool _isPhoneNumber(String input) {
    return RegExp(r'^[0-9]{10}$').hasMatch(input);
  }

  bool _isEmail(String input) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(input);
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Start the progress animation
      _progressController.forward();

      // Wait for the progress to complete
      await _progressController.forward();
      await Future.delayed(const Duration(milliseconds: 500));

      setState(() {
        _isLoading = false;
      });

      // Navigate with subtle transition
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => Homescreen(
            userName: _loginController.text.isNotEmpty
                ? _loginController.text
                : (widget.userName ?? 'User'),
            empType: widget.empType ?? 'Employee',
          ),
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position:
                    Tween<Offset>(
                      begin: const Offset(0.1, 0.0),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(parent: animation, curve: Curves.easeOut),
                    ),
                child: child,
              ),
            );
          },
        ),
      );

      // Reset progress for next use
      _progressController.reset();
    }
  }

  Widget _buildLoadingOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(40),
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.login, size: 60, color: Color(0xFF1976D2)),
              const SizedBox(height: 20),
              const Text(
                'Signing In...',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212121),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Please wait while we authenticate your credentials',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Color(0xFF616161)),
              ),
              const SizedBox(height: 30),

              // Custom Progress Bar
              Container(
                height: 6,
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: AnimatedBuilder(
                  animation: _progressAnimation,
                  builder: (context, child) {
                    return FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      heightFactor: 1,
                      widthFactor: _progressAnimation.value,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF1976D2), Color(0xFF1565C0)],
                          ),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 15),

              // Progress Text
              AnimatedBuilder(
                animation: _progressAnimation,
                builder: (context, child) {
                  return Text(
                    '${(_progressAnimation.value * 100).toInt()}%',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1976D2),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF1976D2).withOpacity(0.1),
                  Colors.white,
                ],
              ),
            ),
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Show user info if available from signup
                        if (widget.userName != null &&
                            widget.empType != null) ...[
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1976D2).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFF1976D2).withOpacity(0.3),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Welcome, ${widget.userName}!',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1976D2),
                                  ),
                                ),
                                Text(
                                  'Employee Type: ${widget.empType}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF616161),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],

                        // Logo Section
                        Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1976D2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Welcome Back!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF212121),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),

                        // Login Field
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            border: Border.all(
                              color: const Color(0xFFE3F2FD).withOpacity(0.5),
                              width: 1,
                            ),
                          ),
                          child: TextFormField(
                            controller: _loginController,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF212121),
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Phone or Email',
                              labelStyle: TextStyle(color: Color(0xFF616161)),
                              hintText: 'Enter phone number or email',
                              hintStyle: TextStyle(color: Color(0xFF9E9E9E)),
                              prefixIcon: Icon(
                                Icons.account_circle,
                                color: Color(0xFF1976D2),
                                size: 24,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.transparent,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                borderSide: BorderSide(
                                  color: Color(0xFF1976D2),
                                  width: 2,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number or email';
                              }
                              if (!_isEmail(value) && !_isPhoneNumber(value)) {
                                return 'Please enter a valid phone number or email';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Password Field
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            border: Border.all(
                              color: const Color(0xFFE3F2FD).withOpacity(0.5),
                              width: 1,
                            ),
                          ),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF212121),
                            ),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: const TextStyle(
                                color: Color(0xFF616161),
                              ),
                              hintText: 'Enter your password',
                              hintStyle: const TextStyle(
                                color: Color(0xFF9E9E9E),
                              ),
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Color(0xFF1976D2),
                                size: 24,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: const Color(0xFF1976D2),
                                  size: 24,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.transparent,
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                borderSide: BorderSide(
                                  color: Color(0xFF1976D2),
                                  width: 2,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Forgot Password Link
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Color(0xFF1976D2),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Login Button
                        Container(
                          width: double.infinity,
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF1976D2).withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1976D2),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Sign Up Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                color: Color(0xFF616161),
                                fontSize: 16,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                        ) => const SignUpScreen(),
                                    transitionDuration: const Duration(
                                      milliseconds: 300,
                                    ),
                                    reverseTransitionDuration: const Duration(
                                      milliseconds: 300,
                                    ),
                                    transitionsBuilder:
                                        (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                          child,
                                        ) {
                                          return FadeTransition(
                                            opacity: animation,
                                            child: SlideTransition(
                                              position:
                                                  Tween<Offset>(
                                                    begin: const Offset(
                                                      0.1,
                                                      0.0,
                                                    ),
                                                    end: Offset.zero,
                                                  ).animate(
                                                    CurvedAnimation(
                                                      parent: animation,
                                                      curve: Curves.easeOut,
                                                    ),
                                                  ),
                                              child: child,
                                            ),
                                          );
                                        },
                                  ),
                                );
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Color(0xFF1976D2),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
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
            ),
          ),

          // Loading Overlay
          if (_isLoading) _buildLoadingOverlay(),
        ],
      ),
    );
  }
}
