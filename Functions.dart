void main(List<String> args) {
  for (int x = 1000; x >= 0; x -= 7) {
    print(Sigil(x));
  }
}

int Sigil(int nomer) {
  int x = nomer * 2;
  return x;
}
