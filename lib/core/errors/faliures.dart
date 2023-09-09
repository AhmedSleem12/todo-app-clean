import 'package:equatable/equatable.dart';

abstract class Faliure extends Equatable {}

class EmptyCacheFaliure extends Faliure {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ServerFaliure extends Faliure {
  @override
  List<Object?> get props => throw UnimplementedError();
}
