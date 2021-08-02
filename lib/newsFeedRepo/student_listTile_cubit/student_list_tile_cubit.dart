import 'package:bloc/bloc.dart';

class StudentListTileCubit extends Cubit<bool> {
  StudentListTileCubit() : super(false);

  void updateStudentCheckBox(bool currentValue) => emit(currentValue);
}
