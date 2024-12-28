import 'package:com_nicodevelop_xmagicmovie/models/transcription/sentence_model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/transcription/word_model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/transcription_model.dart';
import 'package:unorm_dart/unorm_dart.dart' as unorm;

class Transcription {
  bool containSpecialChar(String word) {
    return RegExp(r"['’-]").hasMatch(word);
  }

  String normalizeSequence(String text) {
    return unorm
        .nfd(text) // Normalise les caractères (décomposition)
        .replaceAll(RegExp(r'[\u0300-\u036f]'), '') // Retire les accents
        .replaceAll(RegExp(r"[^\w\s]"),
            ' ') // Remplace les caractères non-alphanumériques par des espaces (y compris les apostrophes)
        .replaceAll(RegExp(r'\s+'),
            ' ') // Remplace les espaces multiples par un seul espace
        .trim() // Supprime les espaces de début et de fin
        .toLowerCase(); // Convertit en minuscules
  }

  List<SentenceModel> createSentences(
    TranscriptionModel transcription,
  ) {
    final TranscriptionWithGroupedWordsModel groupedTranscription =
        groupWords(transcription);

    return createSentencesFromGroups(groupedTranscription);
  }

  List<SentenceModel> createSentencesFromGroups(
    TranscriptionWithGroupedWordsModel transcription,
  ) {
    final List<SentenceModel> sentences = [];
    final List<WordModel> currentSentenceWords = [];
    final String text = transcription.text;

    // Diviser en phrases
    final List<String> sentenceBoundaries =
        text.split(RegExp(r'(?<=[.,:?!])\s+'));

    int currentGroupIndex = 0;

    for (final boundary in sentenceBoundaries) {
      // Assurez-vous que la phrase n'est pas vide
      if (boundary.trim().isEmpty) continue;

      // Supprimer la ponctuation de la frontière pour la comparaison
      final normalizedBoundary =
          boundary.replaceAll(RegExp(r'[.,:?!]'), '').trim().toLowerCase();

      while (currentGroupIndex < transcription.groups.length) {
        final word = transcription.groups[currentGroupIndex];
        currentSentenceWords.add(word);

        // Construire la phrase actuelle à partir des mots sans ponctuation
        final joinedWords = currentSentenceWords
            .map((w) =>
                w.word.replaceAll(RegExp(r'[.,:?!]'), '').trim().toLowerCase())
            .join(' ');

        // Vérifier si cette phrase correspond exactement à la frontière actuelle
        if (joinedWords == normalizedBoundary) {
          sentences.add(SentenceModel(words: List.from(currentSentenceWords)));
          currentSentenceWords.clear(); // Réinitialiser pour la phrase suivante
          currentGroupIndex++; // Passer au mot suivant
          break;
        }

        currentGroupIndex++;
      }
    }

    // Ajouter les mots restants comme dernière phrase, s'il y en a
    if (currentSentenceWords.isNotEmpty) {
      sentences.add(SentenceModel(words: List.from(currentSentenceWords)));
    }

    return sentences;
  }

  TranscriptionWithGroupedWordsModel groupWords(
    TranscriptionModel transcription,
  ) {
    // Découper la phrase en mots
    final sentenceWords = transcription.text.split(' ');
    // Mapper les mots pour les grouper
    final List<WordModel?> combinedWords = sentenceWords.map((word) {
      // Essayer de créer un groupe de mots
      WordModel? result = createGroupedWord(
        word,
        transcription.words,
      );

      // Si le groupe n'a pas été trouvé, essayer avec les mots normalisés
      if (result == null) {
        final normalizedWords = normalizeSequence(word)
            .split(' ')
            .where((w) => w.isNotEmpty)
            .toList();

        result = setGroupedWord(
          word,
          normalizedWords,
          transcription.words,
        );
      }

      return result;
    }).toList();

    // Retourner une nouvelle instance de SrtSentenceModel avec les mots groupés
    return TranscriptionWithGroupedWordsModel(
      text: transcription.text,
      words: transcription.words,
      groups: combinedWords
          .where((word) => word != null)
          .cast<WordModel>()
          .toList(),
      duration: transcription.duration,
      language: transcription.language,
    );
  }

  WordModel? setGroupedWord(
    String word,
    List<String> splittedWord,
    List<WordModel> words,
  ) {
    double? start;
    double? end;
    int indexSplit = 0;
    int foundWords = 0; // Compter le nombre de mots trouvés

    // Parcourt chaque mot divisé de la phrase
    while (indexSplit < splittedWord.length) {
      int startIndex = 0;

      // Parcourt chaque mot du SRT
      bool found = false;
      while (startIndex < words.length) {
        // Compare les mots après normalisation
        if (normalizeSequence(words[startIndex].word) ==
            normalizeSequence(splittedWord[indexSplit])) {
          if (indexSplit == 0) {
            start = words[startIndex].start;
          }
          end = words[startIndex].end;
          found = true;
          foundWords++;
          break; // On arrête la recherche dès qu'on a trouvé le mot
        }
        startIndex++;
      }

      // Si un des mots n'est pas trouvé, on arrête
      if (!found) {
        return null;
      }

      indexSplit++;
    }

    // Si on n'a pas trouvé tous les mots du mot divisé, on retourne null
    if (foundWords != splittedWord.length) {
      return null;
    }

    // Si on a trouvé les mots, on retourne l'objet SrtWordModel
    if (start != null && end != null) {
      return WordModel(
        word: word,
        start: start,
        end: end,
      );
    }

    return null; // Si on n'a pas trouvé de correspondance valable
  }

  WordModel? createGroupedWord(
    String word,
    List<WordModel> words,
  ) {
    // Si le mot contient un caractère spécial
    if (containSpecialChar(word)) {
      // Diviser le mot avec les caractères spéciaux
      final splittedWord = word.split(RegExp(r"['’-]"));

      // Essayer de grouper le mot
      return setGroupedWord(word, splittedWord, words);
    }

    // Parcourir les mots pour trouver une correspondance normalisée
    for (final wordModel in words) {
      if (normalizeSequence(wordModel.word) == normalizeSequence(word)) {
        // Retourner le mot avec la durée calculée
        return WordModel(
          word: word,
          start: wordModel.start,
          end: wordModel.end,
        );
      }
    }

    // Retourner null si aucun mot correspondant n'a été trouvé
    return null;
  }
}
