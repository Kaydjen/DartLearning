class GroupByFirstLetter {
    static void Letter(){
        String a = 'Fuad Kirill Alla Alina Vanya Losha Hyu';
        List<String> b = a.toLowerCase().replaceAll(RegExp(r'[^\w\s]'), ' ').split(' ');
        Map<String, List<String>> c = Map();
        for(String name in b)
        {
            if(name.isEmpty) continue;
            String firstLetter = name[0];

            if(c.containsKey(firstLetter)) c[firstLetter] = c.putIfAbsent(firstLetter, () => name);
        }
    }
}