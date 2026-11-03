import 'dart:async';
import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../models/promo_banner.dart';
import 'metro_tile_card.dart';

class MetroPromoTile extends StatefulWidget {
  final List<PromoBanner> promos;
  final Function(PromoBanner promo) onPromoSelected;

  const MetroPromoTile({
    super.key,
    required this.promos,
    required this.onPromoSelected,
  });

  @override
  State<MetroPromoTile> createState() => _MetroPromoTileState();
}

class _MetroPromoTileState extends State<MetroPromoTile> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  Timer? _autoFlipTimer;
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOutCubic),
    );

    _startAutoFlip();
  }

  void _startAutoFlip() {
    _autoFlipTimer?.cancel();
    _autoFlipTimer = Timer.periodic(const Duration(seconds: 6), (timer) {
      if (!mounted || widget.promos.length <= 1) return;
      _flipToNext();
    });
  }

  void _flipToNext() {
    _flipController.forward().then((_) {
      if (!mounted) return;
      setState(() {
        _currentIndex = (_currentIndex + 1) % widget.promos.length;
      });
      _flipController.reset();
    });
  }

  void _handleTap() {
    if (widget.promos.isEmpty) return;
    final promo = widget.promos[_currentIndex];
    widget.onPromoSelected(promo);
    _flipToNext();
  }

  @override
  void dispose() {
    _autoFlipTimer?.cancel();
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.promos.isEmpty) return const SizedBox.shrink();

    final promo = widget.promos[_currentIndex];

    final isEven = _currentIndex % 2 == 0;
    final tileColor = isEven ? const Color(0xFF0078D7) : const Color(0xFF107C10);
    final accentColor = isEven ? AppColors.lumiaCyan : const Color(0xFF6EE7B7);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AnimatedBuilder(
        animation: _flipAnimation,
        builder: (context, child) {
          // Subtle flip rotation effect
          final angle = _flipAnimation.value * 3.14159;
          final isUnder = _flipAnimation.value > 0.5;

          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(angle),
            alignment: Alignment.center,
            child: isUnder
                ? Transform(
                    transform: Matrix4.identity()..rotateX(3.14159),
                    alignment: Alignment.center,
                    child: child,
                  )
                : child,
          );
        },
        child: MetroTileCard(
          backgroundColor: tileColor,
          leftAccentColor: accentColor,
          height: 120,
          onTap: _handleTap,
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    color: AppColors.accentAmber,
                    child: Text(
                      promo.badge.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                  const Row(
                    children: [
                      Text(
                        'tap untuk klaim',
                        style: TextStyle(
                          fontSize: 10.5,
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 3),
                      Icon(Icons.refresh_rounded, size: 12, color: Colors.white70),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    promo.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    promo.description,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Colors.white.withValues(alpha: 0.88),
                      height: 1.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    color: Colors.black.withValues(alpha: 0.35),
                    child: Text(
                      'KODE: ${promo.promoCode}',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'monospace',
                        color: Colors.white,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                  const Text(
                    'Klaim Promo →',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
