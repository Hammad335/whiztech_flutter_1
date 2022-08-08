import 'package:flutter/material.dart';

class CardStateProvider with ChangeNotifier {
  late String _selectedCard;

  void setSelectedCard(String cardName) {
    _selectedCard = cardName;
  }

  String getSelectedCard() {
    return _selectedCard;
  }
}
