class PromoBanner {
  final String title;
  final String description;
  final String promoCode;
  final String badge;
  final bool isActive;

  const PromoBanner({
    required this.title,
    required this.description,
    required this.promoCode,
    required this.badge,
    this.isActive = true,
  });

  factory PromoBanner.fromJson(Map<String, dynamic> json) {
    final status = (json['status'] ?? 'Aktif').toString().trim().toLowerCase();
    return PromoBanner(
      title: (json['judul_promo'] ?? '').toString().trim(),
      description: (json['keterangan'] ?? '').toString().trim(),
      promoCode: (json['kode_promo'] ?? '').toString().trim(),
      badge: (json['badge'] ?? 'PROMO').toString().trim(),
      isActive: status == 'aktif' || status == 'active',
    );
  }

  factory PromoBanner.fromCsvRow(List<String> row) {
    // Expected row: [judul_promo, keterangan, kode_promo, badge, status]
    return PromoBanner(
      title: row.isNotEmpty ? row[0].trim() : '',
      description: row.length > 1 ? row[1].trim() : '',
      promoCode: row.length > 2 ? row[2].trim() : '',
      badge: row.length > 3 ? row[3].trim() : 'PROMO',
      isActive: row.length > 4 ? row[4].trim().toLowerCase() == 'aktif' || row[4].trim().toLowerCase() == 'active' : true,
    );
  }

  // Banner Bawaan (Default Offline Fallback) jika Google Sheets belum disetup atau internet lambat
  static List<PromoBanner> get defaultPromos => const [
        PromoBanner(
          title: 'Jumat Berkah Cuci Sepatu',
          description: 'Diskon 20% khusus order antar-jemput cuci sepatu di hari Jumat.',
          promoCode: 'JUMATBERKAH',
          badge: 'DISKON 20%',
          isActive: true,
        ),
        PromoBanner(
          title: 'Weekend Cuci Sepatu & Tas',
          description: 'Treatment deep clean & unyellowing bikin sepatu kinclong akhir pekan.',
          promoCode: 'WEEKENDCLEAN',
          badge: 'SPECIAL WEEKEND',
          isActive: true,
        ),
        PromoBanner(
          title: 'Cuci Ambal & Sajadah Suci',
          description: 'Sedot debu mendalam, basmi tungau & wangi segar tahan lama.',
          promoCode: 'AMBALSUCI',
          badge: 'BEST SELLER',
          isActive: true,
        ),
        PromoBanner(
          title: 'Express 3 Jam & Same Day',
          description: 'Baju bersih, rapi setrika uap, dan wangi siap pakai dalam hitungan jam.',
          promoCode: 'EXPRESSKILAT',
          badge: 'KILAT',
          isActive: true,
        ),
      ];
}
