import 'dart:io';

class Options{
    static void options1() async{
        print('1.see all the tasks');
        print('2.add a task');
        print('3.rewrite the tasks');
        print('4.remove a task');
        print('5.sort the tasks from a-z');
        var input1 = int.tryParse(stdin.readLineSync()!);
        if(input1 == 1)
        {
            final file = File('TODO.txt');
            final content = file.readAsStringSync();
            print (content);
        } 
        else if(input1 == 2)
        {
            print('What task would you like to add in here');
            final file = File('TODO.txt');
            String? a = stdin.readLineSync();
            file.writeAsStringSync('\n'+ a!, mode:FileMode.append);
            print('You have succefully added new task');
        }
        else if (input1 == 3)
        {
            print('Rewrite something already written');
            final file = File('TODO.txt');
            String? a = stdin.readLineSync();
            file.writeAsStringSync(a!);
            print('You have succefully rewrite');
        }
            else if(input1 == 4){
            final file = File('TODO.txt');
            List<String> lines = await file.readAsLines();
            print('What number of the line you want to remove?');
            int? a = int.tryParse(stdin.readLineSync()!);
            lines.removeAt(a! - 1);
            await file.writeAsString(''.trim());
            for(int i=0; i < lines.length; i++){
            if (lines[i] == ''){
                lines.removeAt(i);
            }
            file.writeAsStringSync(lines[i], mode:FileMode.append);
            if(lines.length - 1 > i){
                file.writeAsStringSync('\n', mode:FileMode.append);
            }
            }
        }
        else if (input1 == 5)
        {
            final file = File('TODO.txt');
            List<String> lines = await file.readAsLines();
            lines.sort();
            await file.writeAsString(''.trim());
            for(int i=0; i < lines.length; i++){
            if (lines[i] == ''){
                lines.removeAt(i);
            }
            file.writeAsStringSync(lines[i], mode:FileMode.append);
            if(lines.length - 1 > i){
                file.writeAsStringSync('\n', mode:FileMode.append);
            }
            }
        }
        else{
            print('Introduce the correct answer');
            options1();
        }
        options1();
    }
}