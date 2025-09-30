import 'dart:convert';
import 'dart:io';
import 'dart:math';
import '../../01_sys/exceptions/console_exeptions/element_exceptions.dart';
import '../../01_sys/exceptions/console_exeptions/list_exceptions.dart';
import '../../01_sys/exceptions/result_handler.dart';
import 'flashcard.dart';

class SM2 {
    static List<Flashcard> _data = [];
    static List<Flashcard> _dueDate = [];
    static List<Flashcard> get data => _data;
    static const String _dataPath = "C:\\Users\\Administrator\\AppData\\Local\\Flashcards\\data.json";
    static const String _pathToData = "C:\\Users\\Administrator\\AppData\\Local\\Flashcards";
    static Flashcard? getClosestReviewCard(){
        if(!collectDueCards()) {
            //print("There is nothing to repeat today");
            return null;
        }
        final rnd = Random();
        return _dueDate.removeAt(rnd.nextInt(_dueDate.length));
    }
    /// true - there are cards to repeat today
    /// false - there are no cards to repeat today
    static bool collectDueCards(){
        if(_dueDate.isNotEmpty) {
            //print("The _dueDate is already filled for today");
            return true;
        }
        _dueDate.clear();
        for (var card in _data) {
            if(card.nextReviewDate.day <= DateTime.now().day){
                _dueDate.add(card);
            }
        }

        if(_dueDate.isEmpty) return false;
        else return true;
    }
    static Result<Flashcard> tryGetCard(int index){
        if(_data.length < index) return Result.fail(IndexOutOfRange("_data flashcard", index));
        else return Result.ok(_data[index]);
    }
    static void addCard(Flashcard card) => _data.add(card);
    static void saveAllCards() {
        if(!Directory(_pathToData).existsSync()) Directory(_pathToData).create();
        final file = File(_dataPath);
        if(file.existsSync()) file.writeAsStringSync("[]");
        String json = jsonEncode( SM2.data,
        toEncodable: (Object? value) => value is Flashcard
            ? Flashcard.toJson(value)
            : throw UnsupportedError('Cannot convert to JSON: $value'));
        file.writeAsStringSync(json);
    }   
    static void getAllCardsFromSave(){
        final file = File(_dataPath);
        if(!file.existsSync()) {
            print("There is no file data.json");
            return;
        }
        final info = file.readAsStringSync(encoding: utf8);
        if(info.length < 5){
            print("File is empty");
            return;
        }
        final json = jsonDecode( info) as List;
        _data.clear();
        for (var element in json) 
            _data.add(Flashcard.fromJson(element as Map<String, dynamic>));
    }   
    static Result<Flashcard> tryChangeContent(int index, {String? newQuestion, String? newAnswer}){
        if(_data.length < index) return Result.fail(IndexOutOfRange("_data flashcard", index));
        final card = _data[index];
        if(newQuestion == null && newAnswer == null) return Result.fail(ElementsAreEmpty(["newQuestion", "newAnswer"], SM2));
        if(newQuestion != null) card.question = newQuestion;
        if(newAnswer != null) card.answer = newAnswer;
        return Result.ok(card);
    }
}


/* 
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import '../../01_sys/exceptions/console_exeptions/element_exceptions.dart';
import '../../01_sys/exceptions/console_exeptions/list_exceptions.dart';
import '../../01_sys/exceptions/result_handler.dart';
import 'flashcard.dart';

class SM2 {
    static List<Flashcard> _data = [];
    static List<Flashcard> _dueDate = [];
    static List<Flashcard> get data => _data;
    static const String _dataPath = "C:\\Users\\Administrator\\AppData\\Local\\Flashcards\\data.json";
    static const String _pathToData = "C:\\Users\\Administrator\\AppData\\Local\\Flashcards";
    static Flashcard? getClosestReviewCard(){
        if(!collectDueCards()) {
            //print("There is nothing to repeat today");
            return null;
        }
        final rnd = Random();
        return _dueDate.removeAt(rnd.nextInt(_dueDate.length));
    }
    /// true - there are cards to repeat today
    /// false - there are no cards to repeat today
    static bool collectDueCards(){
        if(_dueDate.isNotEmpty) {
            //print("The _dueDate is already filled for today");
            return true;
        }
        _dueDate.clear();
        for (var card in _data) {
            if(card.nextReviewDate.day <= DateTime.now().day){
                _dueDate.add(card);
            }
        }

        if(_dueDate.isEmpty) return false;
        else return true;
    }
    static Result<Flashcard> tryGetCard(int index){
        if(_data.length < index) return Result.fail(IndexOutOfRange("_data flashcard", index));
        else return Result.ok(_data[index]);
    }
    static void addCard(Flashcard card) => _data.add(card);
    static void saveAllCards() {
        if(!Directory(_pathToData).existsSync()) Directory(_pathToData).create();
        final file = File(_dataPath);
        if(file.existsSync()) file.writeAsStringSync("[]");
        String json = jsonEncode( SM2.data,
        toEncodable: (Object? value) => value is Flashcard
            ? Flashcard.toJson(value)
            : throw UnsupportedError('Cannot convert to JSON: $value'));
        file.writeAsStringSync(json);
    }   
    static void getAllCardsFromSave(){
        final file = File(_dataPath);
        if(!file.existsSync()) {
            print("There is no file data.json");
            return;
        }
        final info = file.readAsStringSync(encoding: utf8);
        if(info.length < 5){
            print("File is empty");
            return;
        }
        final json = jsonDecode( info) as List;
        _data.clear();
        for (var element in json) 
            _data.add(Flashcard.fromJson(element as Map<String, dynamic>));
    }   
    static Result<Flashcard> tryChangeContent(int index, {String? newQuestion, String? newAnswer}){
        if(_data.length < index) return Result.fail(IndexOutOfRange("_data flashcard", index));
        final card = _data[index];
        if(newQuestion == null && newAnswer == null) return Result.fail(ElementsAreEmpty(["newQuestion", "newAnswer"], SM2));
        if(newQuestion != null) card.question = newQuestion;
        if(newAnswer != null) card.answer = newAnswer;
        return Result.ok(card);
    }
}


 */