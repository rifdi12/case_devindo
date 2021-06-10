part of 'infintelist_bloc.dart';

abstract class InfintelistState extends Equatable {
  const InfintelistState();
}

class InfintelistInitial extends InfintelistState {
  const InfintelistInitial();

  @override
  List<Object> get props => [];
}

class InfinteListLoaded extends InfintelistState {
  final bool hasReachedMax;
  final List<User> user;
  final int lastPage;
  const InfinteListLoaded({this.hasReachedMax, this.user, this.lastPage});
  @override
  List<Object> get props => [hasReachedMax, user, lastPage];
}
