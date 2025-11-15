import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_mobile_test/models/ticket.dart';
import 'package:ticket_mobile_test/provider/ticket_provider.dart';

class TicketDetailScreen extends StatelessWidget {
  final Ticket ticket;
  const TicketDetailScreen({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TicketProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Ticket"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              ticket.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),
            Text(
              ticket.description,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),
            Text("Category: ${ticket.category}"),
            Text("Status: ${ticket.status}"),
            Text("Date: ${ticket.createdAt}"),

            const SizedBox(height: 30),

            const Text("Change Status:", style: TextStyle(fontSize: 16)),

            Row(
              children: [
                _statusButton(context, provider, "OPEN"),
                _statusButton(context, provider, "IN_PROGRESS"),
                _statusButton(context, provider, "DONE"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusButton(BuildContext context, TicketProvider provider, String newStatus) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ElevatedButton(
        onPressed: () async {
          await provider.updateStatus(ticket.id!, newStatus);
          Navigator.pop(context); // kembali ke list
        },
        child: Text(newStatus.replaceAll("_", " ")),
      ),
    );
  }
}
