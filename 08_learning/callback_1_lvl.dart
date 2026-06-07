class Calculator {


  void main(){
    calculate(1, 2, (a,b)=>a+b);
    calculate(1, 2, (a,b)=>a%b);
    calculate(1, 2, (a,b)=>a*b);
  }

  void calculate(double a, double b, CalculateCallback operation){
    double res = operation.call(a, b);
    print("result: $res");
  }
}


typedef CalculateCallback = double Function(double a, double b);