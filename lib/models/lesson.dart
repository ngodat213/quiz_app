import 'package:quiz_app/models/question.dart';

class Lesson {
  int? lessonId;
  int? lessonName;
  String? name;
  int? totalHour;
  int? totalMin;
  int? totalPoint;
  List<Question>? questions;

  Lesson(
      {this.lessonId,
      this.lessonName,
      this.name,
      this.totalHour,
      this.totalMin,
      this.totalPoint,
      this.questions});

  Lesson.fromJson(Map<String, dynamic> json) {
    lessonId = json['lessonId'];
    lessonName = json['lessonName'];
    name = json['name'];
    totalHour = json['totalHour'];
    totalMin = json['totalMin'];
    totalPoint = json['totalPoint'];
    if (json['questions'] != null) {
      questions = <Question>[];
      json['questions'].forEach((v) {
        questions!.add(new Question.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lessonId'] = this.lessonId;
    data['lessonName'] = this.lessonName;
    data['name'] = this.name;
    data['totalHour'] = this.totalHour;
    data['totalMin'] = this.totalMin;
    data['totalPoint'] = this.totalPoint;
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
