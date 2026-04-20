import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/presentation/splash/pages/splash.dart';
import '../../../service/service_locator.dart';
import '../../intro/pages/get_started.dart';
import '../../root/bloc/root_auth_cubit.dart';
import '../../root/bloc/root_auth_state.dart';
import '../../root/pages/root.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => service<RootAuthCubit>(),
      child: BlocConsumer<RootAuthCubit, RootAuthState>(
        listener: (context, state) {
          if (state is Unauthenticated && state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.errorMessage),
                  behavior: SnackBarBehavior.floating
              ),
            );
          }
        },
        // Use 'buildWhen' to ensure only rebuild the main screen
        // when the specific auth-defining states change.
        buildWhen: (previous, current) =>
        current is AuthInitial ||
            current is AuthAppReady ||
            current is Unauthenticated ||
            current is SignOutSuccess,
        builder: (context, authState) {
          // Keep Splash visible until the Cubit finishes the 2s timer
          if (authState is AuthInitial) return const SplashPage();
          if (authState is AuthAppReady) return const RootPage();
          return const GetStartedPage(); // Fallback for Unauthenticated / SignOutSuccess
        },
      ),
    );
  }
}