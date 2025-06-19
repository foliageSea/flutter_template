import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  late AppLogger logger;

  setUp(() {
    logger = AppLogger();
  });

  group('AppLogger', () {
    test('should be singleton', () {
      final anotherInstance = AppLogger();
      expect(identical(logger, anotherInstance), isTrue);
    });

    test('log method should work', () {
      expect(() => logger.log('Test log message'), returnsNormally);
    });

    test('info method should work', () {
      expect(() => logger.info('Test info message'), returnsNormally);
    });

    test('warning method should work', () {
      expect(() => logger.warning('Test warning message'), returnsNormally);
    });

    test('handle method should work with exception', () {
      expect(
        () => logger.handle(Exception('Test exception')),
        returnsNormally,
      );
    });

    test('handle method should work with stack trace', () {
      try {
        throw Exception('Test exception with stack trace');
      } catch (e, st) {
        expect(() => logger.handle(e, st), returnsNormally);
      }
    });

    test('talker getter should return Talker instance', () {
      expect(logger.talker, isA<Talker>());
    });
  });
}
