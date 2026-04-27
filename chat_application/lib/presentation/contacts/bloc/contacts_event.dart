import 'package:equatable/equatable.dart';

abstract class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object?> get props => [];
}

class LoadContacts extends ContactsEvent {
  const LoadContacts();
}

class AddContact extends ContactsEvent {
  final String name;
  final String? phone;

  const AddContact({required this.name, this.phone});

  @override
  List<Object?> get props => [name, phone];
}

class DeleteContact extends ContactsEvent {
  final String contactId;

  const DeleteContact(this.contactId);

  @override
  List<Object?> get props => [contactId];
}

class SearchContacts extends ContactsEvent {
  final String query;

  const SearchContacts(this.query);

  @override
  List<Object?> get props => [query];
}
