import 'package:ecommerce_clean_bloc/features/shop/presentation/blocs/cart/car_state.dart';
import 'package:ecommerce_clean_bloc/features/shop/presentation/blocs/express/express_car_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product.dart';
import '../../presentation/blocs/cart/car_bloc.dart';
import '../../presentation/blocs/cart/car_event.dart';
import '../../presentation/blocs/express/express_car_bloc.dart';
import '../../presentation/blocs/express/express_car_event.dart';
import '../cubit/mode_cubit.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int normalQuantity = 0;
  int expressQuantity = 0;

  void _addToCart(bool isExpress) {
    if (isExpress) {
      context.read<ExpressCarBloc>().add(AddProductToExpressCar(widget.product));
    } else {
      context.read<CarBloc>().add(AddProductToCar(widget.product));
    }
  }

  void _removeFromCart(bool isExpress) {
    if (isExpress && expressQuantity > 0) {
      context.read<ExpressCarBloc>().add(RemoveProductFromExpressCar(widget.product));
    } else if (!isExpress && normalQuantity > 0) {
      context.read<CarBloc>().add(RemoveProductFromCar(widget.product));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpressModeCubit, bool>(
      builder: (context, isExpress) {
        return BlocBuilder<CarBloc, CarState>(
          builder: (context, cartState) {
            return BlocBuilder<ExpressCarBloc, ExpressCarState>(
              builder: (context, expressState) {
                final quantity = isExpress
                    ? expressState.products
                        .where((p) => p.id == widget.product.id)
                        .length
                    : cartState.products
                        .where((p) => p.id == widget.product.id)
                        .length;

                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: SizedBox(
                    height: 270,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Center(
                          child: Image.network(
                            widget.product.image,
                            height: 100,
                            width: 100,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.product.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("Mililitro a \$3",
                              style: TextStyle(fontSize: 12)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "\$${widget.product.price.toStringAsFixed(0)}",
                            style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (quantity == 0)
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => _addToCart(isExpress),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    isExpress ? Colors.blue : Colors.orange,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                              ),
                              child:
                                  Text(isExpress ? "Comprar" : "Agregar"),
                            ),
                          )
                        else
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () => _removeFromCart(isExpress),
                                  icon: const Icon(Icons.remove_circle_outline),
                                ),
                                Text(
                                  "$quantity",
                                  style: const TextStyle(fontSize: 16),
                                ),
                                IconButton(
                                  onPressed: () => _addToCart(isExpress),
                                  icon: const Icon(Icons.add_circle_outline),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
