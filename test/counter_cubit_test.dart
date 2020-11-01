import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc_cubit/counter_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  CounterCubit counterCubit;

  setUp(() {
    counterCubit = CounterCubit(0);
  });

  tearDown(() {
    counterCubit?.close();
  });

  blocTest(
    'pastikan fungsi increment bisa melakukan pertambahan 1',
    build: () {
      return counterCubit;
    },
    act: (cubit) {
      return cubit.increment();
    },
    expect: [1],
  );

  blocTest(
    'pastikan fungsi decrement bisa melakukan pengurangan 1',
    build: () {
      return counterCubit;
    },
    act: (cubit) {
      return cubit.decrement();
    },
    expect: [-1],
  );
}
