import 'dart:io';

class ListString {
    static void sort() async{
    final file = File('TODO.txt');
    List<String> lines = await file.readAsLines();
    lines.sort();
    }
    static void removal() async{
    final file = File('TODO.txt');
    List<String> lines = await file.readAsLines();
    print('What number of the line you want to remove?');
    int? a = int.tryParse(stdin.readLineSync()!);
    lines.removeAt(a! - 1);
    }
}   