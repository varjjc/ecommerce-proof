import 'package:flutter_bloc/flutter_bloc.dart';

class ExpressModeCubit extends Cubit<bool> {
  ExpressModeCubit() : super(false);

  void toggle() {
    if(isExpressAvailable){
    emit(!state);
    } else{
      print('fuera de horario');}// 🔁 switchea siempre para pruebas
  }

  void enable() => emit(true);
  void disable() => emit(false);

    bool get isExpressAvailable {
    final now = DateTime.now();
    final hour = now.hour;
    print('hora $hour');
    return hour >= 10 && hour < 16; // de 10 a 4 pm
    
  }
}
