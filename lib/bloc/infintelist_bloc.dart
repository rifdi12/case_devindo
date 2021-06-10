import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:case_devindo/model/user.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'infintelist_event.dart';
part 'infintelist_state.dart';

class InfintelistBloc extends Bloc<InfintelistEvent, InfintelistState> {
  InfintelistBloc() : super(InfintelistInitial());

  @override
  Stream<InfintelistState> mapEventToState(
    InfintelistEvent event,
  ) async* {
    if (event is InfinteListEventInit) {
      yield InfintelistInitial();
      Dio dio = Dio();
      List<User> model = <User>[];
      Response response = await dio
          .get('https://jsonplaceholder.typicode.com/posts?_start=0&_limit=20');
      for (var item in response.data) {
        User user = User.fromJson(item);
        model.add(user);
      }
      yield InfinteListLoaded(hasReachedMax: false, lastPage: 20, user: model);
    }

    if (event is InfinteListLazyLoad && state is InfinteListLoaded) {
      Dio dio = Dio();
      List<User> model = state.props[1];
      Response response = await dio.get(
          'https://jsonplaceholder.typicode.com/posts?_start=${state.props[2]}&_limit=10');
      for (var item in response.data) {
        User user = User.fromJson(item);
        model.add(user);
      }
      int lastPage = state.props[2] as int;
      yield InfinteListLoaded(
          hasReachedMax: false, lastPage: lastPage + 10, user: model);
    }
  }
}
