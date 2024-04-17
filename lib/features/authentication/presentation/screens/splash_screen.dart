import 'package:flutter/material.dart';
import 'package:horsehouse/core/utils/app_sizes.dart';
import 'package:horsehouse/features/authentication/presentation/component/logo_component.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/status_bar_manager.dart';
import '../controllers/splash_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    StatusBarManager.setTransparentWithNormalIconColor(context: context);
    return ChangeNotifierProvider(
      create: (context) => SplashProvider(vsync: this),
      child: Consumer<SplashProvider>(
        builder: (context, provider, child) => Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: SafeArea(
            child: FadeTransition(
              opacity: provider.animation,
              child: SizedBox(
                width: AppSizes.widthFullScreen,
                child: const Center(child: LogoComponent()),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
