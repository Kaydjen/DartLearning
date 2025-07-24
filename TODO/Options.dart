import 'dart:io';

class Options{
    static List<String> tasks = [];
    static void options1(){
        print('1.see all the tasks');
        print('2.add a task');
        print('3.remove a task');
        print('4.sort the tasks from a-z');
        var input = stdin.readLineSync()!;
        int input1 = int.tryParse(input)!;
        if(input1 == 1)
        {
            print(tasks);
        } 
        else if(input1 == 2)
        {
            print('What task would you like to add in here');
            String? b = stdin.readLineSync();
            tasks.add(b!);      
        }
        else if (input1 == 3)
        {
            print('What would like to delete?');
            var rem = stdin.readLineSync()!;
            int rem1 = int.tryParse(rem)!;
            int rem2 = rem1 - 1;
            tasks.removeAt(rem2);
        }
        else
        {
            tasks.sort();
        }
        options1();
    }
}