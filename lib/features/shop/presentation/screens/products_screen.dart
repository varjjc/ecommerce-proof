import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import '../../data/datasources/shop_api_services.dart';
import '../../data/repositories_impl/shop_repository_impl.dart';
import '../../domain/usecases/get_products_by_category.dart';
import '../blocs/product/product_bloc.dart';
import '../blocs/product/product_event.dart';
import '../blocs/product/product_state.dart';
import '../widgets/product_card.dart';
import '../widgets/express_mode_switcher.dart';
import '../../presentation/blocs/cart/car_bloc.dart';
import '../../presentation/blocs/cart/car_state.dart';
import '../../presentation/blocs/express/express_car_bloc.dart';
import '../../presentation/blocs/express/express_car_state.dart';
import '../cubit/mode_cubit.dart';

class ProductsScreen extends StatelessWidget {
  final String categoryName;

  const ProductsScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductBloc(
        GetProductsByCategory(
          ShopRepositoryImpl(
            ShopApiService(http.Client()),
          ),
        ),
      )..add(LoadProductsByCategory(categoryName)),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/'),
          ),
          backgroundColor: Colors.yellow[700],
          title: const TextField(
            decoration: InputDecoration(
              hintText: '¿Qué buscas?',
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
              fillColor: Colors.white,
              filled: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
          actions: [
            const Padding(
              padding: EdgeInsets.only(right: 8),
              child: ExpressModeSwitcher(),
            ),
            BlocBuilder<ExpressModeCubit, bool>(
              builder: (context, isExpress) {
                if (isExpress) {
                  return BlocBuilder<ExpressCarBloc, ExpressCarState>(
                    builder: (context, state) {
                      final count = state.products.length;
                      return _buildCartIcon(count, true);
                    },
                  );
                } else {
                  return BlocBuilder<CarBloc, CarState>(
                    builder: (context, state) {
                      final count = state.products.length;
                      return _buildCartIcon(count, false);
                    },
                  );
                }
              },
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              width: double.infinity,
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.yellow),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Katerine recíbelo en Cra 74 a #27–47 bloque 3...',
                      style: const TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit, color: Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                categoryName.replaceAll("_", " ").toUpperCase(),
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoaded) {
                    return GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: state.products.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.65,
                      ),
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return ProductCard(product: product);
                      },
                    );
                  } else if (state is ProductError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartIcon(int count, bool isExpress) {
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            // Navegar al carrito
          },
        ),
        if (count > 0)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isExpress ? Colors.blue : Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$count',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}