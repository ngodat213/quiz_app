class Question {
  int? id;
  String? question;
  List<String>? options;
  int? aswer;
  String? image;
  int? userChoose;

  Question(
      {this.id,
      this.question,
      this.options,
      this.aswer,
      this.image,
      this.userChoose});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    options = json['options'].cast<String>();
    aswer = json['aswer'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['options'] = this.options;
    data['aswer'] = this.aswer;
    data['image'] = this.image;
    return data;
  }
}
