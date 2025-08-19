import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/responsive_layout.dart';

class OtpVerificationPage extends StatefulWidget {
  final String email;

  const OtpVerificationPage({
    super.key,
    required this.email,
  });

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final List<TextEditingController> _controllers = List.generate(
    AppConstants.otpLength,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    AppConstants.otpLength,
    (index) => FocusNode(),
  );

  Timer? _timer;
  int _resendTimer = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    _canResend = false;
    _resendTimer = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_resendTimer > 0) {
            _resendTimer--;
          } else {
            _canResend = true;
            timer.cancel();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.error,
                ),
              );
              _clearOtp();
            } else if (state is AuthAuthenticated) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/home',
                (route) => false,
              );
            } else if (state is AuthOtpSent) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('OTP sent successfully!'),
                  backgroundColor: AppColors.success,
                ),
              );
              _startResendTimer();
              _clearOtp();
            }
          },
          child: ResponsiveLayout(
            mobile: _buildMobileLayout(),
            tablet: _buildTabletLayout(),
            desktop: _buildDesktopLayout(),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      padding: context.responsivePadding,
      child: _buildOtpForm(),
    );
  }

  Widget _buildTabletLayout() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: SingleChildScrollView(
          padding: context.responsivePadding,
          child: _buildOtpForm(),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(48),
          child: _buildOtpForm(),
        ),
      ),
    );
  }

  Widget _buildOtpForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 32),
        _buildHeader(),
        const SizedBox(height: 48),
        _buildOtpInput(),
        const SizedBox(height: 32),
        _buildVerifyButton(),
        const SizedBox(height: 24),
        _buildResendSection(),
        const SizedBox(height: 32),
        _buildChangeEmailButton(),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.mark_email_read_outlined,
            size: 40,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Verify Your Email',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.gray600,
            ),
            children: [
              const TextSpan(text: 'We sent a '),
              TextSpan(
                text: '${AppConstants.otpLength}-digit code',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const TextSpan(text: ' to\n'),
              TextSpan(
                text: widget.email,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Enter the code below to verify your email',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.gray500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildOtpInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        AppConstants.otpLength,
        (index) => _buildOtpDigitField(index),
      ),
    );
  }

  Widget _buildOtpDigitField(int index) {
    return Container(
      width: 50,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(
          color: _controllers[index].text.isNotEmpty
              ? AppColors.primary
              : AppColors.borderLight,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (index < AppConstants.otpLength - 1) {
              _focusNodes[index + 1].requestFocus();
            } else {
              _focusNodes[index].unfocus();
              _verifyOtp();
            }
          } else if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
          setState(() {});
        },
        onSubmitted: (value) {
          if (value.isNotEmpty && index < AppConstants.otpLength - 1) {
            _focusNodes[index + 1].requestFocus();
          }
        },
      ),
    );
  }

  Widget _buildVerifyButton() {
    final isOtpComplete = _controllers.every((controller) => controller.text.isNotEmpty);
    
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return CustomButton(
          text: 'Verify Code',
          onPressed: isOtpComplete ? _verifyOtp : null,
          isLoading: state is AuthLoading,
          isFullWidth: true,
          size: ButtonSize.large,
        );
      },
    );
  }

  Widget _buildResendSection() {
    return Column(
      children: [
        if (!_canResend) ...[
          Text(
            'Resend code in ${_resendTimer}s',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.gray500,
            ),
          ),
        ] else ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Didn't receive the code? ",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return TextButton(
                    onPressed: state is AuthLoading ? null : _resendOtp,
                    child: state is AuthLoading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Resend'),
                  );
                },
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildChangeEmailButton() {
    return TextButton.icon(
      onPressed: () => Navigator.of(context).pop(),
      icon: const Icon(Icons.arrow_back),
      label: const Text('Change Email Address'),
    );
  }

  void _verifyOtp() {
    final otp = _controllers.map((controller) => controller.text).join();
    if (otp.length == AppConstants.otpLength) {
      context.read<AuthBloc>().add(
        AuthLoginRequested.withOtp(
          email: widget.email,
          otp: otp,
        ),
      );
    }
  }

  void _resendOtp() {
    context.read<AuthBloc>().add(
      AuthOtpSendRequested(email: widget.email),
    );
  }

  void _clearOtp() {
    for (final controller in _controllers) {
      controller.clear();
    }
    if (_focusNodes.isNotEmpty) {
      _focusNodes[0].requestFocus();
    }
  }
}
