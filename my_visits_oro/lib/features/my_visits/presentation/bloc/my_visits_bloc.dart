import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/user_card.dart';
import '../../domain/usecase/my_visits_usecase.dart';
part 'my_visits_event.dart';
part 'my_visits_state.dart';

class MyVisitsBloc extends Bloc<MyVisitsEvent, MyVisitsState> {
  MyVisitsBloc({required MyVisitUsecase usecase})
      : _uasecase = usecase,
        super(const MyVisitsState([])) {
    on<FecthAllVisitsEvent>(_fetchAllVisits);
    on<OnFilterEvent>(_onFilterSelect);
    _oninit();
  }

  // VARIABLES
  final MyVisitUsecase _uasecase;

  // GETTERS
  static get _userID => 'Uidbwub12';

  List<UserCard> get getAllVisits => (state).allVisits;

  VisitType? get selectedVisitType => state.selectedFilter.$1;

  VisitStatus? get selectedVisitStatus => state.selectedFilter.$2;

  bool get isVisitTypeSelected => (state.selectedFilter.$1 != null);

  bool get isVisitStatusSelected => (state.selectedFilter.$2 != null);

  bool get isAllFiltersSelected => isVisitTypeSelected && isVisitStatusSelected;

  void _oninit() {
    add(FecthAllVisitsEvent(userID: _userID));
  }

  void _onFilterSelect(
    OnFilterEvent event,
    Emitter<MyVisitsState> emit,
  ) {
    final selectedFilter = event.filters;
    var isSelected = selectedFilter.$1 != null || selectedFilter.$2 != null;
    if (isSelected) {
      emit(state
          .copywith(selectedFilter: (selectedFilter.$1, selectedFilter.$2)));
    }
  }

  Future<void> _fetchAllVisits(
    FecthAllVisitsEvent event,
    Emitter<MyVisitsState> emit,
  ) async {
    emit(const MyVisitsState([]));
    try {
      final allVisits = await _uasecase.fetchAllVisits(userID: event.userID);
      emit(MyVisitsState(allVisits));
    } catch (e) {
      emit(const MyVisitsState([]));
    }
  }

  List<UserCard> get filteredData {
    List<UserCard> filteredList = getAllVisits;
    if (isAllFiltersSelected) {
      filteredList = getAllVisits
          .where((v) =>
              v.visitType == selectedVisitType &&
              v.visitStatus == selectedVisitStatus)
          .toList();
    } else if (isVisitTypeSelected) {
      filteredList =
          getAllVisits.where((v) => v.visitType == selectedVisitType).toList();
    } else if (isVisitStatusSelected) {
      filteredList = getAllVisits
          .where((v) => v.visitStatus == selectedVisitStatus)
          .toList();
    }
    return filteredList;
  }

  List<UserCard> onSearch(String query) {
    return _uasecase.onSearchUser(query: query);
  }
}
