import 'package:contact_list_app/style.dart';
import 'package:flutter/material.dart';

import 'contact.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  List<Contact> contacts = List.empty(growable: true);
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Contact List',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25), topLeft: Radius.circular(25))),
        toolbarHeight: 80,
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TextField(
                controller: nameController,
                decoration: AppInputDecoration('Name')),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: contactController,
              decoration: AppInputDecoration('Number'),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  flex: 100,
                  child: ElevatedButton(
                      style: AppButtonStyle(),
                      onPressed: () {
                        String name = nameController.text.trim();
                        String contact = contactController.text.trim();
                        if (name.isNotEmpty && contact.isNotEmpty) {
                          setState(() {
                            nameController.text = '';
                            contactController.text = '';
                            contacts.add(Contact(name: name, contact: contact));
                          });
                        }
                      },
                      child: Text(
                        "Add",
                        style: ButtonTextStyle(),
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            contacts.isEmpty
                ? const Text(
                    '',
                    style: TextStyle(fontSize: 22),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: contacts.length,
                      itemBuilder: (context, index) => getRow(index),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget getRow(int index) {
    return InkWell(
      onLongPress: () {
        _showDeleteConfirmationDialog(index);
      },
      child: Card(
        color: Colors.white70,
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  children: [
                    Expanded(
                        flex: 10,
                        child: Icon(
                          Icons.perm_contact_cal_sharp,
                          color: Colors.brown,
                        )),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 84,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            contacts[index].name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                          Text(contacts[index].contact),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.phone,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Center(
            child: Text(
          'Confirmation',
        )),
        content: const Text('Are you sure for Delete?'),
        actions: [
          IconButton(
            icon: const Icon(Icons.cancel, color: Colors.red),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.blue),
            onPressed: () {
              _deleteContact(index);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void _deleteContact(int index) {
    setState(() {
      contacts.removeAt(index);
    });
  }
}
