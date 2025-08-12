
class SolutionLeetCode1 {
  // In LeetCode the HashMap is not fully implemented
  // Runtime 503
  List<int> twoSum(List<int> nums, int target) {
// Map to keep an eye on the close range, simply correlation
    final Map<int, int> correspondence = Map<int, int>();

    // loop through the entire list values
    for (var i = 0; i < nums.length; i++) {
      // saving value inside a variable
      final int value = nums[i];

      // we are getting key in a very tricky way like target value which
      // we will enter and than we will subtract the single value 
      //that we got from looping from the list.
      //
      final int key = target - value;
      if (correspondence.containsKey(key)) {
        // than we will return if int of the map and the second int
        // which shows the position in a list which two value will result the target value
        return [correspondence[key]!, i];
      }
      // here we defining that our key will i the digit inside of our list
      // if we don't do  this than it will return the value of the list which is inside the list
      correspondence[value] = i;

      // Remember = correspondence[key] is Our key , correspondence[value] is Our Value
      
    }
    return [];
  }
}