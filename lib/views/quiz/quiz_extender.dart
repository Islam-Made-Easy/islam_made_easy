import 'dart:convert';

import 'package:flutter/material.dart';

enum Type { multiple, boolean }

enum Difficulty { easy, medium, hard }

class QuestionList {
  final List<Question> questions;

  QuestionList({this.questions});

  QuestionList copyWith({List<Question> questions}) {
    return QuestionList(questions: questions ?? this.questions);
  }

  Map<String, dynamic> toMap() {
    return {
      'questions': questions?.map((e) => e?.toMap())?.toList(),
    };
  }

  factory QuestionList.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return QuestionList(
      questions: List<Question>.from(
          map['questions']?.map((e) => Question.fromMap(e))),
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionList.fromJson(String source) =>
      QuestionList.fromMap(json.decode(source));

  @override
  String toString() => 'QuestionList(questions: $questions)';
}

class Question {
  final String categoryName;
  final Type type;
  final Difficulty difficulty;
  final String question;
  final String correctAnswer;
  final List<dynamic> incorrectAnswers;

  Question(
      {@required this.categoryName,
      this.type,
      this.difficulty,
      this.question,
      this.correctAnswer,
      this.incorrectAnswers});

  Question copyWith({
    String categoryName,
    Type type,
    Difficulty difficulty,
    String question,
    String correctAnswer,
    List<dynamic> incorrectAnswers,
  }) {
    return Question(
        categoryName: categoryName ?? this.categoryName,
        type: type ?? this.type,
        question: question ?? this.question,
        difficulty: difficulty ?? this.difficulty,
        correctAnswer: correctAnswer ?? this.correctAnswer,
        incorrectAnswers: incorrectAnswers ?? this.incorrectAnswers);
  }

  Map<String, dynamic> toMap() {
    return {
      'category': categoryName,
      'type': type,
      'difficulty': difficulty,
      'question': question,
      'correctAnswer': correctAnswer,
      'incorrectAnswers': incorrectAnswers,
    };
  }

  factory Question.fromMap(Map<String, dynamic> data) {
    if (data == null) return null;
    return Question(
      categoryName: data['category'],
      type: data["type"] == "multiple" ? Type.multiple : Type.boolean,
      difficulty: data["difficulty"] == "easy"
          ? Difficulty.easy
          : data["difficulty"] == "medium"
              ? Difficulty.medium
              : Difficulty.hard,
      question: data["question"],
      correctAnswer: data["correct_answer"],
      incorrectAnswers: data["incorrect_answers"],
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Question(categoryName: $categoryName, question: $question, correctAnswer: $correctAnswer, incorrectAnswers: $incorrectAnswers, difficulty: $difficulty)';
  }

static List<Question> fromData(List<Map<String, dynamic>> data) {
  return data.map((question) => Question.fromMap(question)).toList();
}
}
