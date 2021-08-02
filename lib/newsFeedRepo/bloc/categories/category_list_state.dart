part of 'category_list_bloc.dart';

@immutable
abstract class CategoryListState {}

class CategoryListInitial extends CategoryListState {}

class CommonPostState extends CategoryListState{
  final List<CategoriesModel> allList;
  final CategoriesModel studentModel,teacherModel;

  CommonPostState({this.allList,this.studentModel,this.teacherModel});
}
class TeacherPostState extends CategoryListState{
  final CategoriesModel teacherModel;

  TeacherPostState(this.teacherModel);
}
class StudentPostState extends CategoryListState{
  final CategoriesModel studentModel;
  final List<CategoriesModel> allList;

  StudentPostState(this.studentModel,this.allList);
}
