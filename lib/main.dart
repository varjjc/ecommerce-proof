import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'features/shop/presentation/screens/category_screen.dart';
import 'features/shop/presentation/screens/products_screen.dart';
import 'features/shop/presentation/cubit/mode_cubit.dart';
import 'features/shop/presentation/blocs/cart/car_bloc.dart';
import 'features/shop/presentation/blocs/express/express_car_bloc.dart';
void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ExpressModeCubit()),
        BlocProvider(create: (_) => CarBloc()),
        BlocProvider(create: (_) => ExpressCarBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const CategoryScreen(),
    ),
    GoRoute(
      path: '/products/:category',
      builder: (context, state) {
        final category = state.pathParameters['category']!;
        return ProductsScreen(categoryName: category);
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      title: 'Ecommerce Clean Bloc',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
