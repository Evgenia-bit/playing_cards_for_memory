
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:memory_cards/features/card/card_model.dart';
import 'package:memory_cards/features/game/game_model.dart';
import 'package:provider/provider.dart';

class CardView extends StatelessWidget {
  const CardView({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.watch<CardModel>().status;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      transitionBuilder: (widget, animation) {
        final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
        return AnimatedBuilder(
          animation: rotateAnim,
          child: widget,
          builder: (context, widget) {
            final value = min(rotateAnim.value, pi / 2);
            return Transform(
              transform: Matrix4.rotationY(value),
              alignment: Alignment.center,
              child: widget,
            );
          },
        );
      },
      child: switch (status) {
        CardStatus.hidden => const _CardBack(key: ValueKey('back')),
        CardStatus.shown => const _CardFront(key: ValueKey('front')),
        _ => const SizedBox.shrink(key: ValueKey('empty')),
      },
    );
  }
}

class _CardFront extends StatelessWidget {
  const _CardFront({super.key});

  @override
  Widget build(BuildContext context) {
    final imageFileName = context.read<CardModel>().imageFileName;
    return _CardWrapper(
      child: Image.asset('assets/$imageFileName'),
    );
  }
}

class _CardBack extends StatelessWidget {
  const _CardBack({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final card = context.read<CardModel>();
        context.read<GameModel>().showCard(card);
      },
      child: _CardWrapper(
        child: Image.asset('assets/card.png', fit: BoxFit.fitHeight),
      ),
    );
  }
}

class _CardWrapper extends StatelessWidget {
  final Widget child;

  const _CardWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: Card(
        elevation: 10,
        color: Colors.white,
        child: child,
      ),
    );
  }
}
