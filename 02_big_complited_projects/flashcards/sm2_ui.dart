import '../../00_hub_core/menu_system/Menu.dart';
import '../../01_sys/cli.dart';
import '../../01_sys/cli_opt_helper.dart';
import 'sm2.dart';

class SM2UI{
    static void mainMenu() => CliOptHelper.runMenu(_primaryOptions);
    static Map<int, CliOptions> _primaryOptions = {
        0: CliOptions(
            des: "Go back to main menu",
            func: () => Menu.runMenu(menuTypes.main)
        ),
        1: CliOptions(
            des: "Start flashcard session",
        ),
        2: CliOptions(
            des: "Add flashcard",
            flags: {
                "q": (question) => SM2.addQuestion(question),
                "a": (answer) => SM2.addAnswer(answer)
            }
        ),
        3: CliOptions(
            des: "Additional options (development...)",
            func: () => CliOptHelper.runMenu(_secondaryOptions),
        ),
    };
    static final Map<int, CliOptions> _secondaryOptions = {
        0: CliOptions(
            des: "to return back",
            func: () => CliOptHelper.runMenu(_primaryOptions),
        ),
        1: CliOptions(
            des: "to see examples",
        ),
        2: CliOptions(
            des: "to see all flashcards",
        ),
        3: CliOptions(
            des: "to see certain flashcard",
            opt: "--index index_of_card",   
            shortOpt: "-i index",
            flags: {
                "i": (input) => print(input),
            }
        ),
        4: CliOptions(
            des: "to change certain flashcard's value (you can write one value or both)",
            opt: "--index_of_card --question new_question --answer new_answer",
            shortOpt: "-i -q new_question -a new_answer"
        ),
        // NEW
        5: CliOptions(
            des: "to remove certain flashcard",
            opt: "--index_of_card",
            shortOpt: "-index_of_card",
        ),
        6: CliOptions(
            des: "to remove all flashcards",
            opt: "--remove",
            shortOpt: "-r"
        ),
    };
}







/* 




import 'dart:io';
import '../../00_hub_core/data/menu_massages.dart';
import '../../00_hub_core/menu_system/Menu.dart';
import '../../01_sys/color.dart';
import '../../01_sys/console.dart';
import '../../01_sys/display_handler.dart';
import '../../01_sys/prompt_handler.dart';
import 'flashcard.dart';
import 'flashcard_review_extension.dart';
import 'sm2.dart';
import 'sm2_ui_value_changer.dart';

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
        5: ChoosableOptions(
            "Additional options (development...)",
            SM2UIValueChanger.run
        ),
    };
    static bool isFirstStart = false;
    static void mainMenu() {
       // SM2.saveAllCards();
        if(!isFirstStart) {
            SM2.getAllCardsFromSave();
            isFirstStart = true;
        } 
        Display.optionsAndHandleChoice(options);
    }
    static void startFlashcardSession(){
        Console.clear();
        
        while(true){
            final card = SM2.getClosestReviewCard();
            if(card == null){
                print("${Color.red}There is nothing to review today");
                mainMenu();
                return;
            }
            print("${Color.darkRed}Question: ${Color.reset}${card.question}");
            stdout.write(
            "${Color.grayDark}Press "
            "${Color.brightCyan}Enter "
            "${Color.grayDark}to see the resault: ");
            stdin.readLineSync();
            Console.clearPreviousLines(2);
            stdout.write("${Color.green}Answer: ${Color.reset}${card.answer}");
            final quolity = Prompt.validateIntDouble("\n${Color.grayDark}Enter your update review quality: ", 
            onStringCheck: (input) {
                if(input.contains("*") && input.length == 1){
                    _backToMenu();
                    return;
                }
            },
            countOfLinesToClear: 4).toInt();      
            Console.clear();
            card.updateReview(quolity);
        }
    }
    static void addNewFlashcard(){
        while(true){
            Console.clear(); 
            // todo: make something better here, like ability to cancel creating or restart
            final question = Prompt.validate("Question: ", countOfLinesToClear: 4,
            onStringCheck: (input) {
                if(input.contains("*") && input.length == 1){
                    _backToMenu();
                    return;
                }
            });
            final answer = Prompt.validate("Answer: ", countOfLinesToClear: 4,
            onStringCheck: (input) {
                if(input.contains("*") && input.length == 1){
                    _backToMenu();
                    return;
                }
            });
            SM2.addCard(Flashcard(question: question, answer: answer, repetitions: 0, interval: 0, easeFactor: 0, nextReviewDate: DateTime.now()));
            SM2.saveAllCards();
        }
    }
    static void saveAllFlashcards(){
          print("Saving");
          SM2.saveAllCards();
          for (var i = 0; i < 3; i++) {
              stdout.write('.');
              sleep(Duration(milliseconds: 750));
          }
          _backToMenu();
    }
    static void showAllCards(){
        if(SM2.data.isEmpty) {
            Prompt.invalidInput(errorMessage: "There is no flashcards.", countOfLinesToClear: 4);
            _backToMenu();
            return;
        }
        Console.clear();
        for (var card in SM2.data) {
            printCardContent(card);
        }
        _backToMenu();
    }
    static void printCardContent(Flashcard card){
            Prompt.printOneLn("\n${Color.set(ColorTypes.red, str: "Question")}: ${Color.set(ColorTypes.def, str: (card.question))}");
            Prompt.printOneLn("\n${Color.set(ColorTypes.red, str: "Answer")}: ${Color.set(ColorTypes.def, str: (card.answer))} ");
            Prompt.printOneLn("\n${Color.set(ColorTypes.red, str: "Interval")}: ${Color.set(ColorTypes.def, str: (card.interval.toString()))}");
            Prompt.printOneLn("\n${Color.set(ColorTypes.red, str: "EaseFactor")}: ${Color.set(ColorTypes.def, str: (card.easeFactor.toString()))}");
            Prompt.printOneLn("\n${Color.set(ColorTypes.red, str: "NextReviewDate")}: ${Color.set(ColorTypes.def, str: (card.nextReviewDate.toString()))} \n");
    }
    static void _backToMenu(){
        Prompt.prompt("\n${Color.reset}Press ${Color.brightCyan}Enter${Color.reset} to go to main menu: ");
        mainMenu();
    }
}













 */





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
    