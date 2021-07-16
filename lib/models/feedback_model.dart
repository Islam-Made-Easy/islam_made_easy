/// FeedbackModel is a data class which stores data fields of Feedback.
class FeedbackModel {
  final String name;
  final String email;
  final String feedback;

  FeedbackModel(this.name, this.email, this.feedback);

  factory FeedbackModel.fromJson(dynamic json) {
    return FeedbackModel("${json['name']}", "${json['email']}","${json['feedback']}");
  }

  // Method to make GET parameters.
  Map<String,dynamic> toJson() => {
    FeedbackFields.name: name,
    FeedbackFields.email: email,
    FeedbackFields.feedback: feedback
  };
}
class FeedbackFields{
  static final String name = 'name';
  static final String email = 'email';
  static final String feedback = 'feedback';

  static List<String> getFields()=>[name,email,feedback];
}
