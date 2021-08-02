part of 'category_list_bloc.dart';

@immutable
abstract class CategoryListEvent {}

class TeacherPostEvent extends CategoryListEvent {}

class PostEvent extends CategoryListEvent{
  final String type;
  PostEvent(this.type);
}

class UpdateValue extends CategoryListEvent{
  final bool value;
  final int id;
  UpdateValue({this.value,this.id});
}

/*class StudentPostEvent extends CategoryListEvent{}

class CommonPostEvent extends CategoryListEvent{}

class TeacherPostUpdate extends CategoryListEvent{}

class StudentPostUpdate extends CategoryListEvent{}*/

