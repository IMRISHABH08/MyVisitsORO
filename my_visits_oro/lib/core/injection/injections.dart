// REGISTER-SERIVCES
import 'package:get_it/get_it.dart';
import 'package:unicards/features/my_visits/data/data_source/my_visit_data_source.dart';
import 'package:unicards/features/my_visits/data/repository_impl/my_visit_repository_impl.dart';
import 'package:unicards/features/my_visits/domain/repository/my_visit_repository.dart';

import '../../features/my_visits/domain/usecase/my_visits_usecase.dart';

void registerOnAppStartUpServices() {
  _registerServices();
}

// LIST ALL THE SERVICES TO BE REGISTERED
void _registerServices() {
  _initMyVisits();
}

void _initMyVisits() {
  GetIt.I.registerLazySingleton<MyVisitUsecase>(
      () => MyVisitUsecaseImpl(repository: GetIt.I.get()));
  GetIt.I.registerLazySingleton<MyVisitRepository>(
      () => MyVisitRepositoryImpl(dataSource: GetIt.I.get()));
  GetIt.I
      .registerLazySingleton<MyVisitDataSource>(() => MyVisitDataSourceImpl());
}

//UN-REGISTER SERVICES
void unRegisterOnAppClosedServices() {
  _unRegisterServices();
}

//LIST ALL THE SERVICES TO BE UN-REGISTERED
void _unRegisterServices() {
  _unRegisterMyVisits();
}

void _unRegisterMyVisits() {
  _unregister<MyVisitUsecase>();
  _unregister<MyVisitRepository>();
  _unregister<MyVisitDataSource>();
}

void _unregister<T extends Object>({String? instanceName}) {
  if (GetIt.I.isRegistered<T>(instanceName: instanceName)) {
    GetIt.I.unregister<T>(instanceName: instanceName);
  }
}
