class PipelineModel {
  String id;
  String tglPipeline;
  String tempatLahir;
  String tanggalLahir;
  String jenisKelamin;
  String noKtp;
  String npwp;
  String namaNasabah;
  String alamat;
  String telepon;
  String jenisProduk;
  String plafond;
  String cabang;
  String keterangan;
  String status;
  String statusKredit;
  String pengelolaPensiun;
  String bankTakeover;
  String tglPenyerahan;
  String namaPenerima;
  String teleponPenerima;
  String foto1;
  String foto2;
  String fotoTandaTerima;
  String tanggalAkad;
  String nomorAplikasi;
  String nomorPerjanjian;
  String nominalPinjaman;
  String akadProduk;
  String salesInfo;
  String namaPetugasBank;
  String jabatanPetugasBank;
  String teleponPetugasBank;
  String fotoAkad1;
  String fotoAkad2;
  String keluhan;

  //BUAT CONSTRUCTOR AGAR KETIKA CLASS INI DILOAD, MAKA DATA YANG DIMINTA HARUS DIPASSING SESUAI TIPE DATA YANG DITETAPKAN
  PipelineModel({
    this.id,
    this.tglPipeline,
    this.tempatLahir,
    this.tanggalLahir,
    this.jenisKelamin,
    this.noKtp,
    this.npwp,
    this.namaNasabah,
    this.alamat,
    this.telepon,
    this.jenisProduk,
    this.plafond,
    this.cabang,
    this.keterangan,
    this.status,
    this.statusKredit,
    this.pengelolaPensiun,
    this.bankTakeover,
    this.tglPenyerahan,
    this.namaPenerima,
    this.teleponPenerima,
    this.foto1,
    this.foto2,
    this.fotoTandaTerima,
    this.tanggalAkad,
    this.nomorAplikasi,
    this.nomorPerjanjian,
    this.nominalPinjaman,
    this.akadProduk,
    this.salesInfo,
    this.namaPetugasBank,
    this.jabatanPetugasBank,
    this.teleponPetugasBank,
    this.fotoAkad1,
    this.fotoAkad2,
    this.keluhan,
  });

  //FUNGSI INI UNTUK MENGUBAH FORMAT DATA DARI JSON KE FORMAT YANG SESUAI DENGAN EMPLOYEE MODEL
  factory PipelineModel.fromJson(Map<String, dynamic> json) => PipelineModel(
        id: json['id'],
        tglPipeline: json['tgl_pipeline'],
        tempatLahir: json['tempat_lahir'],
        tanggalLahir: json['tgl_lahir'],
        jenisKelamin: json['jenis_kelamin'],
        noKtp: json['no_ktp'],
        npwp: json['npwp'],
        namaNasabah: json['cadeb'],
        alamat: json['alamat'],
        telepon: json['telepon'],
        jenisProduk: json['jenis_produk'],
        plafond: json['nominal'],
        cabang: json['cabang'],
        keterangan: json['keterangan'],
        status: json['status'],
        statusKredit: json['status_kredit'],
        pengelolaPensiun: json['pengelola_pensiun'],
        bankTakeover: json['bank_takeover'],
        tglPenyerahan: json['tgl_penyerahan'],
        namaPenerima: json['nama_penerima'],
        teleponPenerima: json['telepon_penerima'],
        foto1: json['foto1'],
        foto2: json['foto2'],
        fotoTandaTerima: json['foto_tanda_submit'],
        tanggalAkad: json['tanggal_akad'],
        nomorAplikasi: json['nomor_aplikasi'],
        nomorPerjanjian: json['nomor_perjanjian'],
        nominalPinjaman: json['nominal_pinjaman'],
        akadProduk: json['akad_produk'],
        salesInfo: json['sales_info'],
        namaPetugasBank: json['nama_petugas_bank'],
        jabatanPetugasBank: json['jabatan_petugas_bank'],
        teleponPetugasBank: json['telepon_petugas_bank'],
        fotoAkad1: json['foto_akad1'],
        fotoAkad2: json['foto_akad2'],
        keluhan: json['keluhan'],
      );
}
