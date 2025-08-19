import 'dart:io';
class Maps{
    static void maps(List<int> zxc){
        //Map<int, int> mapa = Map();
        bool y = false;
        int? x = int.tryParse(stdin.readLineSync()!);
        for(int i = 0; i < zxc.length; i++){
            if(zxc[i] == x) {
            y = true; 
            break;}
        }
        if(y) print('there is your number');
        else print('unfortunetely no');
        print (zxc);
    }
}