import 'dart:convert';

import 'package:clean_arch/core/error/exception.dart';
import 'package:clean_arch/features/data/models/person_model.dart';
import 'package:http/http.dart' as http;

abstract class PersonRemoteDataSource{
  /// https://rickandmortyapi.com/api/character/?page=1
  Future<List<PersonModel>> getAllPersons(int page);

  /// https://rickandmortyapi.com/api/character/?name=rick
  Future<List<PersonModel>>  searchPerson(String query);
}

class PersonRemoteDataSourceImpl extends PersonRemoteDataSource {
  PersonRemoteDataSourceImpl({required this.client});
  final http.Client client;

  @override
  Future<List<PersonModel>> getAllPersons(int page) => _getPersonList('https://rickandmortyapi.com/api/character/?page=$page');

  @override
  Future<List<PersonModel>> searchPerson(String query) => _getPersonList('https://rickandmortyapi.com/api/character/?name=$query');

  Future<List<PersonModel>> _getPersonList(String url, ) async {
    var response = await client.get(Uri.parse(url),
        headers: {'Content-Type' : 'application/json'});

    if (response.statusCode == 200){
      final persons = json.decode(response.body);
      return (persons['results'] as List).map((json) => PersonModel.fromJson(json)).toList();
    } else{
      throw ServerException();
    }
  }
}

