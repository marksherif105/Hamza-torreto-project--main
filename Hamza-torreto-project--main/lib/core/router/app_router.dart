import 'package:eshop_project/core/router/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/injection_container.dart';

import '../../features/OnBoarding/screens/on_boarding_screen.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/sign_up_page.dart';
import '../../features/auth/presentation/pages/verification_page.dart';

import '../../features/products/presentation/pages/products_page.dart';
import '../../features/products/presentation/pages/product_details_page.dart';
import '../../features/products/presentation/pages/settings.dart';

import '../../features/cart/presentation/pages/cart_screen.dart';
import '../../features/splashScreen/screens/splashScreen.dart';
import '../../features/bottomNavBar/screens/layout.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/',

    routes: [
      GoRoute(
        path: '/',
        name: Routes.splashScreen,
        builder: (context, state) {
          return SplashScreen(
            localStorage: InjectionContainer.createLocalStorage(),
          );
        },
      ),

      GoRoute(
        path: '/OnBoarding',
        name: Routes.onBoarding,
        builder: (context, state) {
          return OnboardingScreen(
            localStorage: InjectionContainer.createLocalStorage(),
          );
        },
      ),

      GoRoute(
        path: '/login',
        name: Routes.loginScreen,
        builder: (context, state) => const LoginPage(),
      ),

      GoRoute(
        path: '/sign-up',
        name: Routes.signUpScreen,
        builder: (context, state) => const SignUpPage(),
      ),

      GoRoute(
        path: '/verification',
        builder: (context, state) {
          final email = state.extra as String;

          return VerificationPage(email: email);
        },
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainLayout(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/products',
                name: Routes.productScreen,
                builder: (context, state) => const ProductsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/cart',
                name: Routes.cartScreen,
                builder: (context, state) => const CartScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                name: Routes.settingsScreen,
                builder: (context, state) => const Settings(),
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        path: '/product-details/:id',
        name: Routes.productDetailsScreen,
        builder: (context, state) {
          final id = state.pathParameters['id']!;

          return BlocProvider(
            create: (context) => InjectionContainer.createCartCubit(),

            child: ProductDetailsPage(productId: id),
          );
        },
      ),
    ],
  );
}
