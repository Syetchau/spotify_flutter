import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/helpers/navigation_utils.dart';
import 'package:spotify/core/configs/asset/app_vectors.dart';
import 'package:spotify/presentation/intro/pages/get_started.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: SvgPicture.asset(AppVectors.logo)));
  }

  Future<void> redirect() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    context.pushReplacement(const GetStartedPage());
  }
}
