import 'dart:convert';

import 'package:flutter/foundation.dart';

class Categories {
  final String? tittle;
  final List<String>? categories;
  Categories({this.tittle, this.categories});

  Categories copyWith({String? tittle, List<String>? categories}) {
    return Categories(
      tittle: tittle ?? this.tittle,
      categories: categories ?? this.categories,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tittle': tittle,
      'categories': categories
    };
  }

  factory Categories.fromMap(Map<String, dynamic>? map) {
    if (map == null) {};

    return Categories(
      tittle: map!['tittle'],
      categories: List<String>.from(map['categories'] as Iterable<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Categories.fromJson(String source) =>
      Categories.fromMap(json.decode(source) as Map<String, dynamic>?);

  @override
  String toString() => 'Categories(tittle: $tittle, categories: $categories)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Categories &&
        o.tittle == tittle &&
        listEquals(o.categories, categories);
  }

  @override
  int get hashCode => tittle.hashCode ^ categories.hashCode;
}
