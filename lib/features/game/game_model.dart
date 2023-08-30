import 'dart:math';

import 'package:flutter/material.dart';
import 'package:memory_cards/features/card/card_model.dart';


enum GameStatus { notStarted, isOn, isOver }

class GameModel extends ChangeNotifier {
  GameModel() {
    generateGameCards();
  }

  final _cardsCount = 12;
  int _guessedPairs = 0;
  CardModel? _shownCard;
  List<String> imageFileNameList = [
    'basketball.png',
    'football.png',
    'tennis-ball.png',
    'badminton.png',
    'kettlebell.png',
    'dumbbell.png',
  ];

  List<CardModel> _gameCardsList = [];

  List<CardModel> get gameCardsList => _gameCardsList;

  GameStatus _gameStatus = GameStatus.notStarted;

  GameStatus get gameStatus => _gameStatus;

  void generateGameCards() {
    _gameCardsList = List.filled(_cardsCount, EmptyGameCard());
    for (String fileName in imageFileNameList) {
      _fillCardsPair(fileName);
    }
    notifyListeners();
  }

  void _fillCardsPair(String fileName) {
    int cardsCount = 0;

    while (cardsCount < 2) {
      final index = Random().nextInt(_cardsCount);
      if (_gameCardsList[index] is! EmptyGameCard) continue;
      _gameCardsList[index] = CardModel(imageFileName: fileName);
      cardsCount++;
    }
  }

  void reload() {
    _gameStatus = GameStatus.notStarted;
    notifyListeners();
    _guessedPairs = 0;
    generateGameCards();
  }

  void start() {
    _gameStatus = GameStatus.isOn;
    notifyListeners();
    for (var card in _gameCardsList) {
      card.status = CardStatus.hidden;
    }
  }

  Future<void> showCard(CardModel card) async {
    card.status = CardStatus.shown;

    await Future.delayed(const Duration(seconds: 1));

    if (_shownCard == null) {
      _shownCard = card;
      return;
    }
    if (_shownCard?.imageFileName == card.imageFileName) {
      _guessPair(card);
    } else {
      _setPairStatus(card, CardStatus.hidden);
    }

    _shownCard = null;
  }

  void _guessPair(CardModel card) {
    _setPairStatus(card, CardStatus.guessed);
    _guessedPairs++;

    if (_guessedPairs == _cardsCount / 2) {
      _gameStatus = GameStatus.isOver;
      notifyListeners();
    }
  }

  void _setPairStatus(CardModel card, CardStatus status) {
    _shownCard?.status = status;
    card.status = status;
  }
}
