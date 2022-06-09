import 'package:flutter/material.dart';
import 'package:islam_made_easy/settings/settings.dart';
import 'package:islam_made_easy/views/QnA.dart';
import 'package:islam_made_easy/views/errorR.dart';
import 'package:islam_made_easy/views/home.dart';
import 'package:islam_made_easy/views/prerequisite.dart';
import 'package:islam_made_easy/views/succinct.dart';

class AppRoute extends NavigatorObserver {
  AppRoute._internal();

  static final AppRoute _appRoute = AppRoute._internal();

  factory AppRoute() => _appRoute;
  static final Map<String, WidgetBuilder> _routes = {
    Home.ROUTE_NAME: (context) => Home(),
    QnA.ROUTE_NAME: (context) => QnA(),
    Settings.ROUTE_NAME: (context) => Settings(),
    Succinct.ROUTE_NAME: (context) => Succinct(),
    Prerequisite.ROUTE_NAME: (context) => Prerequisite(),
  };

  Map<String, WidgetBuilder> get routes => _routes;

  Route<dynamic> generateRoute(RouteSettings settings) {
    MaterialPageRoute? page;
    if (settings.name == Home.ROUTE_NAME) {
      page =
          MaterialPageRoute(settings: settings, builder: (context) => Home());
    } else if (settings.name == QnA.ROUTE_NAME) {
      // final String args = settings.arguments;
      page = MaterialPageRoute(settings: settings, builder: (context) => QnA());
    } else if (settings.name == Settings.ROUTE_NAME) {
      page = MaterialPageRoute(
        settings: settings,
        builder: (context) => Settings(),
      );
    } else if (settings.name == Succinct.ROUTE_NAME) {
      page = MaterialPageRoute(
        settings: settings,
        builder: (context) => Succinct(),
      );
    } else if (settings.name == Prerequisite.ROUTE_NAME) {
      page = MaterialPageRoute(
        settings: settings,
        builder: (context) => Prerequisite(),
      );
    }
    return page ??
        MaterialPageRoute(
          builder: (context) => RouteErrorPage(route: settings.name),
        );
  }

  @override
  void didStartUserGesture(
      Route<dynamic> route, Route<dynamic>? previousRoute) {}

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {}

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {}

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute!.settings.name != null) {
      setPreferredOrientations(previousRoute.settings);
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name != null) {
      setPreferredOrientations(route.settings);
    }
  }

  void setPreferredOrientations(RouteSettings settings) {
    // Set Orientation here if necessary
  }
}

AppRoute appRoute = AppRoute();
