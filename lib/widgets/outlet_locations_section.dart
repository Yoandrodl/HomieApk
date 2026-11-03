import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_config.dart';
import '../services/launcher_service.dart';

class OutletLocationsSection extends StatelessWidget {
  const OutletLocationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.storefront_rounded, color: AppColors.primary, size: 22),
              SizedBox(width: 8),
              Text(
                'Lokasi Outlet Homie Laundry',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Kunjungi outlet terdekat atau pesan antar jemput gratis ke alamat Anda di Samarinda.',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 16),

          // Outlet 1: Cabang Pusat Aminah Syukur
          _buildOutletCard(
            title: AppConfig.centralBranchName,
            address: AppConfig.centralBranchAddress,
            phone: '0811-4102-0169 (Pusat Order)',
            mapsUrl: AppConfig.centralMapsUrl,
            isCentral: true,
          ),

          const SizedBox(height: 12),

          // Outlet 2: Cabang Pasar Pagi KH Khalid
          _buildOutletCard(
            title: AppConfig.branchTwoName,
            address: AppConfig.branchTwoAddress,
            phone: '0811-4102-0169',
            mapsUrl: AppConfig.branchTwoMapsUrl,
            isCentral: false,
          ),

          const SizedBox(height: 20),

          // Website Official Banner Button
          InkWell(
            onTap: () => LauncherService.openWebsite(AppConfig.websiteUrl),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: const Row(
                children: [
                  Icon(Icons.language_rounded, color: AppColors.primary, size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Website Resmi Homie Laundry',
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark,
                          ),
                        ),
                        Text(
                          'homielaundrysamarinda.com',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.open_in_new_rounded, size: 16, color: AppColors.textMuted),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: 16),

          // Footer
          Center(
            child: Column(
              children: [
                const Text(
                  'Homie Laundry Samarinda',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Buka Setiap Hari: 08:00 - 20:00 WITA',
                  style: TextStyle(
                    fontSize: 11.5,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Melayani Antar Jemput Seluruh Wilayah Samarinda',
                  style: TextStyle(
                    fontSize: 10.5,
                    color: AppColors.textMuted.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutletCard({
    required String title,
    required String address,
    required String phone,
    required String mapsUrl,
    required bool isCentral,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isCentral ? AppColors.primary.withValues(alpha: 0.4) : AppColors.border,
          width: isCentral ? 1.5 : 1,
        ),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
              if (isCentral) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'PUSAT',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 6),
          Text(
            address,
            style: const TextStyle(
              fontSize: 11.5,
              color: AppColors.textDark,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.phone_outlined, size: 13, color: AppColors.textMuted),
              const SizedBox(width: 6),
              Text(
                'WA: $phone',
                style: const TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => LauncherService.openGoogleMaps(mapsUrl),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primaryDark,
                side: const BorderSide(color: AppColors.primary, width: 1),
                padding: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.directions_outlined, size: 15),
              label: const Text(
                'Buka Rute Google Maps',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
