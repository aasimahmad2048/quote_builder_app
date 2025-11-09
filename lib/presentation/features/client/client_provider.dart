// Client Provider
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/data/models/temp_model.dart';

class ClientNotifier extends StateNotifier<List<ClientModel>> {
  final Box<ClientModel> box;

  ClientNotifier(this.box) : super(box.values.toList());

  Future<void> addClient(ClientModel client) async {
    await box.put(client.id, client);
    state = box.values.toList();
  }

  /// Add or update a client
  Future<void> addOrUpdateClient(ClientModel client) async {
    await box.put(client.id, client);
    state = box.values.toList();
  }

  Future<void> deleteClient(String id) async {
    await box.delete(id);
    state = box.values.toList();
  }

  Future<void> updateClientField(
    String id,
    String field,
    dynamic newValue,
  ) async {
    final client = box.get(id);
    if (client != null) {
      final updatedClient = ClientModel(
        id: client.id,
        name: field == 'name' ? newValue : client.name,
        email: field == 'email' ? newValue : client.email,
        phone: field == 'phone' ? newValue : client.phone,
        address: field == 'address' ? newValue : client.address,
        type: field == 'type' ? newValue : client.type,
      );
      await box.put(id, updatedClient);
      state = box.values.toList();
    }
  }

  ClientModel? getClientById(String id) {
    return box.get(id);
  }

  List<ClientModel> get clients => state;

  Future<void> clearClients() async {
    await box.clear();
    state = [];
  }

  Future<void> loadClients() async {
    state = box.values.toList();
  }

  Future<List<ClientModel>> getClients() async {
    state = box.values.toList();
    return state;
  }
}

final clientProvider = StateNotifierProvider<ClientNotifier, List<ClientModel>>(
  (ref) => ClientNotifier(Hive.box<ClientModel>('ClientBox')),
);
