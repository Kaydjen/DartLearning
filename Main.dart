import 'dart:io';
import 'TODO/Halo.dart';
import 'TODO/options.dart';
import 'Maps.dart';
import 'dart:math';
import 'Word_counter.dart';

void main() {
  void setConsoleSize(int height, int width) {
    // ANSI escape code to set terminal size (works in most Unix-like terminals)
    stdout.write('\x1B[8;1000;100t');
  }
    Word_counter.Words();
}
