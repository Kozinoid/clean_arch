import 'package:clean_arch/features/domain/entities/person_entity.dart';
import 'package:clean_arch/features/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:clean_arch/features/presentation/bloc/person_list_cubit/person_list_state.dart';
import 'package:clean_arch/features/presentation/widgets/person_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonsList extends StatelessWidget {
  PersonsList({Key? key}) : super(key: key);

  final scrollController = ScrollController();
  void _setupScrollController(BuildContext context){
    scrollController.addListener(() {
      if(scrollController.position.atEdge){
        if (scrollController.position.pixels != 0){
          context.read<PersonListCubit>().loadPerson();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _setupScrollController(context);

    return BlocBuilder<PersonListCubit, PersonState>(
        builder: (context, state){
          List<PersonEntity> persons = [];
          bool isLoading = false;

          if(state is PersonLoadingState && state.isFirstFetch){
              return _loadingIndicator();
          }
          else if (state is PersonLoadingState){
            isLoading = true;
          }
          else if (state is PersonLoadedState){
            persons = state.personList;
          }
          else if(state is PersonErrorState){
            return Center(
              child: Text
                (state.message,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 25, color: Colors.white),),
            );
          }
          return ListView.separated(
            controller: scrollController,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: Colors.grey[400],
              );
            },
            itemCount: persons.length + (isLoading ? 1 : 0),
            itemBuilder: (BuildContext context, int index) {
              if (index < persons.length){
                return PersonCard(person: persons[index]);
              }else{
                return _loadingIndicator();
              }
            },

          );
        }
    );
  }
}

Widget _loadingIndicator(){
  return const Padding(
    padding: EdgeInsets.all(8.0),
    child: Center(
      child: CircularProgressIndicator(
      ),
    ),
  );
}
