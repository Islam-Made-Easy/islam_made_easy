import 'package:gsheets/gsheets.dart';
import 'package:islam_made_easy/models/feedback_model.dart';

/// [FeedbackServices] is a class which does work of saving user feedback in Google Sheets using IME-Feedback-API
class FeedbackServices {
  static final _sheetID = '1_YoLUNUUXKO_RfMt3P5Y60RB9evR-_4FTCtaGfgcC_0';
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "ime-feedback-api",
  "private_key_id": "7889a65f87a4172ff95b7697bd93776b63a673b8",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQClsXKlXBAnCNlK\n9XezwTjx2cugTPihyEw1JrncSQ3jUW2tjbskXTtmnnjYPyCadYWRiIbX1AFmMC1L\nOCr1+Fgue4q02RenXLK3m0Zvbjp5KxKEyugTWk2cx5u3TW1ERaFxA0Zj+Kkm4OML\ntIyCuPx1KDWOwtSr8bfE+6Xa52tQRvZK8cUlrwjMwI4axE7aioO2RSEnPiCK+B0x\nBtTv6v+QVAIxUcuF5nV+p7p+7InITEatcDD8YShCEXaRHY9ziW5PSFGL99ISv74S\nF+lnYNe9diQXdtpS4fvoeS1m/WvYolntx/sZv5Q9m1jvS0/cc8aRA6fKc89lxeTT\nLLqafxnLAgMBAAECggEAE5Q/1V1nGo23oN1tBc8tIPBZA6Svc+08tW0m5OphsJJU\nhlUV9OqVadS2YpXhuY7DN/AXlapbeKKfFOEwERJbAoceXAIT2EwiYYLWKbWvRYEl\noOPEf6uZ5I72Y2HL/xdxR8RDeEMPuI82FRHX0VygQbcneP/5wdBVeaU43dX0aYRV\nwhFayQ93mqDb/BXrbxnp7Cp/zLYFqbdCk76G+ob7hdZ2oK9gia1FCDYNAa/E0tKc\n/DYqSSdxlFwTEmKEwuyhMMgq1uVMZMa1FMlUlGgZrFZbODXXnWXNTez1WnigWqne\n/lGoblvjSW7wRN6VMSVJEvlfHU/tSS167phGJXD2hQKBgQDVvH8nbYs0C2a4AskK\nT+dGIQaE+umdC6FzOBa8qiqSI3alXJDsOmSWV7lLR8lADAdDUEIShhrFU5HHROFe\nxGjoAPgvLaPxhns45dYehHxIFKwH7ajWvWfzN5vTnaJ/nIARAz3gA+pPW3hlPi7Q\nvHGKUQM/Z171Pu7Yc1dpUGb0vwKBgQDGdPfMEXaI28JgMnxImfQi17bLweoAkRZW\nCkoXTQ2WL2U5HQnHJRnteNJ7oaqYmID8MkXEFZHZIknol7k++kk7D0y/VSv5HjCG\nfWd4l/70ZFrPbKkn0rfBhyHhRgflAJiYvi1jh4oCejsBXJ9GK8nxWyHdOhhA+PV9\nhsX1xOXh9QKBgGl2039PDEsn/Q17Qlw2RTZTgXYIoVF+tbG20XFSviLSIO9Dl7cY\nsR2GN8Yvq9xQkxzh81hUl80aiWo8UMCERgeEwvH0oVrCMvdGYbs5QGII4UIgQRmE\n6FAY9mka9V3miULbyKJLDEkQJ349irgw5A2OH/4fMbntzck8ULuEkujdAoGBAKR5\njmEPXAji8P5e+QgGqAI0e2f1Z2Ve2X8nee5Dyu3ci+zAtzjX89wPFYqnGsbrJYNe\netme8shdFZnyHPIn5odPD9FG2nHVZmwgBKA6gG+1uFlOegbqKab3wsl8C9DsJIv6\nmY1yaJvTB5ICXHKAmhYw7Cj4G9/FNVf6WZhtvgP9AoGAOv/TI9g8XrQu4aIYG5Wq\nlFGb2d7Lsw96/JApdoJ/Oi8h9qhDLNKN5LNWdfxJLyNaljT8FMhWR/N4iOjbliqJ\n/Xh2sT/K9f4b0iCnzASP5mJ1n+I5LBFaupH+k6HNCx7vbQtoJyOqU9yLajWEGAH+\nceOWRPvy9LvrBIivJUKI3Fw=\n-----END PRIVATE KEY-----\n",
  "client_email": "ime-api@ime-feedback-api.iam.gserviceaccount.com",
  "client_id": "100488406285229894563",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/ime-api%40ime-feedback-api.iam.gserviceaccount.com"
}
''';
  static final _gSheets = GSheets(_credentials);
  static Worksheet? _wSheet;

  static Future init() async {
    try {
      final spreadsheet = await _gSheets.spreadsheet(_sheetID);
      _wSheet = await spreadsheet.worksheetByTitle('Feedback');
      final firstRow = FeedbackFields.getFields();
      _wSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print('Init Error: $e');
    }
  }

  static Future insert({String? name, email, feedback}) async {
    if (_wSheet == null) return;
    _wSheet!.values.appendRow([name, email, feedback]);
  }
}