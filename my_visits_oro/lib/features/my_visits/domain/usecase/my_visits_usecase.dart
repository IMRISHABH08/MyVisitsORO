import 'package:unicards/features/my_visits/domain/entity/user_card.dart';

import '../repository/my_visit_repository.dart';

abstract class MyVisitUsecase {
  Future<List<UserCard>> fetchAllVisits({
    required String userID,
  });

  List<UserCard> onSearchUser({required String query});
}

class MyVisitUsecaseImpl implements MyVisitUsecase {
  MyVisitUsecaseImpl({
    required MyVisitRepository repository,
  }) : _repo = repository;

  final MyVisitRepository _repo;

  List<UserCard> _allVisits = [];

  @override
  Future<List<UserCard>> fetchAllVisits({required String userID}) async {
    _allVisits = await _repo.fetchAllVisits(userID: userID);
    return _allVisits;
  }

  @override
  List<UserCard> onSearchUser({required String query}) {
    final filteredList = _allVisits
        .where((visit) =>
            visit.name.toLowerCase().contains(query.toLowerCase()) ||
            visit.visitID.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return filteredList;
  }
}
