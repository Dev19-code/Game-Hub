import 'package:flutter/material.dart';

class WordDisplay extends StatelessWidget {
  final String targetWord;
  final Set<String> guessedLetters;

  const WordDisplay({
    super.key,
    required this.targetWord,
    required this.guessedLetters,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: targetWord.split('').map((letter) {
        final isGuessed = guessedLetters.contains(letter);
        return Container(
          width: 40,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 3,
                color: Theme.of(context).highlightColor,
              ),
            ),
          ),
          child: Text(
            isGuessed ? letter : "",
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        );
      }).toList(),
    );
  }
}
