import 'package:clean_arch/features/domain/entities/person_entity.dart';
import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable{
  const SearchState();

  @override
  List<Object?> get props => [];
}

class EmptyState extends SearchState{}

class SearchLoadingState extends SearchState{}

class SearchLoadedState extends SearchState{
  final List<PersonEntity> persons;
  const SearchLoadedState({required this.persons});

  @override
  List<Object?> get props => [persons];
}

class SearchErrorState extends SearchState{
  final String message;

  const SearchErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}