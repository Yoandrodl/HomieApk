class ServiceItem {
  final String id;
  final String title;
  final String shortSubtitle;
  final String badge;
  final List<String> tags;
  final List<String> highlights;
  final String iconEmoji;

  const ServiceItem({
    required this.id,
    required this.title,
    required this.shortSubtitle,
    required this.badge,
    required this.tags,
    required this.highlights,
    required this.iconEmoji,
  });

  static List<ServiceItem> get mainServices => const [
        ServiceItem(
          id: 'kiloan',
          title: 'Cuci Kiloan & Express',
          shortSubtitle: 'Pilihan express kilat 2 jam hingga reguler & langganan bulanan.',
          badge: 'TERPOPULER',
          iconEmoji: '🧺',
          tags: [
            'Express 2 Jam',
            'Express 3 Jam',
            'Express 5 Jam',
            'Same Day',
            '1x24 Jam',
            'Reguler',
            'Paket Bulanan',
          ],
          highlights: [
            '1 Mesin 1 Pelanggan (Higienis & tidak pernah dicampur)',
            'Setrika uap licin dan rapi bebas gosong',
            'Deterjen premium wangi mewah & tahan berhari-hari',
            'Free Antar Jemput radius hingga 3 km',
          ],
        ),
        ServiceItem(
          id: 'ambal',
          title: 'Cuci Ambal & Sajadah',
          shortSubtitle: 'Pembersihan mendalam ambal rumah, kantor, dan sajadah masjid se-Samarinda.',
          badge: 'KHAS SAMARINDA',
          iconEmoji: '🕌',
          tags: [
            'Ambal Rumah / Tamu',
            'Ambal Masjid & Musholla',
            'Sajadah Panjang',
            'Sajadah Satuan',
          ],
          highlights: [
            'Sedot debu & tungau dengan vakum berkekuatan tinggi',
            'Pencucian higienis menjaga kesucian alas ibadah',
            'Pengeringan tuntas tanpa bau apek sedikitpun',
            'Siap jemput langsung ke alamat rumah atau masjid Anda',
          ],
        ),
        ServiceItem(
          id: 'sepatu',
          title: 'Cuci Sepatu & Tas Treatment',
          shortSubtitle: 'Perawatan mendalam sneakers, kulit, suede, dan tas kesayangan.',
          badge: 'CARE TREATMENT',
          iconEmoji: '👟',
          tags: [
            'Deep Clean',
            'Fast Clean',
            'Unyellowing Sol Kuning',
            'Perawatan Tas Kulit & Canvas',
          ],
          highlights: [
            'Sabun khusus pH netral aman untuk serat & lem sol',
            'Sikat bertahap sesuai material (suede, nubuck, canvas)',
            'Deodorizing anti-bakteri pembunuh bau apek kaki',
            'Hasil bersih kinclong seperti baru',
          ],
        ),
      ];

  static List<Map<String, String>> get satuanItems => const [
        {
          'nama': 'Jas & Blazer Formal',
          'deskripsi': 'Dry clean / wet clean lembut dengan setrika uap presisi agar kerah dan bentuk tetap tegak.',
          'emoji': '👔',
        },
        {
          'nama': 'Gaun, Gamis & Kebaya',
          'deskripsi': 'Perawatan aman untuk payet, manik-manik, bordir, dan kain sutra/brokat.',
          'emoji': '👗',
        },
        {
          'nama': 'Bedcover & Selimut Tebal',
          'deskripsi': 'Pencucian tuntas, bebas tungau, wangi lembut, dan di-packing rapi rapat.',
          'emoji': '🛏️',
        },
        {
          'nama': 'Boneka (Kecil s/d Jumbo)',
          'deskripsi': 'Bebas kuman & debu alergen, aman dipeluk kembali oleh si kecil.',
          'emoji': '🧸',
        },
        {
          'nama': 'Gorden & Vitrase',
          'deskripsi': 'Mengembalikan warna cerah gorden dan menghilangkan debu tebal menahun.',
          'emoji': '🪟',
        },
        {
          'nama': 'Stroller & Perlengkapan Bayi',
          'deskripsi': 'Sterilisasi bahan ramah bayi tanpa deterjen keras yang menyebabkan alergi kulit.',
          'emoji': '👶',
        },
      ];
}
