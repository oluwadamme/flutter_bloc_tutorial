import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_tutorial/src/bloc/bloc_actions.dart';
import 'package:flutter_bloc_tutorial/src/bloc/person.dart';

@immutable
class FetchResult {
  final Iterable<Person> persons;
  final bool isretrievedFromCache;

  const FetchResult({
    required this.persons,
    required this.isretrievedFromCache,
  });

  @override
  String toString() =>
      'FetchResult (isretrievedFromCache = $isretrievedFromCache, persons = $persons)';

  @override
  bool operator ==(covariant FetchResult other) =>
      persons.isEqualToIgnoringOrdering(other.persons) &&
      isretrievedFromCache == other.isretrievedFromCache;

  @override
  int get hashCode => Object.hash(persons, isretrievedFromCache);
}

class PersonsBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<String, Iterable<Person>> _cache = {};
  PersonsBloc() : super(null) {
    on<LoadPersonAction>((event, emit) async {
      final url = event.url;
      if (_cache.containsKey(url)) {
        final cacahedPersons = _cache[url]!;
        final result = FetchResult(
          persons: cacahedPersons,
          isretrievedFromCache: true,
        );
        emit(result);
      } else {
        final loader = event.loader;
        final persons = await loader(url);
        _cache[url] = persons;
        final result = FetchResult(
          persons: persons,
          isretrievedFromCache: false,
        );
        emit(result);
      }
    });
  }
}

extension IsEqualToIgnoringOrdering<T> on Iterable<T> {
  bool isEqualToIgnoringOrdering(Iterable<T> other) =>
      length == other.length &&
      {...this}.intersection({...other}).length == length;
}
