// express_mode_switcher.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/mode_cubit.dart';

class ExpressModeSwitcher extends StatelessWidget {
  const ExpressModeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpressModeCubit, bool>(
      builder: (context, isExpress) {
        final isAvailable = context.read<ExpressModeCubit>().isExpressAvailable;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Express'),
            Switch(
              value: isExpress,
              onChanged:  
               isAvailable
                  ? (_) => context.read<ExpressModeCubit>().toggle()
                  : null,
            ),
          ],
        );
      },
    );
  }
}
