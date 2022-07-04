import 'package:clean_arch/features/presentation/bloc/person_list_cubit/person_list_state.dart';
import 'package:clean_arch/features/presentation/bloc/sreach_bloc/search_bloc.dart';
import 'package:clean_arch/features/presentation/bloc/sreach_bloc/search_event.dart';
import 'package:clean_arch/features/presentation/bloc/sreach_bloc/search_state.dart';
import 'package:clean_arch/features/presentation/widgets/person_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSearchDelegate extends SearchDelegate {

  CustomSearchDelegate() : super(searchFieldLabel: 'Search for characters');

  final suggestions = [
    'Rick',
    'Morty',
    'Summer',
    'Beth',
    'Jerry'
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: (){
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    BlocProvider.of<PersonSearchBloc>(context, listen: false).add(SearchPersonsEvent(personQuery: query));
    //context.read<PersonSearchBloc>().add(SearchPersonsEvent(personQuery: query));
    return BlocBuilder<PersonSearchBloc, SearchState>(
        builder: (context, state){
          if (state is SearchLoadingState){
            return const Center(child: CircularProgressIndicator(),);
          }else if (state is SearchLoadedState) {
            final personList = state.persons;
            return ListView.separated(
                itemCount: personList.isNotEmpty ? personList.length : 0,
                itemBuilder: (context, index) => PersonCard(person: personList[index],),
              separatorBuilder: (BuildContext context, int index) => const Divider(
                height: 5,
              ),
            );
          }
          else{
            return Container();
          }
        }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.separated(
      itemCount: query.isNotEmpty ? 0 : suggestions.length,
      separatorBuilder: (context, index){
        return const Divider(
          height: 5,
        );
      },
      itemBuilder: (context, index){
        return GestureDetector(
          onTap: (){
            query = suggestions[index];
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(suggestions[index], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
          ),
        );
      },
    );
  }

}
