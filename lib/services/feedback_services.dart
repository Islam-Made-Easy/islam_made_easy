import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:islam_made_easy/models/feedback_model.dart';

class FeedbackServices {
  final void Function(String) callback;
  static const String URL = "https://script.google.com/macros/s/AKfycby6OTd9hupw10aekAs4WWB0xnIXKoI8SeyhfhrlHBgwNSiiznb8LAm14f2MvGwfgvY6/exec";
  static const STATUS_SUCCESS = "SUCCESS";

  FeedbackServices(this.callback);

  void submitFeed(FeedbackModel fdModel) async {
    try {
      await http.get(URL + fdModel.toParams()).then((response) {
        callback(convert.jsonDecode(response.body)['status']);
      });
    } catch (e) {
      print(e);
    }
  }
}
