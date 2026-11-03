import 'package:flutter/material.dart';
import '../core/app_config.dart';
import 'metro_tile_card.dart';

class MetroWhatsAppTile extends StatelessWidget {
  final VoidCallback onTap;

  const MetroWhatsAppTile({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: MetroTileCard(
        backgroundColor: const Color(0xFF25D366),
        leftAccentColor: const Color(0xFF065F46),
        height: 90,
        onTap: onTap,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              color: Colors.black.withValues(alpha: 0.12),
              alignment: Alignment.center,
              child: const Text('📲', style: TextStyle(fontSize: 28)),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '1-KLIK BUKA WHATSAPP',
                    style: TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.8,
                      color: Color(0xFF064E3B),
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Pesan Antar Jemput',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F172A),
                      letterSpacing: -0.2,
                    ),
                  ),
                  SizedBox(height: 1),
                  Text(
                    'Admin: ${AppConfig.primaryWhatsAppNumber}',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF065F46),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              color: Colors.black,
              child: const Text(
                'KIRIM WA →',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
