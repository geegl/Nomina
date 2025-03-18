import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math' as math;

class ShareScreen extends StatefulWidget {
  final String chineseName;
  final String pinyin;
  final String zodiac;
  final int matchPercentage;
  final String meaning;

  const ShareScreen({
    super.key, 
    required this.chineseName,
    required this.pinyin,
    required this.zodiac,
    required this.matchPercentage,
    required this.meaning,
  });

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  bool _isLoading = false;
  String? _generatedName;
  String? _generatedMeaning;

  // 使用Vercel API函数，不再需要直接获取API密钥

  Future<Map<String, dynamic>> generateNameWithGemini() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      final String prompt = '''
Please generate a Chinese name with the following requirements:
1. The name should reflect the characteristics of ${widget.zodiac} zodiac sign
2. Consider Chinese Five Elements theory and traditional cultural connotations
3. The name should have auspicious meaning and reflect these qualities: ${widget.meaning}
4. The name should have beautiful pronunciation and be suitable for daily use

Please return in the following JSON format:
{
  "name": "Chinese name (2-3 characters)",
  "pinyin": "Pinyin with tone marks",
  "meaning": "Name meaning explanation (within 50 characters)",
  "five_elements": "Five elements attributes"
}
''';

      // 使用Vercel API函数调用Gemini API
      final response = await http.post(
        Uri.parse('/api/gemini'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'prompt': prompt
        })
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final String generatedText = jsonResponse['candidates'][0]['content']['parts'][0]['text'];
        
        final jsonStart = generatedText.indexOf('{');
        final jsonEnd = generatedText.lastIndexOf('}') + 1;
        if (jsonStart >= 0 && jsonEnd > jsonStart) {
          final jsonStr = generatedText.substring(jsonStart, jsonEnd)
              .replaceAll(RegExp(r'\s+'), ' ')
              .trim();
          final nameData = jsonDecode(jsonStr);
          
          setState(() {
            _generatedName = nameData['name'];
            _generatedMeaning = nameData['meaning'];
            _isLoading = false;
          });
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Generated new name: ${nameData['name']}'),
              backgroundColor: const Color(0xFF4CAF50),
              behavior: SnackBarBehavior.floating,
            ),
          );
          
          return nameData;
        } else {
          throw Exception('Failed to parse JSON response');
        }
      } else {
        throw Exception('API request failed: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error generating name: $e'),
          backgroundColor: const Color(0xFFE57373),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return {
        // 请确保返回的是有效的JSON格式
        'name': 'MingZhi',
        'pinyin': 'MingZhi',
        'meaning': 'Wisdom and intelligence',
        'five_elements': 'Wood and Fire'
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayName = _generatedName ?? widget.chineseName;
    final displayMeaning = _generatedMeaning ?? widget.meaning;
    
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: Image.network(
                'https://images.unsplash.com/photo-1534447677768-be436bb09401?ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80',
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          Positioned(
            top: 50,
            left: 30,
            child: Opacity(
              opacity: 0.1,
              child: CustomPaint(
                size: const Size(60, 60),
                painter: TrigramPainter(),
              ),
            ),
          ),
          
          Positioned(
            bottom: 50,
            right: 30,
            child: Opacity(
              opacity: 0.1,
              child: CustomPaint(
                size: const Size(60, 60),
                painter: TrigramPainter(),
              ),
            ),
          ),
          
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  
                  const Text(
                    'Share Your Chinese Name',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  Container(
                    width: 320,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFFFF8E1), Color(0xFFFFFAF0)],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x1A000000),
                          blurRadius: 30,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Opacity(
                            opacity: 0.05,
                            child: Image.network(
                              'https://images.unsplash.com/photo-1534447677768-be436bb09401?ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              Text(
                                displayName,
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF333333),
                                ),
                              ),
                              
                              const SizedBox(height: 5),
                              
                              Text(
                                widget.pinyin,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF666666),
                                ),
                              ),
                              
                              const SizedBox(height: 15),
                              
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Color(0xFFE6C3A5),
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${widget.zodiac} Match ${widget.matchPercentage}%',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF666666),
                                    ),
                                  ),
                                ],
                              ),
                              
                              const SizedBox(height: 15),
                              
                              Text(
                                '"$displayName" - $displayMeaning',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                ),
                              ),
                              
                              const SizedBox(height: 20),
                              
                              const Text(
                                'Nomina ✨',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF333333),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Share Text',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '🔥 Check out my AI-generated Chinese name! It\'s $displayName ($displayMeaning). Perfect match for my ${widget.zodiac} personality! Try yours at #Nomina #AINames #ChineseNames',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildSocialButton(
                          icon: Icons.tiktok,
                          label: 'TikTok',
                          color: Colors.black,
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildSocialButton(
                          icon: Icons.camera_alt,
                          label: 'Instagram',
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFF09433),
                              Color(0xFFE6683C),
                              Color(0xFFDC2743),
                              Color(0xFFCC2366),
                              Color(0xFFBC1888),
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildSocialButton(
                          icon: Icons.chat,
                          label: 'Twitter',
                          color: const Color(0xFF1DA1F2),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 30),
                  
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ElevatedButton.icon(
                          onPressed: _isLoading ? null : generateNameWithGemini,
                          icon: _isLoading 
                              ? const SizedBox(
                                  width: 20, 
                                  height: 20, 
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Color(0xFF4A2511),
                                  )
                                )
                              : const Icon(Icons.refresh),
                          label: Text(_isLoading ? 'Generating...' : 'Generate Again'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE6C3A5),
                            foregroundColor: const Color(0xFF4A2511),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                          label: const Text('Back'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF5F5F5),
                            foregroundColor: const Color(0xFF666666),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    Color? color,
    Gradient? gradient,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: ButtonStyle(
        backgroundColor: gradient != null
            ? MaterialStateProperty.all(Colors.transparent)
            : MaterialStateProperty.all(color),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 12),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        overlayColor: gradient != null
            ? MaterialStateProperty.resolveWith(
                (states) => states.contains(MaterialState.pressed)
                    ? Colors.white.withOpacity(0.1)
                    : null,
              )
            : null,
      ),
    );
  }

  // 八卦图案绘制器
}

class TrigramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF333333)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final width = size.width;
    final height = size.height;
    final lineSpacing = height / 4;

    // 绘制三条横线
    for (var i = 1; i <= 3; i++) {
      final y = i * lineSpacing;
      canvas.drawLine(
        Offset(0, y),
        Offset(width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}