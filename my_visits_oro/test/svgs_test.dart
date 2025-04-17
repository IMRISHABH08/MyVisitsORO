import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:unicards/resources/resources.dart';

void main() {
  test('svgs assets test', () {
    expect(File(Svgs.oroMoneyOnTheWay).existsSync(), isTrue);
  });
}
