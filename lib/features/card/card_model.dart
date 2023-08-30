import 'package:flutter/material.dart';

enum CardStatus { hidden, shown, guessed }

class CardModel extends ChangeNotifier {
  final String imageFileName;
  CardStatus _status = CardStatus.shown;
  CardStatus get status => _status;
  set status(CardStatus v) {
    _status = v;
    notifyListeners();
  }

  CardModel({required this.imageFileName});
}

class EmptyGameCard extends CardModel {
  EmptyGameCard() : super(imageFileName: '');
}
