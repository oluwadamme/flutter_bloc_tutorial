import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_tutorial/src/bloc/person.dart';

const persons1Url =
    'http://127.0.0.1:5500/flutter_bloc_tutorial/lib/src/api/persons1.json';

const persons2Url =
    'http://127.0.0.1:5500/flutter_bloc_tutorial/lib/src/api/person2.json';

typedef PersonLoader = Future<Iterable<Person>> Function(String url);

// An action is an input to our Bloc
@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class LoadPersonAction implements LoadAction {
  final String url;
  final PersonLoader loader;
  const LoadPersonAction({
    required this.url,
    required this.loader,
  }) : super();
}
