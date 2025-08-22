import 'dart:convert';
import 'dart:io';

import '00_hub_core/data/MenuMassages.dart';
import '00_hub_core/menu_system/Menu.dart';
import '01_sys/Console.dart';
import 'Flashcard.dart';

class SM2 {
    static List<Flashcard> _data = [
        Flashcard(question: "Choto normalnoe?", 
            answer: "Nu po idei da", 
            repetitions: 1, 
            interval: 2,
            easeFactor:  3,
            nextReviewDate: DateTime.now()
            ),
        Flashcard(question: "tun tun tun?", 
            answer: "SAHUR", 
            repetitions: 2, 
            interval: 1,
            easeFactor:  0,
            nextReviewDate: DateTime.now()
            )
    ];
    static List<Flashcard> _dueDate = [];
    static List<Flashcard> get data => _data;
    static Flashcard? getClosestReviewCard(){
        if(!collectDueCards()) {
            //print("There is nothing to repeat today");
            return null;
        }
        return _dueDate.removeLast();
    }
    /// true - there are cards to repeat today
    /// false - there are no cards to repeat today
    static bool collectDueCards(){
        if(_dueDate.length > 0) {
            //print("The _dueDate is already filled for today");
            return true;
        }
        _dueDate.clear();
        for (var card in _data) {
            if(card.nextReviewDate.day == DateTime.now().day){
                _dueDate.add(card);
            }
        }

        if(_dueDate.isEmpty) return false;
        else return true;
    }
    static void addCard(Flashcard card) => _data.add(card);
    static void saveAllCards(){
        final file = File('data.json');
        if(!file.existsSync()) return;
        file.writeAsStringSync("[]");
        String json = jsonEncode( SM2.data,
        toEncodable: (Object? value) => value is Flashcard
            ? Flashcard.toJson(value)
            : throw UnsupportedError('Cannot convert to JSON: $value'));

        file.writeAsString(json);
    }
    static void getAllCardsFromSave(){
        final file = File('data.json').readAsStringSync();
        final json = jsonDecode( file) as List;
        _data.clear();
        for (var element in json) 
            _data.add(Flashcard.fromJson(element as Map<String, dynamic>));

        //final aaaaa = json.forEach((card) => Flashcard.fromJson(card));
        //print(aaaaa);
    }   
}

class SM2UI{
    static Map<int, ChoosableOptions> options = {
        0: ChoosableOptions(
            "Go back to main menu",
            () => Menu.runMenu(menuTypes.main)
        ),
        1: ChoosableOptions(
            "Start flashcard session",
            startFlashcardSession
        ),
        2: ChoosableOptions(
            "Add flashcard",
            addNewFlashcard
        ),
        3: ChoosableOptions(
            "Save all flashcards",
            saveAllFlashcards
        ),
        4: ChoosableOptions(
            "Show all flashcards",
            showAllCards
        ),
    };
    static bool isFirstStart = false;
    static void mainMenu() {
       // SM2.saveAllCards();
        if(!isFirstStart) {
            SM2.getAllCardsFromSave();
            isFirstStart = true;
        } 
        Console.displayOptionsAndHandleChoice(options);
    }
    static void startFlashcardSession(){
        while(true){
            final card = SM2.getClosestReviewCard();
            if(card == null){
                print("There is nothing to review today");
                return;
            }
            print(card.question);
            final quolity = Console.promptValidateIntDouble("Enter your update review quality", 
            onStringCheck: (input) {
                if(input.contains("*")){
                    _backToMenu();
                    return;
                }
            }).toInt();      
            card.updateReview(quolity);
        }
    }
    static void addNewFlashcard(){
        Console.clear(); 
        // todo: make something better here, like ability to cancel creating or restart
        final question = Console.promptValidate("Question: ");
        final answer = Console.promptValidate("Answer: ");
        SM2.addCard(Flashcard(question: question, answer: answer, repetitions: 0, interval: 0, easeFactor: 0, nextReviewDate: DateTime.now()));
        _backToMenu();
    }
    static void saveAllFlashcards(){
          print("Saving");
          SM2.saveAllCards();
          for (var i = 0; i < 3; i++) {
              stdout.write('.');
              sleep(Duration(milliseconds: 750));
          }
    }
    static void showAllCards(){
        if(SM2.data.isEmpty) {
            Console.invalidInput(errorMessage: "There is no flashcards.");
            return;
        }
        Console.clear();
        for (var card in SM2.data) {
            print(""
            "\n${Console.symbolColorDef("Answer")}: ${Console.symbolColorAddit(card.answer)} "
            "\n${Console.symbolColorDef("Question")}: ${Console.symbolColorAddit(card.question)}"
            "\n${Console.symbolColorDef("Interval")}: ${Console.symbolColorAddit(card.interval.toString())}"
            "\n${Console.symbolColorDef("EaseFactor")}: ${Console.symbolColorAddit(card.easeFactor.toString())}"
            "\n${Console.symbolColorDef("NextReviewDate")}: ${Console.symbolColorAddit(card.nextReviewDate.toString())} \n");
        }
        _backToMenu();
    }
    static void _backToMenu(){
        Console.prompt("\n\u001b[38;5;252mPress ${Console.symbolColorDef("Enter")} to go to main menu: ");
        mainMenu();
    }
}



/* 



"[
    {
        \"question\":\"Choto normalnoe?\",
        \"answer\":\"Nu po idei da\",
        \"repetitions\":1,
        \"interval\":2.0,
        \"easeFactor\":3.0,
        \"nextReviewDate\":\"2025-08-22 00:20:47.162519\"
    },

    {
        \"question\":\"tun tun tun?\",
        \"answer\":\"SAHUR\",
        \"repetitions\":2,
        \"interval\":1.0,
        \"easeFactor\":0.0,
        \"nextReviewDate\":\"2025-08-22 00:20:47.164640\"
    },

    {
        \"question\":\"Nu da\",
        \"answer\":\"nu nie\",
        \"repetitions\":0,
        \"interval\":0.0,
        \"easeFactor\":0.0,
        \"nextReviewDate\":\"2025-08-22 00:20:59.953171\"
    }
]"

 */





















    // 1. Создал файл и класс. Пока что название оставлю как SM2, в честь названия алгоритма, и не буду сильно парится над ним
    // Пока что не уверен, что точно будет в этом классе: чисто логика, или и логика и интерфейс. Время покажет
    // 2. Смотрю на второй шаг. Этот весь список - это просто переменные. Мне нужно будет их использовать для каждого слова. 
    // Так можно сделать многими способами: например использовать список и встроенный в дарт фичу - records. 
    // Эта штука позволяет сохранять, например в листе, вместо одного элемента - два и более: List<(String, String, int, int, int, int)> data = [];
    // Но данный вариант будет безумно не удобым, на мой взгляд, из-за способа обращения к елементам такого records: data.$0 - обращение к первому элементу 
    // На первый взгляд, обращение достаточо не плохое и вроде бы даже удобное. Но не когда в списке нужно обращатся к шести элементам. Каждый раз 
    // будет приходится лезть в код и смотреть, что по какому индексу расположену. Я уже молчу об удобности и читабельности такого кода.. ее просто нет
    // Поэтому я выбираю класс. Сделаю такую себе кастомную переменную
    /// 3. Почитал я это задание, пока что не очень ясно что и как точно нужно сделать. Предпологаю, что стоит просто сделать метод в классе Flashcard
    /// который будет обрабатывать все то, о чем сказано в третьем пункте
    /// 4. Теперь стало ясно, я думал правильно. Добавлю метод и потихоньку напишу всю логику, описанную в 3 пунтке в этом методе
    