part of 'feed_category_bloc.dart';

@immutable
abstract class FeedCategoryState {}

class FeedCategoryInitial extends FeedCategoryState {}

class StudentFeedState extends FeedCategoryState{}

class CommonPostState extends FeedCategoryState{}

class TeacherPost extends FeedCategoryState{}
