import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../blocs/profile/profile_bloc.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/responsive_layout.dart';

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  UserType? _selectedUserType;
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Your Profile'),
        automaticallyImplyLeading: false,
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoaded && state.hasProfileType) {
            Navigator.of(context).pushReplacementNamed('/home');
          }
        },
        child: ResponsiveLayout(
          mobile: _buildMobileLayout(),
          tablet: _buildTabletLayout(),
          desktop: _buildDesktopLayout(),
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return _buildStepperForm();
  }

  Widget _buildTabletLayout() {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        padding: const EdgeInsets.all(24),
        child: _buildStepperForm(),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        padding: const EdgeInsets.all(32),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildWelcomeSection(),
            ),
            const SizedBox(width: 48),
            Expanded(
              flex: 3,
              child: _buildStepperForm(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.work_outline,
          size: 64,
          color: AppColors.primary,
        ),
        const SizedBox(height: 24),
        Text(
          'Welcome to Job Portal',
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimaryLight,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Complete your profile to get started with finding your dream job or hiring the best talent.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: AppColors.textSecondaryLight,
          ),
        ),
        const SizedBox(height: 32),
        _buildStepIndicator(),
      ],
    );
  }

  Widget _buildStepIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepIndicatorItem(0, 'Choose Profile Type', 'Select your role'),
        _buildStepIndicatorItem(1, 'Basic Information', 'Tell us about yourself'),
        _buildStepIndicatorItem(2, 'Additional Details', 'Complete your profile'),
      ],
    );
  }

  Widget _buildStepIndicatorItem(int step, String title, String subtitle) {
    final theme = Theme.of(context);
    final isActive = _currentStep == step;
    final isCompleted = _currentStep > step;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCompleted || isActive
                  ? AppColors.primary
                  : AppColors.gray300,
            ),
            child: Icon(
              isCompleted ? Icons.check : Icons.circle,
              size: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                    color: isActive || isCompleted
                        ? AppColors.textPrimaryLight
                        : AppColors.textSecondaryLight,
                  ),
                ),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepperForm() {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: _buildCurrentStep(),
          ),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildProfileTypeStep();
      case 1:
        return _buildBasicInfoStep();
      case 2:
        return _buildAdditionalDetailsStep();
      default:
        return _buildProfileTypeStep();
    }
  }

  Widget _buildProfileTypeStep() {
    final theme = Theme.of(context);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose Your Profile Type',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Select your role. You can only choose this once, so choose carefully.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 32),
          _buildProfileTypeCard(
            type: UserType.job_seeker,
            title: 'Job Seeker',
            subtitle: 'Looking for opportunities',
            description: 'Find your dream job, showcase your skills, and connect with top companies.',
            icon: Icons.person_search,
          ),
          const SizedBox(height: 16),
          _buildProfileTypeCard(
            type: UserType.recruiter,
            title: 'Recruiter',
            subtitle: 'Hiring talent',
            description: 'Post jobs, find candidates, and build your team with the best talent.',
            icon: Icons.business_center,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTypeCard(
      {required UserType type,
      required String title,
      required String subtitle,
      required String description,
      required IconData icon}) {
    final theme = Theme.of(context);
    final isSelected = _selectedUserType == type;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedUserType = type;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.borderLight,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: isSelected
              ? AppColors.primary.withOpacity(0.05)
              : Colors.transparent,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.gray100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : AppColors.gray600,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimaryLight,
                        ),
                      ),
                      if (isSelected) ...[
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ],
                    ],
                  ),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfoStep() {
    final theme = Theme.of(context);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Basic Information',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tell us about yourself to help others know you better.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 32),
          FormBuilderTextField(
            name: 'fullName',
            decoration: const InputDecoration(
              labelText: 'Full Name',
              hintText: 'Enter your full name',
              prefixIcon: Icon(Icons.person),
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.minLength(2),
            ]),
          ),
          const SizedBox(height: 16),
          FormBuilderTextField(
            name: 'bio',
            decoration: const InputDecoration(
              labelText: 'Bio',
              hintText: 'Tell us about yourself',
              prefixIcon: Icon(Icons.info),
            ),
            maxLines: 3,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.minLength(10),
              FormBuilderValidators.maxLength(500),
            ]),
          ),
          const SizedBox(height: 16),
          FormBuilderTextField(
            name: 'location',
            decoration: const InputDecoration(
              labelText: 'Location',
              hintText: 'Enter your location',
              prefixIcon: Icon(Icons.location_on),
            ),
            validator: FormBuilderValidators.required(),
          ),
          const SizedBox(height: 16),
          FormBuilderTextField(
            name: 'phone',
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              hintText: 'Enter your phone number',
              prefixIcon: Icon(Icons.phone),
            ),
            keyboardType: TextInputType.phone,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.phoneNumber(),
            ]),
          ),
          const SizedBox(height: 16),
          FormBuilderTextField(
            name: 'website',
            decoration: const InputDecoration(
              labelText: 'Website (Optional)',
              hintText: 'Enter your website URL',
              prefixIcon: Icon(Icons.link),
            ),
            keyboardType: TextInputType.url,
            validator: FormBuilderValidators.url(),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalDetailsStep() {
    final theme = Theme.of(context);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Additional Details',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _selectedUserType == UserType.job_seeker
                ? 'Complete your job seeker profile.'
                : 'Complete your recruiter profile.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 32),
          if (_selectedUserType == UserType.job_seeker) ...[
            FormBuilderTextField(
              name: 'preferredJobLocation',
              decoration: const InputDecoration(
                labelText: 'Preferred Job Location',
                hintText: 'Where would you like to work?',
                prefixIcon: Icon(Icons.work),
              ),
              validator: FormBuilderValidators.required(),
            ),
            const SizedBox(height: 16),
            FormBuilderDropdown<String>(
              name: 'availabilityStatus',
              decoration: const InputDecoration(
                labelText: 'Availability',
                prefixIcon: Icon(Icons.schedule),
              ),
              items: const [
                DropdownMenuItem(value: 'immediately', child: Text('Immediately')),
                DropdownMenuItem(value: 'within_month', child: Text('Within a month')),
                DropdownMenuItem(value: 'within_3_months', child: Text('Within 3 months')),
                DropdownMenuItem(value: 'not_looking', child: Text('Not actively looking')),
              ],
              validator: FormBuilderValidators.required(),
            ),
          ] else ...[
            FormBuilderTextField(
              name: 'position',
              decoration: const InputDecoration(
                labelText: 'Your Position',
                hintText: 'e.g., HR Manager, Talent Acquisition',
                prefixIcon: Icon(Icons.badge),
              ),
              validator: FormBuilderValidators.required(),
            ),
            const SizedBox(height: 16),
            FormBuilderTextField(
              name: 'company',
              decoration: const InputDecoration(
                labelText: 'Company Name',
                hintText: 'Enter your company name',
                prefixIcon: Icon(Icons.business),
              ),
              validator: FormBuilderValidators.required(),
            ),
            const SizedBox(height: 16),
            FormBuilderTextField(
              name: 'department',
              decoration: const InputDecoration(
                labelText: 'Department',
                hintText: 'e.g., Human Resources, Engineering',
                prefixIcon: Icon(Icons.group),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: CustomButton(
                text: 'Back',
                onPressed: _previousStep,
                variant: ButtonVariant.outlined,
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 16),
          Expanded(
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                final isLoading = state is ProfileLoaded && state.isUpdating;
                
                return CustomButton(
                  text: _currentStep == 2 ? 'Complete Setup' : 'Next',
                  onPressed: isLoading ? null : _nextStep,
                  isLoading: isLoading,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _nextStep() {
    if (_currentStep == 0) {
      if (_selectedUserType == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a profile type'),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }
      context.read<ProfileBloc>().add(
        ProfileTypeSelected(profileType: _selectedUserType!),
      );
    } else if (_currentStep == 1 || _currentStep == 2) {
      if (!(_formKey.currentState?.saveAndValidate() ?? false)) {
        return;
      }
    }

    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
    } else {
      _completeSetup();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _completeSetup() {
    if (!(_formKey.currentState?.saveAndValidate() ?? false)) {
      return;
    }

    final formData = _formKey.currentState!.value;
    
    // TODO: Create complete profile model and submit
    // For now, navigate to home
    Navigator.of(context).pushReplacementNamed('/home');
  }
}
