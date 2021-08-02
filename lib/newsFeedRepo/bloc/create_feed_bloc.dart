import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_feed_event.dart';
part 'create_feed_state.dart';

class CreateFeedBloc extends Bloc<CreateFeedEvent, CreateFeedState> {
  CreateFeedBloc() : super(CreateFeedInitial());

  @override
  Stream<CreateFeedState> mapEventToState(
    CreateFeedEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
