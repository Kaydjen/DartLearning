import 'dart:convert';
import 'flashcard.dart';
import 'input.dart';

class StoringTheFLashcards{
    final Flashcard card;
    final String question;
    final String answer;

    StoringTheFLashcards(this.card)
    : question = Input.asigning().$1,
    answer = Input.asigning().$2;
    Map<String, dynamic> toJson() {
            return {
                'question' : question,
                'answer' : answer,
                'repetions' : card.repetitions,
                'interval' : card.interval,
                'easeFactor' : card.easeFactor,
                'DateTime' : card.nextReviewDate,
            };

    }
}