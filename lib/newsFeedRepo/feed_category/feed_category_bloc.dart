import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'feed_category_event.dart';
part 'feed_category_state.dart';

class FeedCategoryBloc extends Bloc<FeedCategoryEvent, FeedCategoryState> {
  FeedCategoryBloc() : super(FeedCategoryInitial());

  @override
  Stream<FeedCategoryState> mapEventToState(FeedCategoryEvent event) async* {
    if(event is PostEvent){
      if(event.post.length > 0){
        switch(event.post){
          case 'Teacher\'s post':
            print('teacher post');
            break;
          case 'Student\'s post':
            break;
          case 'Parents\'s post':
            break;
          case 'Common post':
            break;
        }
      }
    }
  }
}
