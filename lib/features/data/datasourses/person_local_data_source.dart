import 'dart:convert';

import 'package:clean_arch/core/error/exception.dart';
import 'package:clean_arch/features/data/models/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersonLocalDataSource{
  Future<List<PersonModel>> personFromCache();
  Future<void> personToCache(List<PersonModel> persons);
}

const String CACHED_PERSONS_LIST = 'CACHED_PERSONS_LIST';
class PersonLocalDataSourceImpl extends PersonLocalDataSource{
  final SharedPreferences sharedPreferences;
  PersonLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<PersonModel>> personFromCache() {
    final List<String> personJsonList = sharedPreferences.getStringList(CACHED_PERSONS_LIST) ?? [];
    if (personJsonList.isNotEmpty){
      return Future.value(personJsonList.map((personString) => PersonModel.fromJson(json.decode(personString))).toList());
    } else{
      throw CacheException();
    }
  }

  @override
  Future<void> personToCache(List<PersonModel> persons) {
    final List<String> personJsonList = persons.map((person) => json.encode(person.toJson())).toList();
    return Future(() => sharedPreferences.setStringList(CACHED_PERSONS_LIST, personJsonList));
  }
}