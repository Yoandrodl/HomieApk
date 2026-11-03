import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class HomieHeroBanner extends StatelessWidget {
  final String activeDuration;
  final String? activePromoTitle;
  final String? activePromoCode;
  final VoidCallback? onPromoTap;
  final VoidCallback? onBannerTap;

  const HomieHeroBanner({
    super.key,
    required this.activeDuration,
    this.activePromoTitle,
    this.activePromoCode,
    this.onPromoTap,
    this.onBannerTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 10, 14, 6),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0369A1), Color(0xFF0284C7), Color(0xFF0F172A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0284C7).withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background ambient circles/bubbles
          Positioned(
            top: -20,
            right: 40,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 120,
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.cyan.withValues(alpha: 0.15),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Left Column: Logo + Title + Active Duration
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Cute Cat Ears Logo
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Cat ears line
                              Row(
                                children: [
                                  CustomPaint(
                                    size: const Size(22, 10),
                                    painter: _CatEarsPainter(),
                                  ),
                                ],
                              ),
                              const Text(
                                'homie',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: -0.5,
                                  height: 0.95,
                                ),
                              ),
                              const Text(
                                'laundry',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: -0.5,
                                  height: 0.95,
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'SAMARINDA',
                                style: TextStyle(
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFFBAE6FD),
                                  letterSpacing: 2.2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Main Heading
                      const Text(
                        'Cuci Kiloan &',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: -0.2,
                        ),
                      ),
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Color(0xFF38BDF8), Color(0xFFE0F2FE)],
                        ).createShader(bounds),
                        child: const Text(
                          'Express',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: -0.5,
                            height: 1.05,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Active Duration Pill
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.35),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.cyan.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('⚡', style: TextStyle(fontSize: 13)),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                'Durasi aktif:\n$activeDuration',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  height: 1.15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Promo live badge if available
                      if (activePromoTitle != null && activePromoTitle!.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: onPromoTap,
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.accentAmber.withValues(alpha: 0.25),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.accentAmber, width: 0.8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('🎁', style: TextStyle(fontSize: 11)),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    'Promo: $activePromoCode',
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFFFDE68A),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Right Column: 3D Mascot Cat Image
                Expanded(
                  flex: 5,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        height: 190,
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/images/cat_mascot.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            // High quality vector fallback while image generates
                            return Container(
                              width: 130,
                              height: 160,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('🐱', style: TextStyle(fontSize: 54)),
                                  SizedBox(height: 4),
                                  Text(
                                    '🧺 Homie Cat',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Bersih & Rapi',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Color(0xFFBAE6FD),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      // Chevron Circle Button at bottom right
                      InkWell(
                        onTap: onBannerTap,
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.25),
                          ),
                          child: const Icon(
                            Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CatEarsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final path = Path();
    // Left ear
    path.moveTo(2, size.height);
    path.lineTo(6, 2);
    path.lineTo(10, size.height);
    // Right ear
    path.moveTo(13, size.height);
    path.lineTo(17, 2);
    path.lineTo(21, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
