import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../data/datasources/shop_api_services.dart';
import '../../data/repositories_impl/shop_repository_impl.dart';
import '../../domain/usecases/get_categories.dart';
import '../blocs/category/category_bloc.dart';
import '../blocs/category/category_event.dart';
import '../blocs/category/category_state.dart';
import '../widgets/category_card.dart';


class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoryBloc(
        GetCategories(
          ShopRepositoryImpl(
            ShopApiService(http.Client()),
          ),
        ),
      )..add(LoadCategories()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.yellow[700],
          title: TextField(
            decoration: InputDecoration(
              hintText: 'Busca en tu app',
              prefixIcon: Icon(Icons.search),
              suffixIcon: Icon(Icons.person),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.black,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '¿Cómo quieres recibir tu pedido?',
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(Icons.edit, color: Colors.white),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Grilla cuadrada',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Ver todos',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is CategoryLoaded) {
                      return GridView.builder(
                        itemCount: state.categories.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          final category = state.categories[index];
                          return CategoryCard(category: category);
                        },
                      );
                    } else if (state is CategoryError) {
                      return Center(child: Text("Error: ${state.message}"));
                    }
                    return Container();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
