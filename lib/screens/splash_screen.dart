import 'package:flutter/material.dart';
import 'package:project/screens/signin.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fadeLogo;   // fade + scale for the logo
  late final Animation<double> _scaleLogo;

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeLogo = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _scaleLogo = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut),
    );

    _startSequence();
  }

  Future<void> _startSequence() async {
    _ctrl.forward();                         // run the logo animation
    await Future.delayed(const Duration(seconds: 5));

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const SigninScreen(),
        transitionDuration: const Duration(milliseconds: 600),
        transitionsBuilder: (_, anim, __, child) => FadeTransition(
          opacity: CurvedAnimation(parent: anim, curve: Curves.easeInOut),
          child: child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1976D2),
              Color(0xFF1565C0),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // animated logo
                FadeTransition(
                  opacity: _fadeLogo,
                  child: ScaleTransition(
                    scale: _scaleLogo,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.25),
                            blurRadius: 15,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.business,
                        size: 60,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // company name
                FadeTransition(
                  opacity: _fadeLogo,
                  child: const Text(
                    'SpinOff',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // tagline
                FadeTransition(
                  opacity: _fadeLogo,
                  child: const Text(
                    'Empowering Productivity',
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 60),

                // loading indicator
                FadeTransition(
                  opacity: _fadeLogo,
                  child: const CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 2,
                  ),
                ),
                const SizedBox(height: 20),

                // loading text
                FadeTransition(
                  opacity: _fadeLogo,
                  child: const Text(
                    'Loading...',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
