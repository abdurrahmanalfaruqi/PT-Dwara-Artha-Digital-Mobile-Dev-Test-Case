import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/ticket.dart';

class TicketProvider extends ChangeNotifier {
  List<Ticket> tickets = [];

  Future loadTickets() async {
    tickets = await DatabaseHelper.instance.getTickets();
    notifyListeners();
  }

  Future addTicket(String title, String desc, String cat) async {
    final t = Ticket(
      title: title,
      description: desc,
      category: cat,
      status: "OPEN",
      createdAt: DateTime.now().toIso8601String(),
    );
    await DatabaseHelper.instance.insertTicket(t);
    await loadTickets();
  }

  Future updateStatus(int id, String status) async {
    await DatabaseHelper.instance.updateStatus(id, status);
    await loadTickets();
  }
}
