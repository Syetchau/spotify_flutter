import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/helpers/navigation_utils.dart';
import 'package:spotify/common/helpers/theme_utils.dart';
import 'package:spotify/common/widgets/app_email_field.dart';
import 'package:spotify/common/widgets/app_password_field.dart';
import 'package:spotify/data/models/auth/sign_in_user_request.dart';
import 'package:spotify/presentation/auth/bloc/sign_in_cubit.dart';
import 'package:spotify/presentation/auth/pages/sign_up.dart';
import '../../../common/helpers/throttle_utils.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/app_loading.dart';
import '../../../common/widgets/app_text.dart';
import '../../../common/widgets/app_top_bar.dart';
import '../../../core/configs/asset/app_vectors.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../root/pages/root.dart';
import '../bloc/sign_in_state.dart';

class SignInPage extends StatelessWidget {

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();    // Validation

  SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: SvgPicture.asset(AppVectors.logo, width: 36, height: 36)),
      bottomNavigationBar: _registerText(context),
      body: BlocProvider(
        create: (context) => SignInCubit(),
        child: BlocConsumer<SignInCubit, SignInState>(
          listener: (context, state) {
            // Sign In Error
            if (state is SignInError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
            // Sign In Success
            if (state is SignInSuccess) {
              context.pushAndRemoveUntil(const RootPage());
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsetsGeometry.symmetric(vertical: 50, horizontal: 30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _signInText(context.adaptiveTextColor),     // Sign In Text
                          const SizedBox(height: 50),                 // Spacer
                          AppEmailField(controller: _email),          // Email text field
                          const SizedBox(height: 20),                 // Spacer
                          AppPasswordField(controller: _password),    // Password
                          const SizedBox(height: 20),                 // Spacer
                          _signInBtn(() {                             // Sign In Button
                            if (state is! SignInLoading ) {
                              if (_formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();     // hide keyboard
                                context.read<SignInCubit>().signIn(
                                    params: SignInUserRequest(
                                        email: _email.text.trim(),
                                        password: _password.text.trim()
                                    )
                                );
                              }
                            }
                          }.throttle())
                        ],
                      ),
                    ),
                  ),
                ),

                // Sign Up Loading
                if (state is SignInLoading) AbsorbPointer(child: AppLoading())
              ],
            );
          },
        ),
      )
    );
  }

  Widget _signInText(Color color) {
    return AppText(
      'Sign In',
      fontWeight: FontWeight.bold,
      fontSize: 24,
      textAlign: TextAlign.center,
      color: color,
    );
  }

  Widget _registerText(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              'Not A Member?',
              fontWeight: FontWeight.w500,
              color: context.adaptiveTextColor,
            ),
            TextButton(
                onPressed: (){ context.pushReplacement(SignUpPage()); },
                child: const Text('Register Now',
                    style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)
                )
            )
          ],
        ),
      ),
    );
  }

  Widget _signInBtn(VoidCallback onPressed) {
    return AppButton(
        onPressed: onPressed,
        title: 'Sign In',
        fontSize: 16
    );
  }
}
