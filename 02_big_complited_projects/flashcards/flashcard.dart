
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

    void updateReview(int quality) {
        // ограничиваем оценку
        quality = quality.clamp(0, 5).toInt();

        if (quality <= 2) {
            // плохой результат
            repetitions = 0;
            interval = 1;
        } else {
            // хороший результат
            repetitions++;
            if (repetitions == 1) {
                interval = 1;
            } else if (repetitions == 2) {
                interval = 6;
            } else {
                interval = (interval * easeFactor).round();
            }

            easeFactor = (easeFactor - 0.8 + (0.28 * quality) - (0.02 * quality * quality))
                .clamp(1.3, double.infinity);
        }

        // дата следующего повторения
        nextReviewDate = DateTime.now().add(Duration(days: interval));
    }
/* 
    void updateReview(int quality){ // метод, как и все, что есть в классе, я сделал не статическим. Ибо этот класс - по сути переменная,
    // как тот же лист или мап
        quality = quality.clamp(0, 5).toInt();
        // 1. When you review a card, you give it a score from 0 to 5. - значит, у нас должно быть ограничение. Можно было бы сделать его прямо тут,
        // но пожалуй лучше вынесу такого рода логику в другой класс, пусть это будет там
        /* 2.
            If you score it 0–2 → you forgot or struggled
                Reset repetitions to 0
                Set interval to 1 (review again tomorrow)
         */
        if(quality >= 0 && quality <= 2){
            repetitions = 0;
            interval = 1;
        }
        /* 
            If you score it 3–5 → you remembered it
                Increase repetitions by 1
                If it's the first correct review → interval = 1
                If it's the second → interval = 6
                If it's the third or more → interval = previous interval × easeFactor
         */
        else if(quality >= 3 && quality <= 5){ // строчка "quality <= 5" особо не нужна, ибо, вероятно,
        // я пропишу ограничение на ввод оценки (что бы можно было вввести только цифру от 0 до 5)
        // Но, как говорится, лишней безопасности не бывает, да и к томуже, так удобнее можно будет что-то поменять

        repetitions++;
        switch(repetitions){ // решил использовать свитч кейс, ибо у нас там проверяется одно число и его значения. 
        // Для такого удобнее всего использовать именно свич кейс. Он позволяет прописать все варианты значений и действий более удобно и наглядно, удобнее читать
            case 1:
                interval = 1;
                break;
            case 2:
                interval = 6;
                break;
            case >= 3: // эта запись равносильна if(repetitions >= 3)...
                interval = interval * easeFactor; // на этом моменте я поменял тип переменной interval с int на double
                break;
        }
        easeFactor = (easeFactor - 0.8 + (0.28 * quality) - (0.02 * quality * quality)).clamp(1.3, 100000); 
        // clamp - ограничение значения. То есть значение не может стать меньше или больше указанного лимита
        
        /// DateTime.now() - тут хранятся данный о настоящей дате (день, год, время, месяц - в общем, обо всем).
        /// Я обновляю старую дату, а потом увеличиваю интервал.
        nextReviewDate = DateTime.now();
        nextReviewDate.day + interval;
        }
    } */
}




/* 

[{"question":"Choto normalnoe?",
"answer":"Nu po idei da",
"repetitions":1,
"interval":2.0,
"easeFactor":3.0,
"nextReviewDate":"2025-08-22 13:02:25.618748"},{"question":"tun tun tun?","answer":"SAHUR","repetitions":2,"interval":1.0,"easeFactor":0.0,"nextReviewDate":"2025-08-22 13:02:25.621384"}]



 */