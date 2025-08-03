class GroupByFirstLetter {
    static void Letter(){
        String a = 'Fuad Kirill Alla Alina Vanya Losha Hyu "suka pizda" naxyu hyu skvanshi tipa you';
        List<String> b = a.toLowerCase().replaceAll(RegExp(r'[^\w\s]'), ' ').split(' ');
        Map<String, List<String>> c = Map();
        for(String name in b)
        {
            if(name.isEmpty) continue;
            String firstLetter = name[0];

            c.putIfAbsent(firstLetter, () => []);
            c[firstLetter]!.add(name);
        }
        print(c);
    }
}

//if(c.containsKey(firstLetter)) c[firstLetter] = c.putIfAbsent(firstLetter, () => name);