class FeedbackModel {
  String _name;
  String _email;
  String _feedback;
  FeedbackModel(this._name, this._email, this._feedback);
  String toParams() => "?name=$_name&email=$_email&feedback=$_feedback";
}
