import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constant/local_keys.dart';
import '../../../core/local_storage/base_local_storage.dart';
import '../../../core/router/routes.dart';
import '../../../core/utils/app_assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this._localStorage});

  final BaseLocalStorage _localStorage;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> navigate() async {
    final bool? isOpen = await widget._localStorage.getBool(LocalKeys.isOpen);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    
    if (isOpen == null) {
      context.goNamed(Routes.onBoarding);
    } else {
      context.goNamed(Routes.productScreen);
    }
  }

  @override
  void initState() {
    navigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          AppAssets.logo,
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}