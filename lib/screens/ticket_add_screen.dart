import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_mobile_test/provider/ticket_provider.dart';

class AddTicketScreen extends StatefulWidget {
  const AddTicketScreen({super.key});

  @override
  State<AddTicketScreen> createState() => _AddTicketScreenState();
}

class _AddTicketScreenState extends State<AddTicketScreen> {
  final titleC = TextEditingController();
  final descC = TextEditingController();
  final catC = TextEditingController(); // ← category text controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Ticket")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleC,
              decoration: const InputDecoration(labelText: "Title"),
            ),

            TextField(
              controller: descC,
              decoration: const InputDecoration(labelText: "Description"),
            ),

            TextField(
              controller: catC,
              decoration: const InputDecoration(labelText: "Category"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                if (titleC.text.isEmpty) return;

                await Provider.of<TicketProvider>(context, listen: false)
                    .addTicket(
                  titleC.text,
                  descC.text,
                  catC.text, // ← kategori dari user
                );

                Navigator.pop(context);
              },
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}
