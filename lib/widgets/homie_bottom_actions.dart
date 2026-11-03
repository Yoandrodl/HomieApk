import 'package:flutter/material.dart';
import '../core/app_config.dart';
import '../services/launcher_service.dart';
import 'metro_tile_card.dart';

class HomieBottomActions extends StatelessWidget {
  final VoidCallback onWhatsAppTap;

  const HomieBottomActions({
    super.key,
    required this.onWhatsAppTap,
  });

  void _showBranchPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF131926),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.fromLTRB(
            16,
            16,
            16,
            MediaQuery.of(context).padding.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '📍 Kunjungi Outlet Homie Laundry',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white70, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Cabang 1: Aminah Syukur
              ListTile(
                tileColor: const Color(0xFF1E2536),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                leading: const Icon(Icons.storefront_rounded, color: Color(0xFF38BDF8)),
                title: const Text(
                  AppConfig.centralBranchName,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13),
                ),
                subtitle: const Text(
                  'Jl. Aminah Syukur No. 13, Samarinda Kota',
                  style: TextStyle(color: Colors.white70, fontSize: 11),
                ),
                trailing: const Icon(Icons.directions_outlined, color: Color(0xFF38BDF8)),
                onTap: () {
                  Navigator.pop(context);
                  LauncherService.openGoogleMaps(AppConfig.centralMapsUrl);
                },
              ),
              const SizedBox(height: 10),

              // Cabang 2: KH M Khalid
              ListTile(
                tileColor: const Color(0xFF1E2536),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                leading: const Icon(Icons.storefront_rounded, color: Color(0xFFFBBF24)),
                title: const Text(
                  AppConfig.branchTwoName,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13),
                ),
                subtitle: const Text(
                  'Jl. KH M Khalid No. 38A, Pasar Pagi',
                  style: TextStyle(color: Colors.white70, fontSize: 11),
                ),
                trailing: const Icon(Icons.directions_outlined, color: Color(0xFFFBBF24)),
                onTap: () {
                  Navigator.pop(context);
                  LauncherService.openGoogleMaps(AppConfig.branchTwoMapsUrl);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          // 1. WhatsApp Button (Green Tile)
          Expanded(
            child: MetroTileCard(
              backgroundColor: const Color(0xFF10B981),
              leftAccentColor: const Color(0xFF065F46),
              height: 72,
              onTap: onWhatsAppTap,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: const Text('💬', style: TextStyle(fontSize: 18)),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pesan Antar',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: -0.2,
                          ),
                        ),
                        Text(
                          '1-Klik via WA',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFD1FAE5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Icon(
                      Icons.chevron_right_rounded,
                      size: 15,
                      color: Color(0xFF10B981),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 8),

          // 2. Outlet Location (Islamic Center Photo Tile)
          Expanded(
            child: MetroTileCard(
              backgroundColor: const Color(0xFF1E2536),
              leftAccentColor: const Color(0xFF38BDF8),
              height: 72,
              onTap: () => _showBranchPicker(context),
              padding: EdgeInsets.zero,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Stack(
                  children: [
                    // Background Image (Islamic Center Samarinda)
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/islamic_center_samarinda.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                    ),

                    // Dark overlay for readability
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withValues(alpha: 0.85),
                              Colors.black.withValues(alpha: 0.55),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ),
                    ),

                    // Content
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 5),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Aminah Syukur No. 13',
                                  style: TextStyle(
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Samarinda Kota',
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.white70,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'KH M Khalid 38A',
                                  style: TextStyle(
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Pasar Pagi',
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 18,
                            height: 18,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.chevron_right_rounded,
                              size: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
