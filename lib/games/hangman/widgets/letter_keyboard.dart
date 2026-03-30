import 'package:flutter/material.dart';

class LetterKeyboard extends StatelessWidget {
  final Set<String> guessedLetters;
  final Function(String) onLetterGuessed;
  final bool isDisabled;

  const LetterKeyboard({
    super.key,
    required this.guessedLetters,
    required this.onLetterGuessed,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    const letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 6,
      runSpacing: 6,
      children: letters.split('').map((letter) {
        final isGuessed = guessedLetters.contains(letter);
        return ActionChip(
          label: Text(letter, textAlign: TextAlign.center),
          backgroundColor: Theme.of(context).primaryColor,
          side: BorderSide(color: Colors.blueGrey),
          // Disable button if game is over or letter is already guessed
          onPressed: (isGuessed || isDisabled)
              ? null
              : () => onLetterGuessed(letter),
        );
      }).toList(),
    );
  }
}
