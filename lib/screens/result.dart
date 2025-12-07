import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lovexl/logic.dart';
import 'package:lottie/lottie.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
class ResultPage extends StatefulWidget {
  final String maleName;
  final String femaleName;

  const ResultPage({
    super.key,
    required this.maleName,
    required this.femaleName,
  });

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _valueAnim;
  late Animation<double> _fillAnim;
  late Animation<double> _scaleAnim;

  late int percentage;
  late String message;

    Future<void> _incrementCalculationCounter() async {
    try {
      await _statsDoc.update({
        'totalCalculations': FieldValue.increment(1),
      });
    } catch (e) {
      // If the doc doesn't exist yet, create it with 1
      await _statsDoc.set(
        {'totalCalculations': 1},
        SetOptions(merge: true),
      );
    }
  }


  final DocumentReference _statsDoc =
      FirebaseFirestore.instance.collection('stats').doc('global');
  @override
  void initState() {
    super.initState();

    percentage = calculateLovePercentage(widget.maleName, widget.femaleName);
    message = getLoveMessage(percentage);

    _incrementCalculationCounter();

    FirebaseAnalytics.instance.logEvent(
    name: "love_calculated",
    parameters: {
      "male_name": widget.maleName,
      "female_name": widget.femaleName,
      "result_percentage": percentage,
    },
  );

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _valueAnim = Tween<double>(begin: 0, end: percentage.toDouble()).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.85, curve: Curves.easeOut),
      ),
    );

    final targetFill = (percentage / 100).clamp(0.0, 1.0);
    _fillAnim = Tween<double>(begin: 0.0, end: targetFill).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.85, curve: Curves.easeOut),
      ),
    );

    _scaleAnim = Tween<double>(begin: 1.0, end: 1.06).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.85, 1.0, curve: Curves.elasticOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _tryAgain() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.black87),
        //   onPressed: () => Navigator.pop(context),
        // ),
        title: const Text(
          'Result',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // breakpoints
          bool isTablet = constraints.maxWidth > 600;

          double heartSize = isTablet
              ? constraints.maxWidth * 0.25
              : constraints.maxWidth * 0.45;

          double titleFont = isTablet ? 28 : 22;
          double percentFont = isTablet ? 36 : 28;
          double messageFont = isTablet ? 22 : 18;

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFF9B6CA),
                  Color(0xFFFDE4CD),
                ],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: isTablet ? 40 : 10,
                  left: 0,
                  right: 0,
                  child: IgnorePointer(
                    child: Lottie.asset(
                      "assets/animations/res_heart_ani.json",
                      height: isTablet ? 600 : 400,
                      repeat: true,
                    ),
                  ),
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                      child: Container(
                        width: isTablet
                            ? constraints.maxWidth * 0.6
                            : constraints.maxWidth * 0.88,
                        padding: EdgeInsets.all(isTablet ? 40 : 28),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha:0.2),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.white30, width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${widget.maleName} ❤️ ${widget.femaleName}",
                              style: TextStyle(
                                fontSize: titleFont,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            AnimatedBuilder(
                              animation: _controller,
                              builder: (context, _) {
                                final int displayPercent =
                                    _valueAnim.value.toInt();
                                return Transform.scale(
                                  scale: _scaleAnim.value,
                                  child: SizedBox(
                                    width: heartSize,
                                    height: heartSize,
                                    child: HeartProgress(
                                      fill: _fillAnim.value,
                                      percent: displayPercent,
                                      fontSize: percentFont,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                            Text(
                              message,
                              style: TextStyle(
                                fontSize: messageFont,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ), //here

                            StreamBuilder<DocumentSnapshot>(
                              stream: _statsDoc.snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData ||
                                    !snapshot.data!.exists) {
                                  return const SizedBox.shrink();
                                }

                                final data = snapshot.data!.data()
                                    as Map<String, dynamic>;
                                final int total =
                                    (data['totalCalculations'] ?? 0) as int;

                                return Text(
                                  "Calculated by $total people so far",
                                  style: TextStyle(
                                    fontSize: isTablet ? 16 : 14,
                                    color: Colors.black54,
                                  ),
                                  textAlign: TextAlign.center,
                                );
                              },
                            ),


                            const SizedBox(height: 22), //end
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: _tryAgain,
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      color: Color(0xFFE75480)),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: isTablet ? 18 : 12),
                                ),
                                child: Text(
                                  'Try Again',
                                  style: TextStyle(
                                    color: const Color(0xFFE75480),
                                    fontWeight: FontWeight.w600,
                                    fontSize: isTablet ? 20 : 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class HeartProgress extends StatelessWidget {
  final double fill; // 0.0 - 1.0
  final int percent; // integer percent shown in center
  final double fontSize;

  const HeartProgress({
    super.key,
    required this.fill,
    required this.percent,
    required this.fontSize,
  });

 @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        return LiquidCustomProgressIndicator(
          value: fill,
          backgroundColor: Colors.pink.shade50,
          valueColor: AlwaysStoppedAnimation(
            const Color(0xFFE75480).withValues(alpha: 0.85),
          ),
          direction: Axis.vertical,
          shapePath: _heartPath(size),
          center: Center(
            child: Text(
              "$percent%",
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: const [
                  Shadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Path _heartPath(Size size) {
    final w = size.width;
    final h = size.height;
    final Path path = Path();
    path.moveTo(w * 0.5, h * 0.92);
    path.cubicTo(w * -0.16, h * 0.6, w * 0.1, h * 0.05, w * 0.5, h * 0.28);
    path.cubicTo(w * 0.9, h * 0.05, w * 1.15, h * 0.6, w * 0.5, h * 0.92);
    path.close();
    return path;
  }
}
