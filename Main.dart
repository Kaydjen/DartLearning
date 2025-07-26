import 'dart:io';
import 'TODO/Halo.dart';
import 'TODO/options.dart';

void main() {
  void setConsoleSize(int height, int width) {
    // ANSI escape code to set terminal size (works in most Unix-like terminals)
    stdout.write('\x1B[8;1000;100t');
  }
  Halo.Halo1();
  Halo.Clear();
  Options.options1();
}
