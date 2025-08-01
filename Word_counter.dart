class Word_counter{
    static void Words(){
        String? abc = "A dog with a Cat";
        abc = abc.toLowerCase();
        List<String> abcList = abc.split(" ");
        print(abcList);
        Map<String, int> WordNumber = Map();
        for(var dog in abcList){
            if(abcList.isEmpty) continue;
            abcList[dog] = (abcList[dog] ?? 0) + 1;
        }
    }
}