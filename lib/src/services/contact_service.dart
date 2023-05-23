import 'package:nearby_nocard/app_exports.dart';

class ContactService {
  static final ContactService _instance = ContactService._internal();

  factory ContactService() {
    return _instance;
  }

  ContactService._internal();

  // Add a new contact
  Future<void> addContact(Contact contact) async {
    await ContactsService.addContact(contact);
  }

  // Update an existing contact
  Future<void> updateContact(Contact contact) async {
    await ContactsService.updateContact(contact);
  }

  // Delete a contact
  Future<void> deleteContact(Contact contact) async {
    await ContactsService.deleteContact(contact);
  }

  // Get all contacts
  Future<List<Contact>> getAllContacts() async {
    return await ContactsService.getContacts();
  }

  // Search for contacts by name or phone number
  Future<List<Contact>> searchContacts(String query) async {
    return await ContactsService.getContacts(query: query);
  }
}
