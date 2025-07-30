import 'package:flutter/material.dart';
import 'package:project/screens/homeScreen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
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

      await Future.delayed(Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homescreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;
    final isDesktop = screenSize.width > 1200;
    final isLandscape = screenSize.width > screenSize.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange.withOpacity(0.1), Colors.white],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isDesktop
                    ? 500
                    : isTablet
                    ? 400
                    : double.infinity,
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(_getPadding(screenSize.width)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (!isLandscape || isTablet)
                        _buildLogoSection(screenSize.width),

                      SizedBox(
                        height: _getVerticalSpacing(
                          screenSize.width,
                          isLandscape,
                        ),
                      ),

                      if (isDesktop && isLandscape)
                        _buildDesktopForm()
                      else
                        _buildMobileForm(),

                      SizedBox(
                        height:
                            _getVerticalSpacing(screenSize.width, isLandscape) *
                            0.7,
                      ),

                      _buildLoginButton(screenSize.width),

                      SizedBox(
                        height:
                            _getVerticalSpacing(screenSize.width, isLandscape) *
                            0.6,
                      ),

                      _buildSignUpSection(screenSize.width),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection(double screenWidth) {
    return Column(
      children: [
        Container(
          width: _getLogoSize(screenWidth),
          height: _getLogoSize(screenWidth),
          decoration: BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.supervised_user_circle,
            size: _getLogoIconSize(screenWidth),
            color: Colors.black,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Hello!!',
          style: TextStyle(
            fontSize: _getTitleSize(screenWidth),
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileForm() {
    return Column(
      children: [
        _buildLoginField(),
        SizedBox(height: 20),
        _buildPasswordField(),
        SizedBox(height: 16),
        _buildForgotPasswordLink(),
      ],
    );
  }

  Widget _buildDesktopForm() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildLoginField()),
            SizedBox(width: 20),
            Expanded(child: _buildPasswordField()),
          ],
        ),
        SizedBox(height: 16),
        _buildForgotPasswordLink(),
      ],
    );
  }

  Widget _buildLoginField() {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: _loginController,
        keyboardType: TextInputType.text,
        style: TextStyle(fontSize: _getInputTextSize(screenWidth)),
        decoration: InputDecoration(
          labelText: 'Phone or Email',
          hintText: 'Enter phone number or email',
          prefixIcon: Icon(
            Icons.account_circle,
            color: Colors.orange,
            size: _getInputIconSize(screenWidth),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.transparent,
          labelStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: _getInputTextSize(screenWidth),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.orange, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: _getInputPadding(screenWidth),
            vertical: _getInputPadding(screenWidth),
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
    );
  }

  Widget _buildPasswordField() {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: _passwordController,
        obscureText: !_isPasswordVisible,
        style: TextStyle(fontSize: _getInputTextSize(screenWidth)),
        decoration: InputDecoration(
          labelText: 'Password',
          hintText: 'Enter your password',
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.orange,
            size: _getInputIconSize(screenWidth),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.orange,
              size: _getInputIconSize(screenWidth),
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.transparent,
          labelStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: _getInputTextSize(screenWidth),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.orange, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: _getInputPadding(screenWidth),
            vertical: _getInputPadding(screenWidth),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildForgotPasswordLink() {
    final screenWidth = MediaQuery.of(context).size.width;

    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            color: Colors.orange,
            fontWeight: FontWeight.w600,
            fontSize: _getInputTextSize(screenWidth),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(double screenWidth) {
    return Container(
      height: _getButtonHeight(screenWidth),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: _isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                      strokeWidth: 2,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Signing In...',
                    style: TextStyle(
                      fontSize: _getButtonTextSize(screenWidth),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            : Text(
                'Sign In',
                style: TextStyle(
                  fontSize: _getButtonTextSize(screenWidth),
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Widget _buildSignUpSection(double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: _getInputTextSize(screenWidth),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
              fontSize: _getInputTextSize(screenWidth),
            ),
          ),
        ),
      ],
    );
  }

  double _getPadding(double screenWidth) {
    if (screenWidth > 1200) return 48;
    if (screenWidth > 600) return 32;
    return 24;
  }

  double _getVerticalSpacing(double screenWidth, bool isLandscape) {
    final baseSpacing = screenWidth > 1200
        ? 40.0
        : screenWidth > 600
        ? 32.0
        : 24.0;
    return isLandscape ? baseSpacing * 0.6 : baseSpacing;
  }

  double _getLogoSize(double screenWidth) {
    if (screenWidth > 1200) return 100;
    if (screenWidth > 600) return 90;
    return 80;
  }

  double _getLogoIconSize(double screenWidth) {
    if (screenWidth > 1200) return 50;
    if (screenWidth > 600) return 45;
    return 40;
  }

  double _getTitleSize(double screenWidth) {
    if (screenWidth > 1200) return 32;
    if (screenWidth > 600) return 30;
    return 28;
  }

  double _getInputTextSize(double screenWidth) {
    if (screenWidth > 1200) return 18;
    if (screenWidth > 600) return 16;
    return 14;
  }

  double _getInputIconSize(double screenWidth) {
    if (screenWidth > 1200) return 26;
    if (screenWidth > 600) return 24;
    return 22;
  }

  double _getInputPadding(double screenWidth) {
    if (screenWidth > 1200) return 20;
    if (screenWidth > 600) return 18;
    return 16;
  }

  double _getButtonHeight(double screenWidth) {
    if (screenWidth > 1200) return 60;
    if (screenWidth > 600) return 58;
    return 55;
  }

  double _getButtonTextSize(double screenWidth) {
    if (screenWidth > 1200) return 18;
    if (screenWidth > 600) return 17;
    return 16;
  }
}
