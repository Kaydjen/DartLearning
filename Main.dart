import 'dart:io';
import 'TODO/Halo.dart';
import 'TODO/options.dart';

void main() {
  stdout.write('\x1B[8;${64};${30}t');
  Halo.Halo1();
  Options.options1();
}
