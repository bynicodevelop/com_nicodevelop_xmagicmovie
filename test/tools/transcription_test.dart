import 'package:com_nicodevelop_xmagicmovie/models/transcription/word_model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/transcription_model.dart';
import 'package:com_nicodevelop_xmagicmovie/tools/transcription.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  late Transcription transcription;

  // before
  setUp(() {
    transcription = Transcription();
  });

  group('containSpecialChar', () {
    test('should return true if the word contains a special character', () {
      const word = "I'm";
      final result = transcription.containSpecialChar(word);
      expect(result, true);
    });

    test('should return false if the word does not contain a special character',
        () {
      const word = "Im";
      final result = transcription.containSpecialChar(word);
      expect(result, false);
    });
  });

  group('normalizeSequence', () {
    test('should return a normalized sequence', () {
      const text = "I'm a test";
      final result = transcription.normalizeSequence(text);
      expect(result, "i m a test");
    });

    test('should return a normalized sequence without accents', () {
      const text = "I'm à test";
      final result = transcription.normalizeSequence(text);
      expect(result, "i m a test");
    });

    test('should return a normalized sequence without special characters', () {
      const text = "I'm a test!";
      final result = transcription.normalizeSequence(text);
      expect(result, "i m a test");
    });
  });

  group('createSentencesFromGroups', () {
    test('should create sentences from grouped words', () {
      // Arrange
      final transcriptionModel = TranscriptionWithGroupedWordsModel(
        text: "hello world",
        words: [
          WordModel(word: 'hello', start: 0.0, end: 0.5),
          WordModel(word: 'world', start: 0.6, end: 1.0),
        ],
        groups: [
          WordModel(word: 'hello', start: 0.0, end: 0.5),
          WordModel(word: 'world', start: 0.6, end: 1.0),
        ],
        duration: 1.0,
        language: "en",
      );

      // Act
      final result = transcription.createSentencesFromGroups(
        transcriptionModel,
      );

      // Assert
      expect(result.length, equals(1));
      expect(result[0].words.length, equals(2));
      expect(result[0].words[0].word, equals("hello"));
      expect(result[0].words[1].word, equals("world"));
    });

    test('should create sentences from grouped words with special characters',
        () {
      // Arrange
      final transcriptionModel = TranscriptionWithGroupedWordsModel(
        text: "it's a test-case",
        words: [
          WordModel(word: 'it', start: 0.0, end: 0.3),
          WordModel(word: 's', start: 0.3, end: 0.4),
          WordModel(word: 'a', start: 0.5, end: 0.6),
          WordModel(word: 'test', start: 0.7, end: 1.0),
          WordModel(word: 'case', start: 1.1, end: 1.5),
        ],
        groups: [
          WordModel(word: 'it\'s', start: 0.0, end: 0.4),
          WordModel(word: 'a', start: 0.5, end: 0.6),
          WordModel(word: 'test-case', start: 0.7, end: 1.5),
        ],
        duration: 1.5,
        language: "en",
      );

      // Act
      final result = transcription.createSentencesFromGroups(
        transcriptionModel,
      );

      // Assert
      expect(result.length, equals(1));
      expect(result[0].words.length, equals(3));
      expect(result[0].words[0].word, equals("it's"));
      expect(result[0].words[1].word, equals("a"));
      expect(result[0].words[2].word, equals("test-case"));
    });

    test('should create sentences from grouped words with mixed cases', () {
      // Arrange
      final transcriptionModel = TranscriptionWithGroupedWordsModel(
        text: "HELLO world. hello",
        words: [
          WordModel(word: 'hello', start: 0.0, end: 0.5),
          WordModel(word: 'world', start: 0.6, end: 1.0),
          WordModel(word: 'hello', start: 1.1, end: 1.5),
        ],
        groups: [
          WordModel(word: 'HELLO', start: 0.0, end: 0.5),
          WordModel(word: 'world', start: 0.6, end: 1.0),
          WordModel(word: 'hello', start: 1.1, end: 1.5),
        ],
        duration: 1.5,
        language: "en",
      );

      // Act
      final result = transcription.createSentencesFromGroups(
        transcriptionModel,
      );

      // Assert
      expect(result.length, equals(2));
      expect(result[0].words.length, equals(2));
      expect(result[0].words[0].word, equals("HELLO"));
      expect(result[0].words[1].word, equals("world"));
      expect(result[1].words.length, equals(1));
      expect(result[1].words[0].word, equals("hello"));
    });
  });

  group('groupWords', () {
    test('should group simple words correctly', () {
      // Arrange
      final srtSentence = TranscriptionWithGroupedWordsModel(
        text: "hello world",
        words: [
          WordModel(word: 'hello', start: 0.0, end: 0.5),
          WordModel(word: 'world', start: 0.6, end: 1.0),
        ],
        groups: [],
        duration: 1.0,
        language: "en",
      );

      // Act
      final result = transcription.groupWords(srtSentence);

      // Assert
      expect(result.groups.length, equals(2));
      expect(result.groups[0].word, equals("hello"));
      expect(result.groups[1].word, equals("world"));
    });

    test('should handle words with special characters correctly', () {
      // Arrange
      final srtSentence = TranscriptionWithGroupedWordsModel(
        text: "it's a test-case",
        words: [
          WordModel(word: 'it', start: 0.0, end: 0.3),
          WordModel(word: 's', start: 0.3, end: 0.4),
          WordModel(word: 'a', start: 0.5, end: 0.6),
          WordModel(word: 'test', start: 0.7, end: 1.0),
          WordModel(word: 'case', start: 1.1, end: 1.5),
        ],
        groups: [],
        duration: 1.5,
        language: "en",
      );

      // Act
      final result = transcription.groupWords(srtSentence);

      // Assert
      expect(result.groups.length, equals(3));
      expect(result.groups[0].word, equals("it's"));
      expect(result.groups[1].word, equals("a"));
      expect(result.groups[2].word, equals("test-case"));
    });

    test('should return empty group when sentence has no matching words', () {
      // Arrange
      final srtSentence = TranscriptionWithGroupedWordsModel(
        text: "non matching sentence",
        words: [
          WordModel(word: 'hello', start: 0.0, end: 0.5),
          WordModel(word: 'world', start: 0.6, end: 1.0),
        ],
        groups: [],
        duration: 1.0,
        language: "en",
      );

      // Act
      final result = transcription.groupWords(srtSentence);

      // Assert
      expect(result.groups.isEmpty, isTrue);
    });

    test('should normalize and group words with mixed cases correctly', () {
      // Arrange
      final srtSentence = TranscriptionWithGroupedWordsModel(
        text: "HELLO world",
        words: [
          WordModel(word: 'hello', start: 0.0, end: 0.5),
          WordModel(word: 'world', start: 0.6, end: 1.0),
        ],
        groups: [],
        duration: 1.0,
        language: "en",
      );

      // Act
      final result = transcription.groupWords(srtSentence);

      // Assert
      expect(result.groups.length, equals(2));
      expect(result.groups[0].word,
          equals("HELLO")); // attendu en minuscule après normalisation
      expect(result.groups[1].word, equals("world"));
    });

    test('should handle cases where normalized word matches SRT words', () {
      // Arrange
      final srtSentence = TranscriptionWithGroupedWordsModel(
        text: "HELLO-World",
        words: [
          WordModel(word: 'hello', start: 0.0, end: 0.5),
          WordModel(word: 'world', start: 0.6, end: 1.0),
        ],
        groups: [],
        duration: 1.0,
        language: "en",
      );

      // Act
      final result = transcription.groupWords(srtSentence);

      // Assert
      expect(result.groups.length, equals(1));
      expect(result.groups[0].word, equals("HELLO-World"));
      expect(result.groups[0].start, equals(0.0));
      expect(result.groups[0].end, equals(1.0));
    });

    test('should handle cases where normalized word matches SRT words', () {
      // Arrange
      final srtSentence = TranscriptionWithGroupedWordsModel(
        text: "TotalEnergie,",
        words: [
          WordModel(
            word: 'TotalEnergie',
            start: 0.0,
            end: 0.5,
          ),
        ],
        groups: [],
        duration: 1.0,
        language: "en",
      );

      // Act
      final result = transcription.groupWords(srtSentence);

      // Assert
      expect(result.groups.length, equals(1));
      expect(result.groups[0].word, equals("TotalEnergie,"));
    });
  });

  group('setGroupedWord', () {
    test('should return correct WordModel when words match', () {
      // Arrange
      const word = "hello-world";
      final splittedWord = ['hello', 'world'];
      final words = [
        WordModel(word: 'hello', start: 0.0, end: 0.5),
        WordModel(word: 'world', start: 0.6, end: 1.0),
      ];

      // Act
      final result = transcription.setGroupedWord(word, splittedWord, words)!;

      // Assert
      expect(result.word, equals(word));
      expect(result.start, equals(0.0));
      expect(result.end, equals(1.0));
    });

    test('should handle words with special characters correctly', () {
      // Arrange
      const word = "it's-test";
      final splittedWord = ["it", "s", 'test'];
      final words = [
        WordModel(word: 'it', start: 0.0, end: 0.3),
        WordModel(word: 's', start: 0.3, end: 0.4),
        WordModel(word: 'test', start: 0.5, end: 1.0),
      ];

      // Act
      final result = transcription.setGroupedWord(word, splittedWord, words)!;

      // Assert
      expect(result.word, equals(word));
      expect(result.start, equals(0.0));
      expect(result.end, equals(1.0));
    });

    test('should return first start and last end time', () {
      // Arrange
      const word = "united-states";
      final splittedWord = ['united', 'states'];
      final words = [
        WordModel(word: 'united', start: 1.0, end: 1.5),
        WordModel(word: 'states', start: 1.6, end: 2.0),
      ];

      // Act
      final result = transcription.setGroupedWord(word, splittedWord, words)!;

      // Assert
      expect(result.start, equals(1.0));
      expect(result.end, equals(2.0));
    });

    test('should handle single word correctly', () {
      // Arrange
      const word = "hello";
      final splittedWord = ['hello'];
      final words = [
        WordModel(word: 'hello', start: 0.0, end: 0.5),
      ];

      // Act
      final result = transcription.setGroupedWord(word, splittedWord, words)!;

      // Assert
      expect(result.word, equals(word));
      expect(result.start, equals(0.0));
      expect(result.end, equals(0.5));
    });

    test('should return correct duration when word spans multiple timings', () {
      // Arrange
      const word = "long-compound-word";
      final splittedWord = ['long', 'compound', 'word'];
      final words = [
        WordModel(word: 'long', start: 0.0, end: 0.5),
        WordModel(word: 'compound', start: 0.6, end: 1.2),
        WordModel(word: 'word', start: 1.3, end: 2.0),
      ];

      // Act
      final result = transcription.setGroupedWord(word, splittedWord, words)!;

      // Assert
      expect(result.start, equals(0.0));
      expect(result.end, equals(2.0));
    });

    test('should handle case where word does not match any SRT word', () {
      // Arrange
      const word = "non-matching";
      final splittedWord = ['non', 'matching'];
      final words = [
        WordModel(word: 'hello', start: 0.0, end: 0.5),
        WordModel(word: 'world', start: 0.6, end: 1.0),
      ];

      // Act
      final result = transcription.setGroupedWord(word, splittedWord, words);

      // Assert
      expect(result, isNull);
    });
  });

  group('createGroupedWord', () {
    test('should group word with special characters', () {
      // Arrange
      const word = "it’s-test";
      final words = [
        WordModel(word: 'it', start: 0.0, end: 0.3),
        WordModel(word: 's', start: 0.3, end: 0.4),
        WordModel(word: 'test', start: 0.5, end: 1.0),
      ];

      // Act
      final result = transcription.createGroupedWord(word, words)!;

      // Assert
      expect(result.word, equals(word));
      expect(result.start, equals(0.0));
      expect(result.end, equals(1.0));
    });

    test('should handle single word without special characters', () {
      // Arrange
      const word = "hello";
      final words = [
        WordModel(word: 'hello', start: 0.0, end: 0.5),
        WordModel(word: 'world', start: 0.6, end: 1.0),
      ];

      // Act
      final result = transcription.createGroupedWord(word, words)!;

      // Assert
      expect(result.word, equals("hello"));
      expect(result.start, equals(0.0));
      expect(result.end, equals(0.5));
    });

    test('should handle words with hyphens', () {
      // Arrange
      const word = "non-matching";
      final words = [
        WordModel(word: 'non', start: 0.0, end: 0.5),
        WordModel(word: 'matching', start: 0.6, end: 1.0),
      ];

      // Act
      final result = transcription.createGroupedWord(word, words)!;

      // Assert
      expect(result.word, equals("non-matching"));
      expect(result.start, equals(0.0));
      expect(result.end, equals(1.0));
    });

    test('should return null for non-matching word', () {
      // Arrange
      const word = "different";
      final words = [
        WordModel(word: 'hello', start: 0.0, end: 0.5),
        WordModel(word: 'world', start: 0.6, end: 1.0),
      ];

      // Act
      final result = transcription.createGroupedWord(word, words);

      // Assert
      expect(result, isNull);
    });

    test('should handle empty word list', () {
      // Arrange
      const word = "hello";
      final words = <WordModel>[];

      // Act
      final result = transcription.createGroupedWord(word, words);

      // Assert
      expect(result, isNull);
    });

    test('should group word with apostrophes correctly', () {
      // Arrange
      const word = "it's";
      final words = [
        WordModel(word: 'it', start: 0.0, end: 0.3),
        WordModel(word: 's', start: 0.3, end: 0.4),
      ];

      // Act
      final result = transcription.createGroupedWord(word, words)!;

      // Assert
      expect(result.word, equals("it's"));
      expect(result.start, equals(0.0));
      expect(result.end, equals(0.4));
    });
  });
}
