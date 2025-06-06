import 'package:flutter_bloc/flutter_bloc.dart';

class ExpressModeCubit extends Cubit<bool> {
  ExpressModeCubit() : super(false);

  void toggle() {
    emit(!state); // 🔁 switchea siempre para pruebas
  }

  void enable() => emit(true);
  void disable() => emit(false);
}
