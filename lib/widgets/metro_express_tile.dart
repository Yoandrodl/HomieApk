import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'metro_tile_card.dart';

class MetroExpressTile extends StatelessWidget {
  final String selectedDuration;
  final Function(String duration) onDurationChanged;

  const MetroExpressTile({
    super.key,
    required this.selectedDuration,
    required this.onDurationChanged,
  });

  static const List<String> availableDurations = [
    '2 Jam',
    '3 Jam',
    '5 Jam',
    'Same Day',
    '1x24 Jam',
    'Bulanan',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: MetroTileCard(
        backgroundColor: const Color(0xFF0284C7),
        leftAccentColor: const Color(0xFF38BDF8),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 38,
                  height: 38,
                  color: Colors.white.withValues(alpha: 0.15),
                  child: const Center(
                    child: Text('🧺', style: TextStyle(fontSize: 22)),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      color: AppColors.accentAmber,
                      child: const Text(
                        'PILIH DURASI',
                        style: TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      '1 Mesin 1 Nota',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Title & Subtitle
            const Text(
              'Cuci Kiloan & Express',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 2),
            Text.rich(
              TextSpan(
                text: '⚡ Durasi aktif: ',
                style: const TextStyle(fontSize: 12, color: Colors.white70),
                children: [
                  TextSpan(
                    text: selectedDuration,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Grid Buttons for Durations (2, 3, 5 Jam, etc.)
            Container(
              padding: const EdgeInsets.only(top: 8),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.white24, width: 0.8),
                ),
              ),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: availableDurations.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                  childAspectRatio: 2.5,
                ),
                itemBuilder: (context, index) {
                  final dur = availableDurations[index];
                  final isSelected = selectedDuration.contains(dur);

                  return InkWell(
                    onTap: () {
                      final fullName = dur.contains('Jam') || dur.contains('Day') || dur.contains('Bulanan')
                          ? (dur.startsWith('Express') ? dur : 'Express $dur')
                          : dur;
                      onDurationChanged(fullName);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.18),
                      alignment: Alignment.center,
                      child: Text(
                        dur,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: isSelected ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Setrika uap licin sempurna',
                  style: TextStyle(fontSize: 11, color: Colors.white70),
                ),
                Text(
                  'Dipilih ✓',
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
    );
  }
}
