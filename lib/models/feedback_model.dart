/// FeedbackModel is a data class which stores data fields of Feedback.
class FeedbackModel {
  String name;
  String email;
  String feedback;

  FeedbackModel(this.name, this.email, this.feedback);

  factory FeedbackModel.fromJson(dynamic json) {
    return FeedbackModel("${json['name']}", "${json['email']}","${json['feedback']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
    'name': name,
    'email': email,
    'feedback': feedback
  };
}
