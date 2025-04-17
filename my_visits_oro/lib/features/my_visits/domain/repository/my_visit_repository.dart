import '../entity/user_card.dart';

abstract class MyVisitRepository {
  Future<List<UserCard>> fetchAllVisits({
    required String userID,
  });
}
