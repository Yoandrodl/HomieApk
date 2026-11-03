import 'package:flutter/material.dart';
import 'metro_tile_card.dart';

class MetroServicesGrid extends StatelessWidget {
  final Function(String serviceName) onSelectService;

  const MetroServicesGrid({
    super.key,
    required this.onSelectService,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // 1. Ambal & Sajadah (Square Tile)
          Expanded(
            child: MetroTileCard(
              backgroundColor: const Color(0xFFD97706),
              leftAccentColor: const Color(0xFFFDE68A),
              height: 145,
              onTap: () => onSelectService('Cuci Ambal & Sajadah'),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('🕌', style: TextStyle(fontSize: 24)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        color: Colors.black38,
                        child: const Text(
                          'SAMARINDA',
                          style: TextStyle(
                            fontSize: 8.5,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ambal & Sajadah',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -0.2,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Sedot debu, anti-tungau & suci',
                        style: TextStyle(
                          fontSize: 10.5,
                          color: Color(0xFFFEF3C7),
                          height: 1.15,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    color: const Color(0xFFFEF3C7),
                    child: const Text(
                      'Pilih Ambal →',
                      style: TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 10),

          // 2. Sepatu & Tas Treatment (Square Tile)
          Expanded(
            child: MetroTileCard(
              backgroundColor: const Color(0xFF4F46E5),
              leftAccentColor: const Color(0xFFA5B4FC),
              height: 145,
              onTap: () => onSelectService('Cuci Sepatu & Tas Treatment'),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('👟', style: TextStyle(fontSize: 24)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        color: Colors.black38,
                        child: const Text(
                          'TREATMENT',
                          style: TextStyle(
                            fontSize: 8.5,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sepatu & Tas',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -0.2,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Deep clean & unyellowing sol',
                        style: TextStyle(
                          fontSize: 10.5,
                          color: Color(0xFFE0E7FF),
                          height: 1.15,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    color: const Color(0xFF312E81),
                    child: const Text(
                      'Pilih Sepatu →',
                      style: TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
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
