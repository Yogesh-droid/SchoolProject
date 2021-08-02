import 'package:bloc/bloc.dart';

class TeacherListTileCubit extends Cubit<bool> {
  TeacherListTileCubit() : super(false);

  void updateTeacherCheckBox(bool currentValue) => emit(currentValue);
}
