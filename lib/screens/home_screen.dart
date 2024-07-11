import 'package:flutter/material.dart';
import 'package:flutter_node_express_mongo/pages/chat_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'WhatsApp Clone',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          IconTheme(
            data: IconThemeData(color: Colors.white),
            child: PopupMenuButton<String>(
              onSelected: (value) {
                print(value);
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    value: 'New group',
                    child: Text('New group'),
                  ),
                  PopupMenuItem(
                    value: 'New broadcast',
                    child: Text('New broadcast'),
                  ),
                  PopupMenuItem(
                    value: 'WhatsApp web',
                    child: Text('WhatsApp web'),
                  ),
                  PopupMenuItem(
                    value: 'Starred messages',
                    child: Text('Starred messages'),
                  ),
                  PopupMenuItem(
                    value: 'Settings',
                    child: Text('Settings'),
                  ),
                ];
              },
            ),
          ),
        ],
        bottom: TabBar(
          indicatorColor: Colors.white,
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(
              icon: Icon(Icons.camera_alt),
            ),
            Tab(
              text: "Chats",
            ),
            Tab(
              text: "Status",
            ),
            Tab(
              text: "Calls",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Text('Camera'),
          ChatPage(),
          Text('Status'),
          Text('Calls'),
        ],
      ),
    );
  }
}
