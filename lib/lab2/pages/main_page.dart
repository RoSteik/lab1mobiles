import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/lab2/elements/main/pages_list.dart';
import 'package:my_project/lab2/logic/model/fitness_data.dart';
import 'package:my_project/lab2/pages/utils/main/fitness_data_bloc.dart';
import 'package:my_project/lab2/pages/utils/main/fitness_data_events.dart';
import 'package:my_project/lab2/pages/utils/main/fitness_data_states.dart';
import 'package:my_project/lab2/widgets/custom_bottom_navigation_bar.dart';
import 'package:my_project/lab2/widgets/custom_drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  late FitnessDataBloc _fitnessDataBloc;

  @override
  void initState() {
    super.initState();

    _fitnessDataBloc = context.read<FitnessDataBloc>();
    _fitnessDataBloc.add(LoadFitnessData());

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
                BlocProvider.of<FitnessDataBloc>(context)
                    .add(AddFitnessData(newData));

                Navigator.of(context).pop();
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
      appBar: AppBar(title: const Text('Fitness Tracker')),
      drawer: const CustomDrawer(),
      body: _selectedIndex == 1
          ? BlocBuilder<FitnessDataBloc, FitnessDataState>(
              builder: (context, state) {
                if (state is FitnessDataLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is FitnessDataLoaded) {
                  return ListView.builder(
                    itemCount: state.fitnessDataList.length,
                    itemBuilder: (context, index) {
                      final item = state.fitnessDataList[index];
                      return ListTile(
                        title: Text('Steps: ${item.steps},'
                            ' Calories Burned: ${item.caloriesBurned}'),
                        trailing: Wrap(
                          spacing: 12,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _fitnessDataBloc
                                  .add(DeleteFitnessData(item.id)),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (state is FitnessDataError) {
                  return Center(child: Text(state.message));
                }
                return const Center(child: Text('No data available'));
              },
            )
          : Center(
              child: _selectedIndex < pagesList(context).length
                  ? pagesList(context).elementAt(_selectedIndex)
                  : Container(),
            ),
      floatingActionButton: _selectedIndex == 1
          ? FloatingActionButton(
              onPressed: _showAddDataDialog,
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
