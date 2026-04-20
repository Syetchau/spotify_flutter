import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/helpers/navigation_utils.dart';
import 'package:spotify/common/widgets/app_button.dart';
import 'package:spotify/common/widgets/app_top_bar.dart';
import '../../../common/widgets/app_loading.dart';
import '../../home/bloc/home_auth_cubit.dart';
import '../../home/bloc/home_auth_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeAuthCubit, HomeAuthState>(
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              appBar: const AppTopBar(title: Text('Profile')),
              body: Center(
                child: AppButton(
                  onPressed: () {
                    context.read<HomeAuthCubit>().signOut();
                  },
                  title: 'Sign Out',
                ),
              ),
            ),

            if (state is AuthLoading) const AppLoading()
          ],
        );
      },
    );
  }
}