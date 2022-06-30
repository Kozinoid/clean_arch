import 'package:clean_arch/core/error/failure.dart';
import 'package:clean_arch/core/usecases/usecase.dart';
import 'package:clean_arch/features/domain/entities/person_entity.dart';
import 'package:clean_arch/features/domain/repository/person.repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetAllPersons extends UseCase<List<PersonEntity>, PagePersonParameter>{
  GetAllPersons(this.personRepository);

  PersonRepository personRepository;

  @override
  Future<Either<Failure, List<PersonEntity>>> call(PagePersonParameter params) async {
    return await personRepository.getAllPersons(params.page);
  }
}

class PagePersonParameter extends Equatable{
  final int page;
  const PagePersonParameter({required this.page});

  @override
  List<Object?> get props => [page];
}