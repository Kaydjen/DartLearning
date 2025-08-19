class WordCounter{
    static void words(){
        String abc = "A dog with a Cat were playin On the ground while a Black cat came to A whIte Cat to talk about the DoG";
        List<String> abcList = abc.toLowerCase().replaceAll(RegExp(r'[^\w\s]'), '').split(' ');
        print(abcList);
        Map<String, int> wordsNumber = Map();
        for(String eachWord in abcList)
        {
            if(wordsNumber.containsKey(eachWord)) wordsNumber[eachWord] = wordsNumber[eachWord]! + 1;
            else wordsNumber[eachWord] = 1;
        }
        print(wordsNumber);
    }
}
