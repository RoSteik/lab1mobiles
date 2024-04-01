import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

import 'package:my_project/lab2/logic/model/fitness_data.dart';
import 'package:my_project/lab2/logic/service/tracker/database_helper.dart';

class FitnessDataService {
  static const String baseUrl = 'http://10.0.2.2:8080/api/fitness_data';

  Future<List<FitnessData>> loadFitnessDataList() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return DatabaseHelper.instance.queryAllRows();
    } else {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedResponse =
            jsonDecode(response.body) as Map<String, dynamic>;

        if (decodedResponse['_embedded'] != null &&
            decodedResponse['_embedded']['fitness_datas'] != null) {
          final List<dynamic> fitnessDatas =
              decodedResponse['_embedded']['fitness_datas'] as List<dynamic>;
          final List<FitnessData> fitnessDataList = fitnessDatas
              .map((dynamic item) =>
                    FitnessData.fromJson(item as Map<String, dynamic>),)
              .toList();

          await DatabaseHelper.instance.clearTable();
          for (var data in fitnessDataList) {
            await DatabaseHelper.instance.insert(data);
          }

          return fitnessDataList;
        } else {
          return [];
        }
      } else {
        throw Exception('Failed to load fitness data from API');
      }
    }
  }

  Future<void> addFitnessData(FitnessData data) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      throw Exception('No internet connection. Cannot add data.');
    } else {
      final response = await http.post(
        Uri.parse('$baseUrl/create'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data.toJson()),
      );

      if (response.statusCode == 200) {
        await DatabaseHelper.instance.insert(data);
      } else {
        throw Exception('Failed to add fitness data to API');
      }
    }
  }

  Future<void> deleteFitnessData(int fitnessDataId) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      throw Exception('No internet connection. Cannot delete data.');
    } else {
      final response =
          await http.delete(Uri.parse('$baseUrl/delete/$fitnessDataId'));
      if (response.statusCode == 200) {
        await DatabaseHelper.instance.delete(fitnessDataId);
      } else {
        throw Exception('Failed to delete fitness data from API');
      }
    }
  }
}
