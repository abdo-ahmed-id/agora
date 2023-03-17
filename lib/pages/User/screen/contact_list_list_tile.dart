import 'package:flutter/material.dart';

class ContactListTile extends StatelessWidget {
  const ContactListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        alignment: Alignment.center,
        width: 36,
        height: 36,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
        child: Text(
          "Farah".substring(0, 1),
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      title: const Text(
        "Farah❤️",
        style: TextStyle(fontSize: 22),
      ),
      subtitle: const Text("Video Call"),
      trailing: const Text("6 days ago"),
    );
  }
}
