import 'dart:async';

import 'package:app/utils/modal/newsFeedModels/categories_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'category_list_event.dart';
part 'category_list_state.dart';

class CategoryListBloc extends Bloc<CategoryListEvent, CategoryListState> {
  CategoryListBloc() : super(CategoryListInitial());
  
  CategoriesModel studentModel = CategoriesModel(title : 'Students',id: 0);
  CategoriesModel teachersModel = CategoriesModel(title : 'All Teachers',id: 13);
  List<CategoriesModel> classList = List.generate(12, (index) => CategoriesModel(title : 'class ${index+1}',id: index+1));

  @override
  Stream<CategoryListState> mapEventToState(CategoryListEvent event) async* {
    /*if(event is TeacherPostEvent){
      
    }
    if(event is StudentPostEvent){
      
    }
    if(event is CommonPostEvent){
      yield CommonPostState(allList: classList,studentModel: studentModel,teacherModel: teachersModel);
    }
    if(event is StudentPostUpdate){
      
    }
    if(event is TeacherPostUpdate){
      
    }*/
    if(event is PostEvent){
      switch(event.type){
        case 'Teacher\'s post':
          yield TeacherPostState(teachersModel);
          break;
        case 'Student\'s post':
          yield StudentPostState(studentModel,classList);
          break;
        case 'Parents\'s post':
          break;
        case 'Common post':
          yield CommonPostState(allList: classList,studentModel: studentModel,teacherModel: teachersModel);
          break;
      }
    }
    if(event is UpdateValue){
      if(event.id == studentModel.id){
        classList.forEach((element) {
          element.value = event.value;
        });
        studentModel.value = event.value;
        yield StudentPostState(studentModel,classList);
      }else if(event.id == teachersModel.id){
        teachersModel.value = event.value;
        yield TeacherPostState(teachersModel);
      }else{
        classList.forEach((element) {
          if(element.id == event.id){
            element.value = event.value;
            studentModel.value =
                classList.every((element) => element.value);
          }
        });
        yield StudentPostState(studentModel,classList);
      }
    }
  }
}
