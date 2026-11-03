import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_config.dart';
import '../services/launcher_service.dart';
import 'metro_tile_card.dart';

class MetroOutletTiles extends StatelessWidget {
  const MetroOutletTiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // Outlet 1: Aminah Syukur
          Expanded(
            child: MetroTileCard(
              backgroundColor: const Color(0xFF1E1E1E),
              leftAccentColor: AppColors.lumiaCyan,
              height: 125,
              onTap: () => LauncherService.openGoogleMaps(AppConfig.centralMapsUrl),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('📍', style: TextStyle(fontSize: 20)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        color: AppColors.lumiaCyan,
                        child: const Text(
                          'PUSAT',
                          style: TextStyle(
                            fontSize: 8.5,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Aminah Syukur 13',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 1),
                      Text(
                        'Samarinda Kota',
                        style: TextStyle(fontSize: 10, color: Colors.white60),
                      ),
                    ],
                  ),
                  const Text(
                    'Rute Maps ↗',
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      color: AppColors.lumiaCyan,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 10),

          // Outlet 2: KH M Khalid
          Expanded(
            child: MetroTileCard(
              backgroundColor: const Color(0xFF1E1E1E),
              leftAccentColor: AppColors.accentAmber,
              height: 125,
              onTap: () => LauncherService.openGoogleMaps(AppConfig.branchTwoMapsUrl),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('📍', style: TextStyle(fontSize: 20)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        color: AppColors.accentAmber,
                        child: const Text(
                          'PASAR PAGI',
                          style: TextStyle(
                            fontSize: 8.5,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'KH M Khalid 38A',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 1),
                      Text(
                        'Pasar Pagi',
                        style: TextStyle(fontSize: 10, color: Colors.white60),
                      ),
                    ],
                  ),
                  const Text(
                    'Rute Maps ↗',
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      color: AppColors.accentAmber,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
