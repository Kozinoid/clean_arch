import 'package:clean_arch/core/error/exception.dart';
import 'package:clean_arch/core/error/failure.dart';
import 'package:clean_arch/core/platform/network_info.dart';
import 'package:clean_arch/features/data/datasourses/person_local_data_source.dart';
import 'package:clean_arch/features/data/datasourses/person_remote_data_source.dart';
import 'package:clean_arch/features/data/models/person_model.dart';
import 'package:clean_arch/features/domain/entities/person_entity.dart';
import 'package:clean_arch/features/domain/repository/person.repository.dart';
import 'package:dartz/dartz.dart';

class PersonRepositoryImpl extends PersonRepository {
  PersonRepositoryImpl(
      {required this.personRemoteDataSource,
      required this.personLocalDataSource,
      required this.networkInfo});

  PersonRemoteDataSource personRemoteDataSource;
  PersonLocalDataSource personLocalDataSource;
  NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) async {
    return await _getPersons(() => personRemoteDataSource.getAllPersons(page));
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) async {
    return await _getPersons(() => personRemoteDataSource.searchPerson(query));
  }

  Future<Either<Failure, List<PersonModel>>> _getPersons(Future<List<PersonModel>> Function() getPersons) async {
    if (await networkInfo.isConnected){
      try{
        final remotePersons = await getPersons();
        personLocalDataSource.personToCache(remotePersons);
        return Right(remotePersons);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try{
        final remotePersons = await personLocalDataSource.personFromCache();
        return Right(remotePersons);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
//
// class GetParams{
//   final dynamic params;
//   GetParams({required this.params});
// }