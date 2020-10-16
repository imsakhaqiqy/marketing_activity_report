import 'package:kreditpensiun_apps/Screens/models/history_income_model.dart';
import 'package:kreditpensiun_apps/Screens/models/planning_interaction_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HistoryIncomeItem {
  String nik;

  HistoryIncomeItem(this.nik);
}

class HistoryIncomeProvider extends ChangeNotifier {
  List<HistoryIncomeModel> _data = [];
  List<HistoryIncomeModel> get dataHistoryIncome => _data;

  Future<List<HistoryIncomeModel>> getHistoryIncome(
      HistoryIncomeItem historyItem) async {
    final url =
        'https://www.nabasa.co.id/api_marsit_v1/index.php/getHistoryIncome';
    final response = await http.post(url, body: {'nik_sales': historyItem.nik});
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = json
          .decode(response.body)['Daftar_Disbursment']
          .cast<Map<String, dynamic>>();
      _data = result
          .map<HistoryIncomeModel>((json) => HistoryIncomeModel.fromJson(json))
          .toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
