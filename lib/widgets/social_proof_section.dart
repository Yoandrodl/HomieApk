import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class SocialProofSection extends StatelessWidget {
  const SocialProofSection({super.key});

  @override
  Widget build(BuildContext context) {
    const reviews = [
      {
        'nama': 'M. Rizky Pratama',
        'lokasi': 'Samarinda Ulu',
        'komentar':
            'Cuci sepatu sneakers di sini hasilnya kinclong banget kayak baru keluar dari toko. Sol yang tadinya kuning balik bersih lagi! Recommended banget di Samarinda.',
        'rating': 5,
        'tag': 'Cuci Sepatu',
      },
      {
        'nama': 'Hj. Mardiah',
        'lokasi': 'Samarinda Kota',
        'komentar':
            'Ambal ruang tamu dan sajadah masjid bersih suci, debu hilang total dan wanginya awet berminggu-minggu. Kurir jemputnya juga tepat waktu.',
        'rating': 5,
        'tag': 'Ambal & Sajadah',
      },
      {
        'nama': 'Andi Setiawan',
        'lokasi': 'Sungai Kunjang',
        'komentar':
            'Langganan kiloan express 3 jam. Baju kerja licin rapi setrika uap, wangi deterjennya premium dan yang paling penting 1 mesin 1 nota jadi gak takut ketuker.',
        'rating': 5,
        'tag': 'Kiloan Express',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kepuasan Pelanggan Samarinda',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                      letterSpacing: -0.2,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Ulasan asli Google Maps dari warga lokal Samarinda',
                    style: TextStyle(
                      fontSize: 11.5,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.accentAmberLight,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.accentAmber.withValues(alpha: 0.3)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.star_rounded, color: AppColors.accentAmber, size: 16),
                    SizedBox(width: 4),
                    Text(
                      '4.9 / 5.0',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFB45309),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Reviews horizontal list
          SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: reviews.length,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final r = reviews[index];
                return Container(
                  width: 260,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: List.generate(
                              5,
                              (i) => const Icon(
                                Icons.star_rounded,
                                size: 14,
                                color: AppColors.accentAmber,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceVariant,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              r['tag'] as String,
                              style: const TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Expanded(
                        child: Text(
                          '"${r['komentar']}"',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textDark,
                            height: 1.25,
                            fontStyle: FontStyle.italic,
                          ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: AppColors.primaryLight,
                            child: Text(
                              (r['nama'] as String)[0],
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              '${r['nama']} • ${r['lokasi']}',
                              style: const TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textMuted,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
