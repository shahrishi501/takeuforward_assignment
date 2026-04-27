import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/contact_model.dart';
import '../../data/repositories/chat_repository.dart';
import '../chat/chat_screen.dart';
import 'bloc/contacts_bloc.dart';
import 'bloc/contacts_event.dart';
import 'bloc/contacts_state.dart';
import 'widgets/contact_tile.dart';
import 'widgets/new_contact_dialog.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen>
    with SingleTickerProviderStateMixin {
  late final ContactsBloc _bloc;
  late final TabController _tabController;
  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _bloc = ContactsBloc(repository: ChatRepository())..add(const LoadContacts());
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _bloc.close();
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldWhite,
        appBar: _buildAppBar(),
        body: BlocBuilder<ContactsBloc, ContactsState>(
          builder: (context, state) {
            if (state is ContactsInitial || state is ContactsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }
            if (state is ContactsError) {
              return _buildError(state.message);
            }
            if (state is ContactsLoaded) {
              return _buildBody(context, state);
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showNewContactDialog,
          backgroundColor: AppColors.primary,
          tooltip: 'New chat',
          child: const Icon(Icons.chat, color: Colors.white),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.headerDark,
      title: _isSearching
          ? TextField(
              controller: _searchController,
              autofocus: true,
              style: const TextStyle(color: Colors.white, fontSize: 18),
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.white60),
                border: InputBorder.none,
              ),
              onChanged: (q) => _bloc.add(SearchContacts(q)),
            )
          : const Text('WhatsFlutter'),
      actions: [
        IconButton(
          icon: Icon(_isSearching ? Icons.close : Icons.search),
          tooltip: _isSearching ? 'Close search' : 'Search',
          onPressed: _toggleSearch,
        ),
        if (!_isSearching)
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
      ],
      bottom: TabBar(
        controller: _tabController,
        indicatorColor: Colors.white,
        indicatorWeight: 3,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white54,
        labelStyle:
            const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, letterSpacing: 0.5),
        tabs: const [
          Tab(text: 'ALL'),
          Tab(text: 'UNREAD'),
          Tab(text: 'FAVORITES'),
          Tab(text: 'GROUPS'),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, ContactsLoaded state) {
    return TabBarView(
      controller: _tabController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildList(context, state.filteredContacts, state.searchQuery),
        _buildList(
          context,
          state.filteredContacts.where((c) => c.unreadCount > 0).toList(),
          state.searchQuery,
        ),
        _buildEmptyTab('No favorites yet'),
        _buildEmptyTab('No groups yet'),
      ],
    );
  }

  Widget _buildList(BuildContext context, List<Contact> contacts, String query) {
    if (contacts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              query.isNotEmpty ? Icons.search_off : Icons.chat_bubble_outline,
              size: 64,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              query.isNotEmpty
                  ? 'No results for "$query"'
                  : 'No chats yet.\nTap ➕ to start a new conversation.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 15),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: contacts.length,
      separatorBuilder: (_, __) => const Divider(height: 1, indent: 70, endIndent: 0),
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return ContactTile(
          contact: contact,
          onTap: () => _openChat(context, contact),
        );
      },
    );
  }

  Widget _buildEmptyTab(String label) {
    return Center(
      child: Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 15)),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
          const SizedBox(height: 12),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 12),
          FilledButton.tonal(
            onPressed: () => _bloc.add(const LoadContacts()),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  void _toggleSearch() {
    setState(() => _isSearching = !_isSearching);
    if (!_isSearching) {
      _searchController.clear();
      _bloc.add(const SearchContacts(''));
    }
  }

  void _openChat(BuildContext context, Contact contact) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ChatScreen(contact: contact)),
    ).then((_) {
      // Refresh contact list so last-message + unread count update after returning.
      _bloc.add(const LoadContacts());
    });
  }

  Future<void> _showNewContactDialog() async {
    final result = await showDialog<Map<String, String?>>(
      context: context,
      builder: (_) => const NewContactDialog(),
    );
    if (result != null && mounted) {
      _bloc.add(AddContact(name: result['name']!, phone: result['phone']));
    }
  }
}
