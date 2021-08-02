part of 'feed_category_bloc.dart';

@immutable
abstract class FeedCategoryEvent {}

class PostEvent extends FeedCategoryEvent{
  final String post;

  PostEvent(this.post);
}
