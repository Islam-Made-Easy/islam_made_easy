/// FeedbackModel is a data class which stores data fields of Feedback.
class FeedbackModel {
  final String? name, email, feedback;

  const FeedbackModel({this.name, this.email, this.feedback});

  factory FeedbackModel.fromJson(dynamic json) {
    return FeedbackModel(
      name: "${json['name']}",
      email: "${json['email']}",
      feedback: "${json['feedback']}",
    );
  }

  // Method to make GET parameters.
  Map<String, dynamic> toJson() => {
        FeedbackFields.name: name,
        FeedbackFields.email: email,
        FeedbackFields.feedback: feedback
      };
}

class FeedbackFields {
  static final String name = 'name', email = 'email', feedback = 'feedback';

  static List<String> getFields() => [name, email, feedback];
}
