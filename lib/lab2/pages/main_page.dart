import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:my_project/lab2/elements/main/pages_list.dart';
import 'package:my_project/lab2/logic/model/fitness_data.dart';
import 'package:my_project/lab2/logic/service/tracker/fitness_data_service.dart';
import 'package:my_project/lab2/widgets/custom_bottom_navigation_bar.dart';
import 'package:my_project/lab2/widgets/custom_drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final FitnessDataService _fitnessDataService = FitnessDataService();
  List<FitnessData> _fitnessDataList = [];
  int _selectedIndex = 0;

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _loadFitnessDataList();
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        _showNoInternetDialog();
      }
    });
  }

  void _showNoInternetDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No Internet Connection'),
          content: const Text('You have lost connection to the internet.'
              ' Some features may not be available.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  void onItemTapped(
    BuildContext context,
    int index,
    void Function(int) updateIndex,
  ) {
    if (index < pagesList(context).length) {
      updateIndex(index);
    } else if (index == 2) {
      Navigator.pushNamed(context, '/profile').then((_) {
        updateIndex(0);
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      onItemTapped(context, index, updateIndex);
    });
  }

  void updateIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _loadFitnessDataList() async {
    final data = await _fitnessDataService.loadFitnessDataList();
    setState(() => _fitnessDataList = data);
  }

  Future<void> _addFitnessData() async {
    await _showAddDataDialog();
  }

  Future<void> _deleteFitnessData(int index) async {
    await _fitnessDataService.deleteFitnessData(index);
    _loadFitnessDataList();
  }

  Future<void> _showAddDataDialog() async {
    final idController = TextEditingController();
    final stepsController = TextEditingController();
    final caloriesController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Fitness Data'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextField(
                  controller: idController,
                  decoration: const InputDecoration(hintText: 'Enter id'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: stepsController,
                  decoration: const InputDecoration(hintText: 'Enter steps'),
                  keyboardType: TextInputType.text,
                ),
                TextField(
                  controller: caloriesController,
                  decoration:
                      const InputDecoration(hintText: 'Enter calories burned'),
                  keyboardType: TextInputType.text,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () async {
                final id = int.parse(idController.text);
                final steps = stepsController.text;
                final calories = caloriesController.text;
                final newData = FitnessData(
                  id: id,
                  steps: steps,
                  caloriesBurned: calories,
                );
                await _fitnessDataService.addFitnessData(newData);

                _loadFitnessDataList();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Tracker'),
      ),
      drawer: const CustomDrawer(),
      body: _selectedIndex == 1
          ? FutureBuilder<List<FitnessData>>(
              future: _fitnessDataService.loadFitnessDataList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final item = snapshot.data![index];
                      return ListTile(
                        title: Text('Steps: ${item.steps}, '
                            ' Calories Burned: ${item.caloriesBurned}'),
                        trailing: Wrap(
                          spacing: 12,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                await _fitnessDataService
                                    .deleteFitnessData(item.id);
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            )
          : Center(
              child: _selectedIndex < pagesList(context).length
                  ? pagesList(context).elementAt(_selectedIndex)
                  : Container(),
            ),
      floatingActionButton: _selectedIndex == 1
          ? FloatingActionButton(
              onPressed: _addFitnessData,
              tooltip: 'Add Data',
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

}
