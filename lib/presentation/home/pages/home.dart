import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/helpers/navigation_utils.dart';
import 'package:spotify/common/widgets/app_top_bar.dart';
import 'package:spotify/core/configs/asset/app_images.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/presentation/profile/pages/profile.dart';
import '../../../common/widgets/app_loading.dart';
import '../../../core/configs/asset/app_vectors.dart';
import '../bloc/home_auth_cubit.dart';
import '../bloc/home_auth_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<HomeAuthCubit>().checkAuthStatus();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // User just returned to the app, check if they are still valid
    if (state == AppLifecycleState.resumed) {
      context.read<HomeAuthCubit>().checkAuthStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeAuthCubit, HomeAuthState>(
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppTopBar(
                title: SvgPicture.asset(AppVectors.logo, width: 36, height: 36),
                isHideBackBtn: true,
                actions: [
                  IconButton(
                      onPressed: () { context.push(const ProfilePage()); },
                      icon: Icon(Icons.settings, color: AppColors.grey)
                  )
                ],
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _homeArtistCard(),
                      const SizedBox(height: 20),
                      // GestureDetector(
                      //     onTap: () { context.read<HomeAuthCubit>().signOut(); },
                      //     child: const Text("Sign out"))
                    ],
                  ),
                ),
              ),
            ),

            if (state is AuthLoading) const AppLoading(),
          ],
        );
      },
    );
  }

  Widget _homeArtistCard() {
    return Center(
      child: SizedBox(
        height: 150,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: SvgPicture.asset(AppVectors.homeTopCard)
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 60),
                  child: Image.asset(AppImages.homeArtist),
                )
            )
          ],
        ),
      ),
    );
  }
}