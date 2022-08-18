import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import '../../models/client.dart';

class Clients with ChangeNotifier {
  List<Client> _clients = [];

  set populateClients(List<Client> clients) {
    _clients = clients;
  }

  void addClient(Client client) {
    _clients.add(client);
  }

  List<String> getClientTypes(String pattern) {
    List<String> types = [];
    for (var type in _clients) {
      if (type.name.toLowerCase().contains(pattern.toLowerCase())) {
        types.add(type.name);
      }
    }
    return types;
  }

  bool doesExist(String name) {
    bool doesExist = false;
    _clients.firstWhereOrNull((element) {
      if (element.name.trim().toLowerCase() == name.trim().toLowerCase()) {
        return doesExist = true;
      }
      return doesExist = false;
    });
    return doesExist;
  }
}
