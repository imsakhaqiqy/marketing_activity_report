import 'package:kreditpensiun_apps/Screens/models/simulation_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: camel_case_types
class simulationItem {
  String simulasiJenis;
  String namaPensiun;
  String gajiPensiun;
  String tanggalLahir;
  String jenisSimulasi;
  String jenisKredit;
  String bankBayarPensiun;
  String plafondPinjaman;
  String jangkaWaktu;
  String jenisAsuransi;
  String blokirAngsuran;
  String takeoverBankLain;
  String angsuranPerbulan;
  String batasUsiaPensiun;
  String tht;
  String niksales;
  simulationItem(
    this.simulasiJenis,
    this.namaPensiun,
    this.gajiPensiun,
    this.tanggalLahir,
    this.jenisSimulasi,
    this.jenisKredit,
    this.bankBayarPensiun,
    this.plafondPinjaman,
    this.jangkaWaktu,
    this.jenisAsuransi,
    this.blokirAngsuran,
    this.takeoverBankLain,
    this.angsuranPerbulan,
    this.batasUsiaPensiun,
    this.tht,
    this.niksales,
  );
}

class SimulationProvider extends ChangeNotifier {
  List<SimulationModel> _data = [];
  List<SimulationModel> get dataSimulation => _data;

  Future<List<SimulationModel>> getSimulation(simulationItem simulation) async {
    String url = '';
    if (simulation.simulasiJenis == 'gp') {
      url =
          'https://www.nabasa.co.id/api_marsit_v1/index.php/getSimulationGracePeriod';
    } else if (simulation.simulasiJenis == 'tht') {
      url = 'https://www.nabasa.co.id/api_marsit_v1/index.php/getSimulationTht';
    } else if (simulation.simulasiJenis == 'regular') {
      url = 'https://www.nabasa.co.id/api_marsit_v1/index.php/getSimulation';
    } else if (simulation.simulasiJenis == 'aktif') {
      url =
          'https://www.nabasa.co.id/api_marsit_v1/index.php/getSimulationAktif';
    } else {
      url =
          'https://www.nabasa.co.id/api_marsit_v1/index.php/getSimulationPrapensiun';
    }
    final response = await http.post(url, body: {
      'nama_pensiun': simulation.namaPensiun,
      'gaji_pensiun': simulation.gajiPensiun,
      'tanggal_lahir': simulation.tanggalLahir,
      'jenis_simulasi': simulation.jenisSimulasi,
      'jenis_kredit': simulation.jenisKredit,
      'bank_bayar_pensiun': simulation.bankBayarPensiun,
      'plafond_pinjaman': simulation.plafondPinjaman,
      'jangka_waktu': simulation.jangkaWaktu,
      'jenis_asuransi': simulation.jenisAsuransi,
      'blokir_pinjaman': simulation.blokirAngsuran,
      'takeover_bank_lain': simulation.takeoverBankLain,
      'angsuran_perbulan': simulation.angsuranPerbulan,
      'batas_usia_pensiun': simulation.batasUsiaPensiun,
      'tht': simulation.tht,
      'niksales': simulation.niksales,
    });

    if (response.statusCode == 200) {
      final result = json
          .decode(response.body)['Daftar_Simulasi']
          .cast<Map<String, dynamic>>();
      _data = result
          .map<SimulationModel>((json) => SimulationModel.fromJson(json))
          .toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
