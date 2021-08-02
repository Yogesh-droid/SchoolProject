import 'package:bloc/bloc.dart';

class SwitchCubit extends Cubit<int> {
  SwitchCubit() : super(0);

  void updateSwitch(int i) => emit(i);
}
