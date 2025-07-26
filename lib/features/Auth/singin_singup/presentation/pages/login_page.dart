
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qassimha/core/resources/routes_manager.dart';
import 'package:qassimha/features/Auth/singin_singup/presentation/widgets/google_sign_in_button.dart';
import '../../../../../core/di/di.dart';
import '../bloc/Auth_cubit.dart';

import '../widgets/animated_logo.dart';
import '../widgets/welcome_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with TickerProviderStateMixin {
  late AuthCubit viewModel;
  late AnimationController _backgroundController;
  late AnimationController _contentController;

  late Animation<double> _backgroundAnimation;
  late Animation<double> _contentFadeAnimation;
  late Animation<Offset> _contentSlideAnimation;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<AuthCubit>();
    _initAnimations();
    _startAnimations();
  }

  void _initAnimations() {
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    );

    _contentController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _backgroundAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _backgroundController,
      curve: Curves.linear,
    ));

    _contentFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _contentController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
    ));

    _contentSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _contentController,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOutBack),
    ));
  }

  void _startAnimations() {
    _backgroundController.repeat();
    _contentController.forward();
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _handleGoogleSignIn() {
    viewModel.signInWithGoogle();

  }

  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12),
            Text('تم تسجيل الدخول بنجاح!'),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'حدث خطأ: $message',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 400;

    return BlocProvider.value(
      value: viewModel,
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoginSuccess) {
            _showSuccessMessage();
            // Navigate to home page
            Navigator.pushReplacementNamed(context,RoutesManager.homePage);
          } else if (state is AuthLoginFailure) {
            _showErrorMessage(state.exception.toString());
          }
        },
        child: Scaffold(
          body: AnimatedBuilder(
            animation: _backgroundAnimation,
            builder: (context, child) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: const [
                      Color(0xFFF8FAFC),
                      Color(0xFFE2E8F0),
                      Color(0xFFF1F5F9),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    transform: GradientRotation(
                      _backgroundAnimation.value * 2 * 3.14159 / 4,
                    ),
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 24.0 : 32.0,
                      vertical: 20.0,
                    ),
                    child: SlideTransition(
                      position: _contentSlideAnimation,
                      child: FadeTransition(
                        opacity: _contentFadeAnimation,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedLogo(
                                    size: isSmallScreen ? 100 : 120,
                                  ),
                                  SizedBox(height: isSmallScreen ? 32 : 48),
                                  const WelcomeText(),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BlocBuilder<AuthCubit, AuthState>(
                                    builder: (context, state) {
                                      final isLoading = state is AuthLoginLoading;

                                      return GoogleSignInButton(
                                        onPressed: _handleGoogleSignIn,
                                        isLoading: isLoading,
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 24),
                                  _buildFooterText(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFooterText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'بالمتابعة، أنت توافق على شروط الخدمة وسياسة الخصوصية',
        style: TextStyle(
          fontSize: 12,
          color: const Color(0xFF6B7280).withOpacity(0.8),
          height: 1.4,
        ),
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}