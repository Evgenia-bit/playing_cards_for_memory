import 'package:flutter/material.dart';
import 'package:memory_cards/features/game/game_model.dart';
import 'package:memory_cards/features/game/game_view.dart';
import 'package:provider/provider.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameModel(),
      child: const MaterialApp(
        home: SafeArea(
          child: Scaffold(
            backgroundColor: Color.fromRGBO(144, 175, 210, 1),
            body: GameView(),
          ),
        ),
      ),
    );
  }
}

