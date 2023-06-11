class Question {
  int? id;
  String? question;
  List<String>? options;
  int? answer;
  String? image;
  int? userChoose;

  Question(
      {this.id,
      this.question,
      this.options,
      this.answer,
      this.image,
      this.userChoose});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    options = json['options'].cast<String>();
    answer = json['answer'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['options'] = this.options;
    data['answer'] = this.answer;
    data['image'] = this.image;
    return data;
  }
}
