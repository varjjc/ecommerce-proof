import 'package:flutter/material.dart';
import '../../domain/entities/category.dart';
import 'package:go_router/go_router.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  String formatImageName(String name) {
  return name
      .toLowerCase()
      .replaceAll("'", "")
      .replaceAll(" ", "_");
}


  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
          final formatted = formatImageName(category.name);
          context.go('/products/$formatted');
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 160,
              width: 160,
              child: ClipOval(
                child: Container(
                  color: Colors.grey[200],
                  child: Image.asset(
                    'assets/${formatImageName(category.name)}.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              category.name[0].toUpperCase() + category.name.substring(1),
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
