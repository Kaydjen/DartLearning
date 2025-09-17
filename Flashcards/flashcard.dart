class Flashcard{
    String question = '';
    String answer = '';
    int repetitions = 0;
    int interval = 0;
    double easeFactor = 0;
    DateTime nextReviewDate = DateTime(2025,1,1);
    
    Flashcard(this.question, this.answer,
    {
    this.repetitions = 0,
    this.interval = 0,
    this.easeFactor = 0,
    DateTime? nextReviewDate})
    : nextReviewDate = nextReviewDate ?? DateTime(2025,1,1);


    void update(int quality){
        if(quality <= 2){
            repetitions = 0;
            interval = 1;
        }
        else if(quality >= 3){
            repetitions += 1;
            if(repetitions == 1) interval = 1;
            else if(repetitions == 2) interval = 6;
            else interval = (interval * easeFactor.toInt()).round();
            easeFactor = (easeFactor - 0.8 + (0.28 * quality) - (0.02 * quality * quality).clamp(1.3, double.infinity));
        }
        nextReviewDate = (DateTime.now().add(Duration(days: interval)));
    }
}
