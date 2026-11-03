import 'package:flutter/material.dart';
import 'metro_tile_card.dart';

class HomieSpecialServices extends StatelessWidget {
  final VoidCallback onAmbalTap;
  final VoidCallback onSepatuTap;

  const HomieSpecialServices({
    super.key,
    required this.onAmbalTap,
    required this.onSepatuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          // 1. Ambal & Sajadah (Orange Tile)
          Expanded(
            child: MetroTileCard(
              backgroundColor: const Color(0xFFD97706),
              leftAccentColor: const Color(0xFFFDE68A),
              height: 145,
              onTap: onAmbalTap,
              padding: const EdgeInsets.all(10),
              child: Stack(
                children: [
                  // Content Column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Top Row: Mosque Icon & Samarinda Badge
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.mosque_outlined, color: Colors.white, size: 22),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.35),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'SAMARINDA',
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Text
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ambal &\nSajadah',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: -0.3,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'Sedot debu, anti\ntungau & suci',
                            style: TextStyle(
                              fontSize: 9.5,
                              color: Colors.white.withValues(alpha: 0.9),
                              height: 1.15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Image Rolled Carpet on the right
                  Positioned(
                    right: -6,
                    bottom: 8,
                    child: SizedBox(
                      width: 65,
                      height: 65,
                      child: Image.asset(
                        'assets/images/rolled_carpet.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Container(
                          alignment: Alignment.center,
                          child: const Text('🕌', style: TextStyle(fontSize: 34)),
                        ),
                      ),
                    ),
                  ),

                  // Circle Chevron Button at bottom right
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(
                        Icons.chevron_right_rounded,
                        size: 14,
                        color: Color(0xFFD97706),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 8),

          // 2. Sepatu & Tas (Purple Treatment Tile)
          Expanded(
            child: MetroTileCard(
              backgroundColor: const Color(0xFF6D28D9),
              leftAccentColor: const Color(0xFFC4B5FD),
              height: 145,
              onTap: onSepatuTap,
              padding: const EdgeInsets.all(10),
              child: Stack(
                children: [
                  // Content Column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Top Row: Treatment Badge
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.35),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'TREATMENT',
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Text
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sepatu & Tas',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: -0.3,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'Deep clean &\nunyellowing sol',
                            style: TextStyle(
                              fontSize: 9.5,
                              color: Colors.white.withValues(alpha: 0.9),
                              height: 1.15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Image Sneakers on right/bottom
                  Positioned(
                    right: -8,
                    bottom: 8,
                    child: SizedBox(
                      width: 75,
                      height: 75,
                      child: Image.asset(
                        'assets/images/sneakers_clean.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Container(
                          alignment: Alignment.center,
                          child: const Text('👟', style: TextStyle(fontSize: 34)),
                        ),
                      ),
                    ),
                  ),

                  // Circle Chevron Button at bottom right
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(
                        Icons.chevron_right_rounded,
                        size: 14,
                        color: Color(0xFF6D28D9),
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
