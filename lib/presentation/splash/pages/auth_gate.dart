import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/presentation/splash/pages/splash.dart';
import '../../intro/pages/get_started.dart';
import '../../root/bloc/root_auth_cubit.dart';
import '../../root/bloc/root_auth_state.dart';
import '../../root/pages/root.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RootAuthCubit(),
      child: BlocConsumer<RootAuthCubit, RootAuthState>(
        listener: (context, state) {
          // Unauthenticated failed
          if (state is Unauthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, authState) {
          // If the Cubit hasn't finished the 2s timer, stay on Splash
          if (authState is AuthInitial) {
            return const SplashPage();
          } else {
            return StreamBuilder<User?>(
              stream: FirebaseAuth.instance.idTokenChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null || authState is AuthLoading) {
                  return const RootPage();
                } else {
                  return const GetStartedPage();
                }
              },
            );
          }
        },
      ),
    );
  }
}