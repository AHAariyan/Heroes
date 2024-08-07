import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

void main() {
  runApp(const ProviderScope(child: Heroes()));
}

// Define a StateProvider to manage the selected index state
final selectedIndexProvider = StateProvider<int>((ref) => 0);

class Heroes extends StatelessWidget {
  const Heroes({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFFD32F2F), // Red
          onPrimary: Color(0xFFFFFFFF), // White
          primaryContainer: Color(0xFFFFCDD2), // Light Red
          onPrimaryContainer: Color(0xFFB71C1C), // Dark Red
          secondary: Color(0xFF388E3C), // Green
          onSecondary: Color(0xFFFFFFFF), // White
          secondaryContainer: Color(0xFFC8E6C9), // Light Green
          onSecondaryContainer: Color(0xFF1B5E20), // Dark Green
          tertiary: Color(0xFFBDBDBD), // Light Gray
          onTertiary: Color(0xFF424242), // Dark Gray
          error: Color(0xFFD32F2F), // Red
          onError: Color(0xFFFFFFFF), // White
          surface: Color(0xFFFFFFFF), // White
          onSurface: Color(0xFF424242), // Dark Gray
          outline: Color(0xFF9E9E9E), // Gray
          shadow: Color(0xFF000000), // Black
          surfaceTint: Color(0xFFD32F2F), // Red
        ),
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.bold, color: Color(0xFF424242)), // Dark Gray
          displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: Color(0xFF424242)), // Dark Gray
          displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color(0xFF424242)), // Dark Gray
          headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF424242)), // Dark Gray
          headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF424242)), // Dark Gray
          headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF424242)), // Dark Gray
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Color(0xFF424242)), // Dark Gray
          titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF424242)), // Dark Gray
          titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF424242)), // Dark Gray
          bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Color(0xFF424242)), // Dark Gray
          bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Color(0xFF424242)), // Dark Gray
          bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Color(0xFF424242)), // Dark Gray
          labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF424242)), // Dark Gray
          labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF424242)), // Dark Gray
          labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF424242)), // Dark Gray
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFD32F2F), // Red
          foregroundColor: Color(0xFFFFFFFF), // White
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFF388E3C), // Green
          textTheme: ButtonTextTheme.primary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: const Color(0xFFFFFFFF), backgroundColor: const Color(0xFF388E3C), // White
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFD32F2F), // Red
          foregroundColor: Color(0xFFFFFFFF), // White
        ),
      ),
      home: const HeroesHome(),
    );
  }
}

class HeroesHome extends StatelessWidget {
  const HeroesHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GalaxyBackground(),
    );
  }
}

class GalaxyBackground extends ConsumerStatefulWidget {
  const GalaxyBackground({super.key});

  @override
  _GalaxyBackgroundState createState() => _GalaxyBackgroundState();
}


class _GalaxyBackgroundState extends ConsumerState<GalaxyBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Offset> _starPositions;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 45),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    // Initialize star positions in the build method where MediaQuery is available
    _starPositions = List.generate(200, (index) {
      final random = Random();
      return Offset(random.nextDouble() * MediaQuery.of(context).size.width,
          random.nextDouble() * MediaQuery.of(context).size.height);
    });

    return Stack(
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: GalaxyPainter(
                starPositions: _starPositions,
                animationValue: _controller.value,
              ),
              child: const SizedBox.expand(),
            );
          },
        ),
        Column(
          children: [
            Expanded(
              child: Center(
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      constraints: BoxConstraints(
                        maxHeight: 450, // Max height
                      ),
                      child: Image.asset(
                        'assets/top_img.jpg',
                        fit: BoxFit.fill,
                        width: double.infinity, // Match parent width
                        height: double.infinity, // Match parent height
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), // Add spacing below the card if needed
            // Display content based on selected index
            Text(
              'Selected Index: $selectedIndex',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            // Add more widgets as needed
          ],
        ),
        Positioned(
          right: 0,
          top: MediaQuery.of(context).size.height / 2 - 75, // Adjust the value to half of the index widget's height
          child: Container(
            width: 50, // Adjust the width as needed
            height: 150, // Fixed height
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: ListView.builder(
              itemCount: 20, // Example with 20 items
              itemBuilder: (context, index) => _buildIndexItem(context, ref, index),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIndexItem(BuildContext context, WidgetRef ref, int index) {
    final selectedIndex = ref.watch(selectedIndexProvider);
    bool isSelected = index == selectedIndex;

    return GestureDetector(
      onTap: () {
        ref.read(selectedIndexProvider.notifier).state = index;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            '${index + 1}',
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class GalaxyPainter extends CustomPainter {
  final List<Offset> starPositions;
  final double animationValue;

  GalaxyPainter({required this.starPositions, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    final Rect rect = Offset.zero & size;

    // Background gradient with a blend of colors starting from bottom left
    const Gradient gradient = LinearGradient(
      colors: [
        Color(0xFF240E63), // Deep Dark Purple
        Color(0xFF3C1361), // Purple
        Color(0xFF5A189A), // Dark Magenta
        Color(0xFF7B2CBF), // Magenta
        Color(0xFF9C27B0), // Purple
      ],
      stops: [0.0, 0.15, 0.3, 0.45, 0.75],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
    );

    paint.shader = gradient.createShader(rect);
    canvas.drawRect(rect, paint);

    // Adding stars
    paint.shader = null; // Ensure the gradient is not applied to stars
    paint.color = Colors.white;

    for (int i = 0; i < starPositions.length; i++) {
      double x = starPositions[i].dx;
      double y = (starPositions[i].dy - (animationValue * size.height)) % size.height;
      if (y < 0) y += size.height; // wrap around the top to bottom
      double radius = 0.5 + (i % 3) * 0.5; // Vary star size for better visibility
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(GalaxyPainter oldDelegate) => true;
}



// class GalaxyPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint();
//     final Rect rect = Offset.zero & size;
//
//     // Background gradient with a blend of colors starting from bottom left
//     const Gradient gradient = LinearGradient(
//       colors: [
//         Color(0xFF240E63), // Deep Dark Purple
//         Color(0xFF3C1361), // Purple
//         Color(0xFF5A189A), // Dark Magenta
//         Color(0xFF7B2CBF), // Magenta
//         Color(0xFF9C27B0), // Purple
//       ],
//       stops: [0.0, 0.15, 0.3, 0.45, 0.75],
//       begin: Alignment.bottomLeft,
//       end: Alignment.topRight,
//     );
//
//     paint.shader = gradient.createShader(rect);
//     canvas.drawRect(rect, paint);
//
//     final Random random = Random();
//     // Adding stars
//     paint.shader = null; // Ensure the gradient is not applied to stars
//     paint.color = Colors.white;
//     for (int i = 0; i < 200; i++) {
//       double x = random.nextDouble() * size.width;
//       double y = random.nextDouble() * size.height;
//       double radius = 0.5 + random.nextDouble() * 2; // Adjusted radius for better visibility
//       canvas.drawCircle(Offset(x, y), radius, paint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(GalaxyPainter oldDelegate) => false;
// }
