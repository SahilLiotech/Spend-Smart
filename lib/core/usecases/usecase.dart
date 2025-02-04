abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

abstract class NoParams<Type> {
  Future<Type> call();
}
