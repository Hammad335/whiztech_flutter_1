import 'package:flutter/material.dart';

import '../models/client.dart';

class ClientProvider with ChangeNotifier {
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

  bool doesExist(String type) {
    bool doesExist = false;
    try {
      _clients.firstWhere((element) {
        if (element.name == type) {
          return doesExist = true;
        } else {
          return doesExist = false;
        }
      });
    } catch (e) {
      doesExist = false;
    }
    return doesExist;
  }
}
