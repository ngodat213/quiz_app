import 'package:quiz_app/models/lesson.dart';

class Quiz {
  int? quizId;
  String? name;
  int? getPoint;
  double? rating;
  List<Lesson>? lessons;

  Quiz({this.quizId, this.name, this.getPoint, this.rating, this.lessons});

  Quiz.fromJson(Map<String, dynamic> json) {
    quizId = json['quizId'];
    name = json['name'];
    getPoint = json['getPoint'];
    rating = json['rating'];
    if (json['lessons'] != null) {
      lessons = <Lesson>[];
      json['lessons'].forEach((v) {
        lessons!.add(new Lesson.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quizId'] = this.quizId;
    data['name'] = this.name;
    data['getPoint'] = this.getPoint;
    data['rating'] = this.rating;
    if (this.lessons != null) {
      data['lessons'] = this.lessons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
