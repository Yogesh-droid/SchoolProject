part of 'view_news_feed_bloc.dart';

@immutable
abstract class ViewNewsFeedState {}

class ViewNewsFeedInitial extends ViewNewsFeedState {}

class ViewAllNewsFeed extends ViewNewsFeedState{
  final ViewNewsFeedResponse response;

  ViewAllNewsFeed(this.response);
}
