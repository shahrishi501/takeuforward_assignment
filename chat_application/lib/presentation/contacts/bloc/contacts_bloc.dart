import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../data/models/contact_model.dart';
import '../../../data/repositories/chat_repository.dart';
import 'contacts_event.dart';
import 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final ChatRepository _repository;
  static const _uuid = Uuid();

  ContactsBloc({required ChatRepository repository})
      : _repository = repository,
        super(const ContactsInitial()) {
    on<LoadContacts>(_onLoad);
    on<AddContact>(_onAdd);
    on<DeleteContact>(_onDelete);
    on<SearchContacts>(_onSearch);
  }

  Future<void> _onLoad(LoadContacts event, Emitter<ContactsState> emit) async {
    emit(const ContactsLoading());
    try {
      final contacts = await _repository.getContacts();
      _sort(contacts);
      emit(ContactsLoaded(contacts: contacts, filteredContacts: contacts));
    } catch (e) {
      emit(ContactsError('Failed to load contacts: $e'));
    }
  }

  Future<void> _onAdd(AddContact event, Emitter<ContactsState> emit) async {
    try {
      final contact = Contact(
        id: _uuid.v4(),
        name: event.name.trim(),
        phone: event.phone?.trim().isEmpty == true ? null : event.phone?.trim(),
      );
      final current = _currentContacts();
      final updated = [contact, ...current];
      await _repository.saveContacts(updated);
      emit(ContactsLoaded(contacts: updated, filteredContacts: updated));
    } catch (e) {
      emit(ContactsError('Failed to add contact: $e'));
    }
  }

  Future<void> _onDelete(DeleteContact event, Emitter<ContactsState> emit) async {
    try {
      final updated = _currentContacts().where((c) => c.id != event.contactId).toList();
      await _repository.saveContacts(updated);
      emit(ContactsLoaded(contacts: updated, filteredContacts: updated));
    } catch (e) {
      emit(ContactsError('Failed to delete contact: $e'));
    }
  }

  void _onSearch(SearchContacts event, Emitter<ContactsState> emit) {
    if (state is! ContactsLoaded) return;
    final loaded = state as ContactsLoaded;
    final q = event.query.toLowerCase().trim();
    final filtered = q.isEmpty
        ? loaded.contacts
        : loaded.contacts.where((c) {
            return c.name.toLowerCase().contains(q) ||
                (c.phone?.contains(q) ?? false) ||
                (c.lastMessage?.toLowerCase().contains(q) ?? false);
          }).toList();
    emit(loaded.copyWith(filteredContacts: filtered, searchQuery: event.query));
  }

  List<Contact> _currentContacts() =>
      state is ContactsLoaded ? (state as ContactsLoaded).contacts : [];

  void _sort(List<Contact> contacts) {
    contacts.sort((a, b) {
      final ta = a.lastMessageTime;
      final tb = b.lastMessageTime;
      if (ta == null && tb == null) return 0;
      if (ta == null) return 1;
      if (tb == null) return -1;
      return tb.compareTo(ta);
    });
  }
}
