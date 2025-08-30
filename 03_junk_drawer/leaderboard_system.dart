/* 
### 5. Leaderboard System

Problem: Build a leaderboard where users earn points. You must:

* Add/update points
* Sort users by score descending
* Return the top N users

> Use Map<String, int> and sorting with .entries.
 */
/* 
    Name: score
    String: int
 */
import 'map_invertor.dart';

class LeaderboardSystem{
    static Map<String, int> _data = Map();
    /// If the user doesn't exist in the leaderboard, they will be added; otherwise, their score will be updated
    /// 
    /// Returns true if the user already existed in the data
    /// 
    /// Returns false if the user was not in the data before
    static bool addUserOrUpdateScore(String name, [int currentScore = 0]){
        final isExistingUser = _data.containsKey(name);
        _data[name] = currentScore;
        return isExistingUser;
    }
    /// Return list of top n users
    /// 
    /// n - number of users
    static List<MapEntry<String, int>> returnTopNUsers(int n) 
    => MapInvertor.sort(_data, false).toList() as List<MapEntry<String, int>>;
    /// sort users by score descending
    static void sort() => MapInvertor.sort(_data);
}