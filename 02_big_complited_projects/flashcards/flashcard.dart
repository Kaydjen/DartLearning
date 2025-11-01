
class Flashcard{
    String question = "";
    String answer = ""; 
    int repetitions = 0; 
    int interval = 0;
    double easeFactor = 2.5; // score that give player
    DateTime nextReviewDate = DateTime(2025, 1, 1);                               // такой вот встроенный способ хранения даты
    Flashcard({required this.question, required this.answer});

    Flashcard.fromJson(Map<String, dynamic> json)
        : question = json["question"] as String,
        answer = json["answer"] as String,
        repetitions = json["repetitions"] as int,
        interval = json["interval"] as int,
        easeFactor = json["easeFactor"] as double,
        nextReviewDate = DateTime.parse(json["nextReviewDate"] as String);

    static Map<String, dynamic> toJson(Flashcard card) =>
      {
        'question': card.question, 
        'answer': card.answer, 
        'repetitions': card.repetitions, 
        'interval': card.interval, 
        'easeFactor': card.easeFactor, 
        'nextReviewDate': card.nextReviewDate.toString(), 
    };
}
/* 



class Flashcard{
    String question = "";
    String answer = ""; 
    int repetitions = 0; 
    int interval = 0;
    double easeFactor = 2.5; // score that give player
    DateTime nextReviewDate = DateTime(2025, 1, 1);                               // такой вот встроенный способ хранения даты
    Flashcard({required this.question, required this.answer, 
    required this.repetitions, required this.interval, 
    required this.easeFactor, required this.nextReviewDate});

    Flashcard.fromJson(Map<String, dynamic> json)
        : question = json["question"] as String,
        answer = json["answer"] as String,
        repetitions = json["repetitions"] as int,
        interval = json["interval"] as int,
        easeFactor = json["easeFactor"] as double,
        nextReviewDate = DateTime.parse(json["nextReviewDate"] as String);

    static Map<String, dynamic> toJson(Flashcard card) =>
      {
        'question': card.question, 
        'answer': card.answer, 
        'repetitions': card.repetitions, 
        'interval': card.interval, 
        'easeFactor': card.easeFactor, 
        'nextReviewDate': card.nextReviewDate.toString(), 
    };

    void changeAnswer(String value){
        if(value.trim().isEmpty) {
            
        }
    }
}
 */