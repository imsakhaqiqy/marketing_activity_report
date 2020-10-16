//import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class SimulationModel{
  String namaPensiun;
  String gajiPensiun;
  String tanggalLahir;
  String jenisSimulasi;
  String jenisKredit;
  String bankBayarPensiun;
  String umur;
  String umurPembulatan;
  String umurDetail;
  String iir;
  String jangWaktu;
  String jenisAsuransi;
  String bungaEfektif;
  String bungaAnuitas;
  String angsuranMaksimal;
  String plafondMaksimal;
  String jangkaWaktuMaksimal;
  String angsuranPerbulan;
  String iirPinjaman;
  String sisaGaji;
  String biayaProvisi;
  String biayaAdministrasi;
  String biayaMaterai;
  String biayaAsuransi;
  String totalBiaya;
  String blokirAngsuran;
  String takeoverBankLain;
  String totalPotongan;
  String terimaBersih;
  String messageText;
  String nilai;
  
  //BUAT CONSTRUCTOR AGAR KETIKA CLASS INI DILOAD, MAKA DATA YANG DIMINTA HARUS DIPASSING SESUAI TIPE DATA YANG DITETAPKAN
  SimulationModel({
    this.namaPensiun,
    this.gajiPensiun,
    this.tanggalLahir,
    this.jenisSimulasi,
    this.jenisKredit,
    this.bankBayarPensiun,
    this.umur,
    this.umurPembulatan,
    this.umurDetail,
    this.iir,
    this.jangWaktu,
    this.jenisAsuransi,
    this.bungaEfektif,
    this.bungaAnuitas,
    this.angsuranMaksimal,
    this.plafondMaksimal,
    this.jangkaWaktuMaksimal,
    this.angsuranPerbulan,
    this.iirPinjaman,
    this.sisaGaji,
    this.biayaProvisi,
    this.biayaAdministrasi,
    this.biayaMaterai,
    this.biayaAsuransi,
    this.totalBiaya,
    this.blokirAngsuran,
    this.takeoverBankLain,
    this.totalPotongan,
    this.terimaBersih,
    this.messageText,
    this.nilai
  });
  
  //FUNGSI INI UNTUK MENGUBAH FORMAT DATA DARI JSON KE FORMAT YANG SESUAI DENGAN EMPLOYEE MODEL
  factory SimulationModel.fromJson(Map<String, dynamic> json) => SimulationModel(
    namaPensiun: json['nama_pensiun'],
    gajiPensiun: json['gaji_pensiun'],
    tanggalLahir: json['tanggal_lahir'],
    jenisSimulasi: json['jenis_simulasi'],
    jenisKredit: json['jenis_kredit'],
    bankBayarPensiun: json['bank_bayar_pensiun'],
    umur: json['umur'],
    umurPembulatan: json['umur_pembulatan'],
    umurDetail: json['umur_detail'],
    iir: json['iir'],
    jangWaktu: json['jw'],
    jenisAsuransi: json['jenis_asuransi'],
    bungaEfektif: json['bunga_efektif'],
    bungaAnuitas: json['bunga_anuitas'],
    angsuranMaksimal: json['angsuran_maksimal'],
    plafondMaksimal: json['plafond_maksimal'],
    jangkaWaktuMaksimal: json['jangka_waktu_maksimal'],
    angsuranPerbulan: json['angsuran_perbulan'],
    iirPinjaman: json['iir_pinjaman'],
    sisaGaji: json['sisa_gaji'],
    biayaProvisi: json['biaya_provisi'],
    biayaAdministrasi: json['biaya_administrasi'],
    biayaMaterai: json['biaya_materai'],
    biayaAsuransi: json['biaya_asuransi'],
    totalBiaya: json['total_biaya'],
    blokirAngsuran: json['blokir_angsuran'],
    takeoverBankLain: json['takeover_bank_lain'],
    totalPotongan: json['total_potongan'],
    terimaBersih: json['terima_bersih'],
    messageText: json['message'],
    nilai: json['nilai']
  );
  
}
