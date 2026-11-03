import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class ValuePillarsSection extends StatelessWidget {
  const ValuePillarsSection({super.key});

  @override
  Widget build(BuildContext context) {
    const pillars = [
      {
        'emoji': '🧼',
        'title': 'Deterjen Premium',
        'subtitle': 'Bahan ramah serat & ampuh angkat noda',
      },
      {
        'emoji': '💨',
        'title': 'Setrika Uap',
        'subtitle': 'Pakaian licin sempurna & anti-gosong',
      },
      {
        'emoji': '1️⃣',
        'title': '1 Mesin 1 Nota',
        'subtitle': 'Higienis, tidak pernah dicampur pelanggan lain',
      },
      {
        'emoji': '🌸',
        'title': 'Parfum Mewah',
        'subtitle': 'Aroma segar eksklusif tahan berhari-hari',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kenapa Memilih Homie Laundry?',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: AppColors.textDark,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: pillars.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2.1,
            ),
            itemBuilder: (context, index) {
              final p = pillars[index];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          p['emoji']!,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            p['title']!,
                            style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textDark,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            p['subtitle']!,
                            style: const TextStyle(
                              fontSize: 9.5,
                              color: AppColors.textMuted,
                              height: 1.15,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
