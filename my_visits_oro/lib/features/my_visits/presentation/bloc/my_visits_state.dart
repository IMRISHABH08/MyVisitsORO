part of 'my_visits_bloc.dart';

typedef Filters = (VisitType?, VisitStatus?);

class MyVisitsState {
  const MyVisitsState(
    this.allVisits, {
    this.selectedFilter = const (null, null),
  });

  final List<UserCard> allVisits;
  final Filters selectedFilter;

  MyVisitsState copywith({
    List<UserCard>? allVisits,
    Filters? selectedFilter,
  }) {
    return MyVisitsState(
      allVisits ?? this.allVisits,
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }
}
