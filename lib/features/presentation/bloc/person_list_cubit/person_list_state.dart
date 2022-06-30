import 'package:clean_arch/features/domain/entities/person_entity.dart';
import 'package:equatable/equatable.dart';

abstract class PersonState extends Equatable{
  @override
  List<Object?> get props => [];
}

class PersonEmptyState extends PersonState{
  @override
  List<Object?> get props => [];
}

class PersonLoadingState extends PersonState{
  final List<PersonEntity> oldPersonList;
  final bool isFirstFetch;

  PersonLoadingState(this.oldPersonList, {this.isFirstFetch = false});

  @override
  List<Object?> get props => [oldPersonList];
}

class PersonLoadedState extends PersonState{
  final List<PersonEntity> personList;

  PersonLoadedState(this.personList);

  @override
  List<Object?> get props => [personList];
}

class PersonErrorState extends PersonState{
  final String message;

  PersonErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}