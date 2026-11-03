import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class MetroHeader extends StatelessWidget {
  final VoidCallback onRefresh;
  final bool isLoading;

  const MetroHeader({
    super.key,
    required this.onRefresh,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'SAMARINDA • ANTAR JEMPUT',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                  color: AppColors.lumiaCyan,
                ),
              ),
              IconButton(
                icon: isLoading
                    ? const SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.lumiaCyan,
                        ),
                      )
                    : const Icon(
                        Icons.sync_rounded,
                        size: 18,
                        color: AppColors.textMuted,
                      ),
                onPressed: isLoading ? null : onRefresh,
                tooltip: 'Sinkronisasi Promo Google Sheets',
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 2),
          const Text.rich(
            TextSpan(
              text: 'homie ',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w300,
                color: AppColors.textWhite,
                letterSpacing: -0.5,
                height: 1.1,
              ),
              children: [
                TextSpan(
                  text: 'laundry',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: AppColors.lumiaCyan,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF064E3B),
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(color: const Color(0xFF059669), width: 0.8),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.circle, size: 7, color: Color(0xFF34D399)),
                    SizedBox(width: 5),
                    Text(
                      'Buka 08:00 - 20:00 WITA',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF6EE7B7),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Free radius s/d 3 km',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textMuted,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
