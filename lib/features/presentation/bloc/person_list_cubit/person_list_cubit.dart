import 'package:clean_arch/core/error/failure.dart';
import 'package:clean_arch/features/domain/entities/person_entity.dart';
import 'package:clean_arch/features/domain/usecases/get_all_persons.dart';
import 'package:clean_arch/features/presentation/bloc/person_list_cubit/person_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonListCubit extends Cubit<PersonState>{
  PersonListCubit({required this.getAllPersons}) : super(PersonEmptyState());

  final GetAllPersons getAllPersons;
  int page = 1;

  void loadPerson()async{
    final currentState = state;

    if (currentState is PersonLoadingState) return;

    var oldPersonList = <PersonEntity>[];
    if (currentState is PersonLoadedState) {
      oldPersonList = currentState.personList;
    }

    emit(PersonLoadingState(oldPersonList, isFirstFetch: page == 1));

    final failOrPerson = await getAllPersons(PagePersonParameter(page: page));
    failOrPerson.fold(
            (failure) => emit(PersonErrorState(message: _mapFailureToMessage(failure))),
            (characters) {
              page++;
              final persons = (state as PersonLoadingState).oldPersonList;
              persons.addAll(characters);
              emit(PersonLoadedState(persons));
            }
    );
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