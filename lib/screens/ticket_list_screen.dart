import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_mobile_test/provider/ticket_provider.dart';
import 'package:ticket_mobile_test/screens/ticket_add_screen.dart';
import 'package:ticket_mobile_test/screens/ticket_detail_screen.dart';

class TicketListScreen extends StatefulWidget {
  const TicketListScreen({super.key});

  @override
  State<TicketListScreen> createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen> {
  String filter = "ALL";

  final filters = ["ALL", "OPEN", "IN_PROGRESS", "DONE"];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TicketProvider>(context);
    final data =
        provider.tickets.where((t) {
          if (filter == "ALL") return true;
          return t.status == filter;
        }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Tickets")),

      body: Column(
        children: [
          const SizedBox(height: 10),
          _buildFilterButtons(),
          const SizedBox(height: 10),

          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, i) {
                final t = data[i];
                return ListTile(
                  title: Text(t.title),
                  subtitle: Text("${t.description} • ${t.status}"),
                  trailing: PopupMenuButton<String>(
                    onSelected: (v) => provider.updateStatus(t.id!, v),
                    itemBuilder:
                        (_) => const [
                          PopupMenuItem(value: "OPEN", child: Text("OPEN")),
                          PopupMenuItem(
                            value: "IN_PROGRESS",
                            child: Text("IN PROGRESS"),
                          ),
                          PopupMenuItem(value: "DONE", child: Text("DONE")),
                        ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TicketDetailScreen(ticket: t),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddTicketScreen()),
            ),
      ),
    );
  }

  Widget _buildFilterButtons() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            filters.map((f) {
              final isSelected = (f == filter);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: GestureDetector(
                  onTap: () => setState(() => filter = f),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.red : Colors.blue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      f.replaceAll("_", " "),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
