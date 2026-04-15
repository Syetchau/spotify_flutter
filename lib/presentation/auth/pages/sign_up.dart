import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/helpers/navigation_utils.dart';
import 'package:spotify/common/helpers/theme_utils.dart';
import 'package:spotify/common/widgets/app_button.dart';
import 'package:spotify/common/widgets/app_loading.dart';
import 'package:spotify/common/widgets/app_text.dart';
import 'package:spotify/common/widgets/app_top_bar.dart';
import 'package:spotify/data/models/auth/create_user_request.dart';
import 'package:spotify/presentation/auth/bloc/sign_up_cubit.dart';
import 'package:spotify/presentation/auth/bloc/sign_up_state.dart';
import 'package:spotify/presentation/auth/pages/sign_in.dart';
import 'package:spotify/presentation/root/pages/root.dart';
import '../../../common/helpers/throttle_utils.dart';
import '../../../core/configs/asset/app_vectors.dart';
import '../../../core/configs/theme/app_colors.dart';

class SignUpPage extends StatelessWidget {

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  SignUpPage({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: SvgPicture.asset(AppVectors.logo, width: 36, height: 36)),
      bottomNavigationBar: _signInText(context),
      body: BlocProvider(
        create: (context) => SignUpCubit(),
        child: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            // Sign Up Error
            if (state is SignUpError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
            // Sign Up Success
            if (state is SignUpSuccess) {
              context.pushAndRemoveUntil(const RootPage());
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                // Default state
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsetsGeometry.symmetric(vertical: 50, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _registerText(context.adaptiveTextColor),   // Register text
                        const SizedBox(height: 50),                 // Spacer
                        _fullNameField(context),                    // Name text field
                        const SizedBox(height: 20),                 // Spacer
                        _emailField(context),                       // Email text field
                        const SizedBox(height: 20),                 // Spacer
                        _passwordField(context),                    // Password text field
                        const SizedBox(height: 20),                 // Spacer
                        _registerBtn(() async {                     // Register btn
                          if (state is! SignUpLoading ) {
                            FocusScope.of(context).unfocus();       // hide keyboard
                            context.read<SignUpCubit>().signUp(
                                params: CreateUserRequest(
                                  username: _fullName.text.trim(),
                                  email: _email.text.trim(),
                                  password: _password.text.trim(),
                                )
                            );
                          }
                        }.throttle())
                      ],
                    ),
                  ),
                ),

                // Sign Up Loading
                if (state is SignUpLoading) AbsorbPointer(child: AppLoading())
              ],
            );
          },
        )
      ),
    );
  }

  Widget _registerText(Color color) {
    return AppText(
      'Register',
      fontWeight: FontWeight.bold,
      fontSize: 24,
      textAlign: TextAlign.center,
      color: color,
    );
  }

  Widget _fullNameField(BuildContext context) {
    return TextField(
      controller: _fullName,
      decoration: const InputDecoration(
          hintText: 'Full Name',
          isDense: true,
          contentPadding: EdgeInsetsGeometry.symmetric(vertical: 20, horizontal: 16)
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: const InputDecoration(
          hintText: 'Enter Email',
          isDense: true,
          contentPadding: EdgeInsetsGeometry.symmetric(vertical: 20, horizontal: 16)
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,
      decoration: const InputDecoration(
          hintText: 'Enter Password',
          isDense: true,
          contentPadding: EdgeInsetsGeometry.symmetric(vertical: 20, horizontal: 16)
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _signInText(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
                'Do you have an account?',
              fontWeight: FontWeight.w500,
              color: context.adaptiveTextColor,
            ),
            TextButton(
                onPressed: (){ context.pushReplacement(SignInPage()); },
                child: const Text('Sign In',
                    style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)
                )
            )
          ],
        ),
      ),
    );
  }

  Widget _registerBtn(VoidCallback onPressed) {
    return AppButton(
        onPressed: onPressed,
        title: 'Create Account',
        fontSize: 16
    );
  }
}
