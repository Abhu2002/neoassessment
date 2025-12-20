// To parse this JSON data, do
//
//     final questionCatEntity = questionCatEntityFromJson(jsonString);

import 'package:equatable/equatable.dart';

class QuestionCatEntity extends Equatable {
  final int? id;
  final int? domainId;
  final String? name;
  final String? description;

  const QuestionCatEntity({
    this.id,
    this.domainId,
    this.name,
    this.description,
  });

  @override
  List<Object?> get props => [id, domainId, name, description];
}
