import 'package:quiz_app/models/question.dart';

class Quiz {
  int? id;
  String? name;
  int? totalHour;
  int? totalMin;
  List<Question>? questions;
  int? totalPoint;
  double? rating;

  Quiz({
    this.id,
    this.name,
    this.totalHour,
    this.totalMin,
    this.questions,
    this.totalPoint,
    this.rating,
  });

  Quiz.clone(Quiz quiz)
      : this(
          id: quiz.id,
          name: quiz.name,
          totalHour: quiz.totalHour,
          totalMin: quiz.totalMin,
          questions: quiz.questions,
          totalPoint: quiz.totalPoint,
          rating: quiz.rating,
        );

  Quiz.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    totalHour = json['totalHour'];
    totalMin = json['totalMin'];
    if (json['questions'] != null) {
      questions = <Question>[];
      json['questions'].forEach((v) {
        questions!.add(new Question.fromJson(v));
      });
    }
    totalPoint = json['totalPoint'];
    rating = json['rating'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['totalHour'] = this.totalHour;
    data['totalMin'] = this.totalMin;
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    data['totalPoint'] = this.totalPoint;
    data['rating'] = this.rating;
    return data;
  }
}
