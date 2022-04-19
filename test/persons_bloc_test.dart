import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc_tutorial/src/bloc/bloc_actions.dart';
import 'package:flutter_bloc_tutorial/src/bloc/person.dart';
import 'package:flutter_bloc_tutorial/src/bloc/persons_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

const mockedPersons1 = [
  Person(name: 'Boo 1', age: 30),
  Person(name: 'Baz 1', age: 20),
];

const mockedPersons2 = [
  Person(name: 'Boo 1', age: 30),
  Person(name: 'Baz 1', age: 20),
];

Future<Iterable<Person>> mockGetPersons1(String url) =>
    Future.value(mockedPersons1);

Future<Iterable<Person>> mockGetPersons2(String url) =>
    Future.value(mockedPersons2);

void main() {
  group('Testing Bloc', () {
    late PersonsBloc bloc;
    // setUp is for every test in the group
    setUp(() {
      bloc = PersonsBloc();
    });

    blocTest<PersonsBloc, FetchResult?>(
      'Test initial state',
      build: () => bloc,
      verify: (bloc) => expect(bloc.state, null),
    );

    // fetch mock data (person1) and compare it with FetchResult
    blocTest<PersonsBloc, FetchResult?>(
      'Mock retrieving persons1 from first iterable',
      build: () => bloc,
      act: (bloc) {
        // to test if it is from the url
        bloc.add(const LoadPersonAction(
          url: 'dummy_url_1',
          loader: mockGetPersons1,
        ));
        // to test if it is fetching from cache. the url must be the same thing
        bloc.add(const LoadPersonAction(
          url: 'dummy_url_1',
          loader: mockGetPersons1,
        ));
      },
      expect: () => [
        const FetchResult(
          persons: mockedPersons1,
          isretrievedFromCache: false,
        ),
        const FetchResult(
          persons: mockedPersons1,
          isretrievedFromCache: true,
        ),
      ],
    );

    // fetch mock data (person2) and compare it with FetchResult
    blocTest<PersonsBloc, FetchResult?>(
      'Mock retrieving persons2 from second iterable',
      build: () => bloc,
      act: (bloc) {
        // to test if it is from the url
        bloc.add(const LoadPersonAction(
          url: 'dummy_url_2',
          loader: mockGetPersons2,
        ));
        // to test if it is fetching from cache. the url must be the same thing
        bloc.add(const LoadPersonAction(
          url: 'dummy_url_2',
          loader: mockGetPersons2,
        ));
      },
      expect: () => [
        const FetchResult(
          persons: mockedPersons2,
          isretrievedFromCache: false,
        ),
        const FetchResult(
          persons: mockedPersons2,
          isretrievedFromCache: true,
        ),
      ],
    );
  });
}
