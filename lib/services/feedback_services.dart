import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:islam_made_easy/models/feedback_model.dart';

/// FormController is a class which does work of saving FeedbackForm in Google Sheets using
/// HTTP GET request on Google App Script Web URL and parses response and sends result callback.
class FeedbackServices {

  // Google App Script Web URL.
  static const String URL = "https://script.google.com/macros/s/AKfycby6OTd9hupw10aekAs4WWB0xnIXKoI8SeyhfhrlHBgwNSiiznb8LAm14f2MvGwfgvY6/exec";

  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

  /// Async function which saves feedback, parses [feedbackForm] parameters
  /// and sends HTTP GET request on [URL]. On successful response, [callback] is called.
  void submitForm(
      FeedbackModel feedbackForm, void Function(String) callback) async {
    try {
      await http.post(Uri.parse(URL), body: feedbackForm.toJson()).then((response) async {
        if (response.statusCode == 302) {
          var url = response.headers['location'];
          await http.get(Uri.parse(url)).then((response) {
            callback(convert.jsonDecode(response.body)['status']);
          });
        } else {
          callback(convert.jsonDecode(response.body)['status']);
        }
      });
    } catch (e) {
      print(e);
    }
  }
}