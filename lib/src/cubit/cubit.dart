import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math show Random;

const names = ["Foo", "Bar", 'Bar'];

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}

// cubit requires an intial state which can null or any value asssigned to it
class NamesCubit extends Cubit<String?> {
  NamesCubit() : super(null);

  // this function helps to produce a new state using the emit method
  void pickRandomName() => emit(names.getRandomElement());
}
