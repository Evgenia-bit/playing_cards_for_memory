
import 'package:flutter/material.dart';
import 'package:memory_cards/features/card/card_view.dart';
import 'package:memory_cards/features/game/game_model.dart';
import 'package:provider/provider.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    final gameStatus = context.select((GameModel model) => model.gameStatus);
    if (gameStatus == GameStatus.isOver) {
      return const _OverGame();
    }
    return Column(
      children: [
        const _CardGrid(),
        if (gameStatus == GameStatus.notStarted) const _StartButton(),
        const SizedBox(height: 30),
      ],
    );
  }
}

class _OverGame extends StatelessWidget {
  const _OverGame({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Game is over',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        const SizedBox(height: 30),
        Center(
          child: _Button(
            text: 'PLAY AGAIN',
            onPressed: context.read<GameModel>().reload,
          ),
        ),
      ],
    );
  }
}

class _StartButton extends StatelessWidget {
  const _StartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return _Button(
      text: 'START',
      onPressed: context.read<GameModel>().start,
    );
  }
}


class _CardGrid extends StatelessWidget {
  const _CardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final cardsList = context.select((GameModel model) => model.gameCardsList);

    return Expanded(
      child: GridView.count(
        padding: const EdgeInsets.all(20),
        childAspectRatio: 0.7,
        crossAxisSpacing: 20,
        mainAxisSpacing: 25,
        crossAxisCount: 3,
        children: cardsList
            .map(
              (gameCard) => ChangeNotifierProvider.value(
            value: gameCard,
            child: const CardView(),
          ),
        )
            .toList(),
      ),
    );
  }
}


class _Button extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const _Button({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: FilledButton(
        onPressed: onPressed,
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            Colors.white
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );
  }
}