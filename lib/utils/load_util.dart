import 'package:flutter/material.dart';

// Provides the common functionalist of having a isLoading toggle for a view, that is turned on while loading some content.
mixin LoadingStateMixin<T extends StatefulWidget> on State<T> {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    if (!mounted) return;
    setState(() => _isLoading = isLoading);
  }

  Future<R> load<R>(Future<R> action()) async {
    isLoading = true;
    R result = await action();
    isLoading = false;
    return result;
  }
}
