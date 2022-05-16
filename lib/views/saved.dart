import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pairings/config/globals.dart' as globals;
import '../models/favorites.dart';
import '../services/db_connector.dart';

class SavedPage extends StatefulWidget {
  @override
  _SavedPageState createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> with TickerProviderStateMixin {
  bool lockInBackground = false;
  late TabController _tabController;

  List<Favorite> favoritesList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future init() async {
    final favoritesList = await DBconnect().getFav(globals.currentUser);

    setState(() {
      this.favoritesList = favoritesList!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Saved',
          style: TextStyle(fontSize: 25),
        ),
        bottom: TabBar(
            indicatorColor: Color.fromARGB(255, 78, 40, 69),
            controller: _tabController,
            tabs: const <Widget>[
              Tab(text: 'Individual'),
              Tab(text: 'Pairings')
            ]),
      ),
      body: TabBarView(controller: _tabController, children: const <Widget>[
        Center(
          child: Text(
            'Sign in to see saved individual items.',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        Center(
          child: Text(
            'Sign in to see saved pairings.',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]),
    );
  }

  Widget buildSavedResults(Favorite saved) => ListTile(
        title: Text(
          "${saved.wineId} ${saved.foodId}",
          style: const TextStyle(color: Colors.white),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.close),
          color: Colors.white,
          onPressed: () {},
        ),
      );
}
