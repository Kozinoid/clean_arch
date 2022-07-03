import 'package:clean_arch/core/error/failure.dart';
import 'package:clean_arch/features/domain/usecases/search_person.dart';
import 'package:clean_arch/features/presentation/bloc/sreach_bloc/search_event.dart';
import 'package:clean_arch/features/presentation/bloc/sreach_bloc/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonSearchBloc extends Bloc<SearchEvent, SearchState>{

  final SearchPerson searchPerson;

  PersonSearchBloc({required this.searchPerson}) : super(EmptyState()){

    on((event, emit) async {
      if (event is SearchPersonsEvent){
        emit(SearchLoadingState());
        final failureOrPerson = await searchPerson.call(QueryPersonParams(query: event.personQuery));
        emit(failureOrPerson.fold(
                (failure) => SearchErrorState(message: _mapFailureToMessage(failure)),
                (persons) => SearchLoadedState(persons: persons))
        );
      }
    });
  }

  String _mapFailureToMessage(Failure failure){
    switch(failure.runtimeType){
      case ServerFailure:
        return 'Server failure';
      case CacheFailure:
        return 'Cache failure';
      default:
        return 'Unexpected error';
    }
  }
}