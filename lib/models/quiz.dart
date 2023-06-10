import 'package:quiz_app/models/question.dart';

class Quiz {
  int? id;
  String? name;
  int? totalHour;
  int? totalMin;
  List<Question>? questions;
  double? rating;

  Quiz({
    this.id,
    this.name,
    this.totalHour,
    this.totalMin,
    this.rating,
    this.questions,
  });
}
