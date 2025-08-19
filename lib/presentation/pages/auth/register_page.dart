import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/responsive_layout.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
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
            } else if (state is AuthAuthenticated) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Registration successful!'),
                  backgroundColor: AppColors.success,
                ),
              );
              Navigator.of(context).pushReplacementNamed('/home');
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
      child: _buildRegistrationForm(),
    );
  }

  Widget _buildTabletLayout() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: SingleChildScrollView(
          padding: context.responsivePadding,
          child: _buildRegistrationForm(),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(48),
          child: _buildRegistrationForm(),
        ),
      ),
    );
  }

  Widget _buildRegistrationForm() {
    return FormBuilder(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(),
          const SizedBox(height: 32),
          _buildPersonalInfoSection(),
          const SizedBox(height: 24),
          _buildAccountInfoSection(),
          const SizedBox(height: 24),
          _buildUserTypeSelection(),
          const SizedBox(height: 32),
          _buildSubmitButton(),
          const SizedBox(height: 24),
          _buildAlternativeRegistration(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Join Our Community',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Create your account and start your journey',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.gray600,
          ),
        ),
      ],
    );
  }

  Widget _buildPersonalInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personal Information',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        FormBuilderTextField(
          name: 'fullName',
          decoration: const InputDecoration(
            labelText: 'Full Name',
            hintText: 'Enter your full name',
            prefixIcon: Icon(Icons.person_outline),
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(2),
          ]),
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
        ),
        const SizedBox(height: 16),
        FormBuilderTextField(
          name: 'email',
          decoration: const InputDecoration(
            labelText: 'Email Address',
            hintText: 'Enter your email',
            prefixIcon: Icon(Icons.email_outlined),
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.email(),
          ]),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 16),
        FormBuilderTextField(
          name: 'phone',
          decoration: const InputDecoration(
            labelText: 'Phone Number (Optional)',
            hintText: 'Enter your phone number',
            prefixIcon: Icon(Icons.phone_outlined),
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.phoneNumber(),
          ]),
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }

  Widget _buildAccountInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account Security',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        FormBuilderTextField(
          name: 'password',
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'Create a strong password',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              icon: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          ),
          obscureText: _obscurePassword,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(AppConstants.minPasswordLength),
            FormBuilderValidators.maxLength(AppConstants.maxPasswordLength),
          ]),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 16),
        FormBuilderTextField(
          name: 'confirmPassword',
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            hintText: 'Re-enter your password',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
              icon: Icon(
                _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          ),
          obscureText: _obscureConfirmPassword,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            (value) {
              final password = _formKey.currentState?.fields['password']?.value;
              if (value != password) {
                return 'Passwords do not match';
              }
              return null;
            },
          ]),
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }

  Widget _buildUserTypeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'I am a...',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'You can only select this once, so choose carefully!',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.warning,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        FormBuilderRadioGroup<UserType>(
          name: 'userType',
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          validator: FormBuilderValidators.required(),
          options: [
            FormBuilderFieldOption(
              value: UserType.jobSeeker,
              child: _buildUserTypeCard(
                title: 'Job Seeker',
                description: 'Looking for job opportunities and career growth',
                icon: Icons.work_outline,
                userType: UserType.jobSeeker,
              ),
            ),
            FormBuilderFieldOption(
              value: UserType.recruiter,
              child: _buildUserTypeCard(
                title: 'Recruiter',
                description: 'Hiring talent and posting job opportunities',
                icon: Icons.business_center_outlined,
                userType: UserType.recruiter,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUserTypeCard({
    required String title,
    required String description,
    required IconData icon,
    required UserType userType,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderLight),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.gray600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return CustomButton(
          text: 'Create Account',
          onPressed: _handleRegister,
          isLoading: state is AuthLoading,
          isFullWidth: true,
          size: ButtonSize.large,
        );
      },
    );
  }

  Widget _buildAlternativeRegistration() {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Or sign up with',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.gray500,
                ),
              ),
            ),
            const Expanded(child: Divider()),
          ],
        ),
      ],
    );
  }

  void _handleRegister() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;
      context.read<AuthBloc>().add(
        AuthRegisterRequested(
          email: values['email'],
          password: values['password'],
          fullName: values['fullName'],
        ),
      );
    }
  }
}
