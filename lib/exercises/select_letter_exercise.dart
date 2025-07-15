import 'package:flutter/material.dart';
import 'package:learn_lao_app/exercises/select_blank_exercise.dart';

enum BottomButtonState { incorrect, correct }

class SelectLetterExercise extends SelectBlankExercise {
  SelectLetterExercise({
    required super.correctLetter,
    required super.allLetters,
    super.key,
  });

  @override
  SelectLetterExerciseState createState() => SelectLetterExerciseState();
}

class SelectLetterExerciseState
    extends SelectBlankExerciseState<SelectLetterExercise> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      speechPlayer.playLetter(widget.correctLetter);
    });
  }

  @override
  Widget build(BuildContext context) {
    calibrateThemeColors(context);

    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Main sound button
            ElevatedButton(
              onPressed: () => speechPlayer.playLetter(widget.correctLetter),
              style: ElevatedButton.styleFrom(padding: EdgeInsets.all(96)),
              child: Icon(
                Icons.volume_up_rounded,
                size: theme.textTheme.displayLarge?.fontSize,
              ),
            ),
            SizedBox(height: 16),
            // The options
            AbsorbPointer(
              absorbing: areButtonsDisabled,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  spacing: 8.0,
                  // Generates a button for each option
                  children: List<Widget>.generate(shuffledLetters.length, (
                    index,
                  ) {
                    return FilledButton(
                      onPressed: () {
                        setState(() {
                          selectedButton = index;
                        });
                      },
                      style: FilledButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 100,
                        ),
                        // Changes background color based on whether the button is selected
                        backgroundColor: index == selectedButton
                            ? theme.colorScheme.primary
                            : theme.colorScheme.secondary,
                      ),
                      child: Text(
                        shuffledLetters[index],
                        style: TextStyle(
                          fontSize: theme.textTheme.displayLarge?.fontSize,
                          fontFamily: 'NotoSansLaoLooped',
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Spacer(),
            checkButton(),
          ],
        ),
      ),
    );
  }
}
