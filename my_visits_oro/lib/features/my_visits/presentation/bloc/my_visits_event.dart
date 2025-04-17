part of 'my_visits_bloc.dart';

sealed class MyVisitsEvent {
  const MyVisitsEvent();
}

final class FecthAllVisitsEvent extends MyVisitsEvent {
  const FecthAllVisitsEvent({required this.userID});

  final String userID;
}

final class OnSearchEvent extends MyVisitsEvent {
  const OnSearchEvent({required this.searchText});

  final String searchText;
}

final class OnFilterEvent extends MyVisitsEvent {
  const OnFilterEvent({required this.filters});

  final Filters filters;
}
