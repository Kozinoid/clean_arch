import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable{
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchPersonsEvent extends SearchEvent{
  const SearchPersonsEvent({required this.personQuery});

  final String personQuery;
  @override
  List<Object?> get props => super.props;
}

