import '../../domain/entity/user_card.dart';
import '../../domain/repository/my_visit_repository.dart';
import '../data_source/my_visit_data_source.dart';

class MyVisitRepositoryImpl implements MyVisitRepository {
  const MyVisitRepositoryImpl({required MyVisitDataSource dataSource})
      : _dataSource = dataSource;

  final MyVisitDataSource _dataSource;

  @override
  Future<List<UserCard>> fetchAllVisits({required String userID}) {
    return _dataSource.fetchAllVists(userID: userID);
  }
}
