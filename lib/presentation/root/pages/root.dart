import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/widgets/app_loading.dart';
import '../bloc/root_auth_cubit.dart';
import '../bloc/root_auth_state.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<RootAuthCubit>().checkAuthStatus();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // User just returned to the app, check if they are still valid
    if (state == AppLifecycleState.resumed)     {
      context.read<RootAuthCubit>().checkAuthStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RootAuthCubit, RootAuthState>(
      builder: (context, state) {
        return Stack(
          children: [
            const Scaffold(
              body: Center(child: Text("Welcome to Spotify")),
            ),

            if (state is AuthLoading) const AppLoading(),
          ],
        );
      },
    );
  }
}