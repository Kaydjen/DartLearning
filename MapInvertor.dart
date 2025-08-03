/* 
Invert a Map

Problem: Given a map like {user1: admin, user2: guest, user3: admin}, invert it to show roles as keys.

>  {admin: [user1, user3], guest: [user2]}

 */


class MapInvertor{
    static Map<String, List<String>> invert(Map<String, String> users) {
      final invertedUsers = <String, List<String>>{};
      users.forEach((key, value) =>
        (invertedUsers[value] ??= []).add(key));
      return invertedUsers;
    }
    // Let it be there for a while
    static Map<String, int> badSort(Map<String, int> data){ 
        List<MapEntry<String, int>> list = data.entries.toList();
        for (int i = 0; i < list.length - 1; i++) {  // I know, it's not the best apgorithm, but its what I wrote by myself. Apparantly. i will write something better in future
            int iterTemp = 0;
            for (int j = 0; j < list.length - i- 1; j++) {
                if(list[j].value < list[j+1].value) 
                {
                    final temp = list[j];
                    list[j] = list[j+1];
                    list[j+1] = temp;
                    iterTemp++;
                }
            }
            if(iterTemp == 0) break;
        }
        return Map.fromEntries(list);
    }
    ///  returnMap = true - return Map.fromEntries(sortedEntries) 
    /// 
    ///  returnMap = false - return sortedEntries;
    static dynamic sort(Map<String, int> data, [bool returnMap = true]) {
        List<MapEntry<String, int>> sortedEntries = data.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));
        return returnMap ? Map.fromEntries(sortedEntries) : sortedEntries;
    }
}

/* 

     final Map<String, String> userRoles = {
    'user1': 'admin',
    'user2': 'guest',
    'user3': 'admin',
    'user4': 'editor',
    'user5': 'guest',
    };
    final Map<String, List<String>> inverted = MapInvertor.invert(userRoles);

    inverted.forEach((role, users) {
    print('$role: $users');
    });

 */