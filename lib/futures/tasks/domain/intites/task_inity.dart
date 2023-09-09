import 'package:equatable/equatable.dart';

class TaskIn extends Equatable {
  final int? id;
  final String title;
  final String project;
  final String important;
  final String isCheck;

  const TaskIn(this.title, this.project, this.important, this.id, this.isCheck);

  @override
  List<Object?> get props => [title, project, important];
}
