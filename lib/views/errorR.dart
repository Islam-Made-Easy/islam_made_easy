import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';

class RouteErrorPage extends StatefulWidget {
  static const ROUTE_NAME = "/error_route";
  final String route;

  RouteErrorPage({Key key, this.route}) : super(key: key);

  @override
  _RouteErrorPageState createState() => _RouteErrorPageState();
}

class _RouteErrorPageState extends State<RouteErrorPage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
        behaviour: ChildFlySpaceBehaviour(),
        vsync: this,
        child: Container(
          child: Center(
            child: Text('No Route Named: ${this.widget.route}'),
          ),
        ),
      ),
    );
  }
}