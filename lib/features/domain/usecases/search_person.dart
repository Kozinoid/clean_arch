import 'package:clean_arch/core/error/failure.dart';
import 'package:clean_arch/core/usecases/usecase.dart';
import 'package:clean_arch/features/domain/entities/person_entity.dart';
import 'package:clean_arch/features/domain/repository/person.repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SearchPerson extends UseCase<List<PersonEntity>, QueryPersonParams>{
  SearchPerson(this.personRepository);

  PersonRepository personRepository;

  @override
  Future<Either<Failure, List<PersonEntity>>> call(QueryPersonParams params) async {
    return await personRepository.searchPerson(params.query);
  }
}

class QueryPersonParams extends Equatable{
  final String query;
  const QueryPersonParams({required this.query});

  @override
  List<Object?> get props => [query];
}