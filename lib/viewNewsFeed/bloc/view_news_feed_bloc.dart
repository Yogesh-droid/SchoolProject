import 'dart:async';
import 'dart:convert';

import 'package:app/viewNewsFeed/model/viewNewsFeedResponse.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'view_news_feed_event.dart';
part 'view_news_feed_state.dart';

class ViewNewsFeedBloc extends Bloc<ViewNewsFeedEvent, ViewNewsFeedState> {
  ViewNewsFeedBloc() : super(ViewNewsFeedInitial());

  @override
  Stream<ViewNewsFeedState> mapEventToState(ViewNewsFeedEvent event) async* {
    if(event is ViewNewsFeed){
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var token = await sharedPreferences.get('bearer_token');
      try{
        print("Bearer "+token);
        var response = await http.get("http://ahaschool.in/api/forum",
        headers: {
          "Authorization":"Bearer "+token,
        });/*.then((value) {
          print(value.request.headers);
          print(value.body);
        });*/
        if (response.statusCode == 200) {
          ViewNewsFeedResponse viewNewsFeedResponse = ViewNewsFeedResponse.fromJson(jsonDecode(response.body));
          yield ViewAllNewsFeed(viewNewsFeedResponse);
        }
        else {
          print('=============================================${response.reasonPhrase}');
        }
      }catch(e){
        print('=================================${e.toString()}');
      }
    }
  }
}
