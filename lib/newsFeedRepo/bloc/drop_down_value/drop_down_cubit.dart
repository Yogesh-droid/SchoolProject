import 'package:bloc/bloc.dart';


class DropDownCubit extends Cubit<String> {
  DropDownCubit() : super('');

  void updateRoleValue(String role) => emit(role);
}
