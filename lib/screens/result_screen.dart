import 'package:flutter/material.dart';
import 'package:nomina/screens/share_screen.dart';
import 'dart:math' as math;

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _progressAnimation;
  
  // 存储生成的名字和相关信息
  String chineseName = '';
  String pinyin = '';
  String zodiac = '';
  int matchPercentage = 0;
  String meaning = '';
  String fiveElements = '';
  String nameAnalysis = '';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );
    
    _progressAnimation = Tween<double>(begin: 0.0, end: 0.92).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );
    
    // 调用API生成名字
    _generateName();
  }

  Future<void> _generateName() async {
    final navigator = Navigator.of(context);
    final shareScreen = await navigator.push<Map<String, dynamic>>(
      MaterialPageRoute(
        builder: (context) => ShareScreen(
          chineseName: '',
          pinyin: '',
          zodiac: zodiac.isEmpty ? '狮子座' : zodiac,  // 如果没有设置星座，使用默认值
          matchPercentage: 0,
          meaning: '',
        ),
      ),
    );

    if (shareScreen != null) {
      setState(() {
        chineseName = shareScreen['name'] ?? '';
        pinyin = shareScreen['pinyin'] ?? '';
        meaning = shareScreen['meaning'] ?? '';
        fiveElements = shareScreen['five_elements'] ?? '';
        nameAnalysis = '「$chineseName」$meaning';
        _controller.forward();
      });
    }
  }



  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 背景装饰
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: Image.network(
                'https://images.unsplash.com/photo-1534447677768-be436bb09401?ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80',
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // 八卦符号装饰
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
          
          // 星星背景
          const StarBackground(),
          
          // 主内容
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  
                  // 标题
                  const Text(
                    '你的专属中文名',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // 名字卡片
                  Expanded(
                    child: Center(
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _fadeInAnimation.value,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(30),
                              decoration: const BoxDecoration(
                                color: Color(0xE6FFFFFF),  // 添加const和正确颜色值
                                borderRadius: BorderRadius.all(Radius.circular(20)),  // 使用命名构造函数
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xB3000000),  // 正确颜色格式
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // 中文名
                                  Text(
                                    chineseName,
                                    style: const TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF333333),
                                    ),
                                  ),
                                  
                                  const SizedBox(height: 8),
                                  
                                  // 拼音
                                  Text(
                                    pinyin,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF666666),
                                    ),
                                  ),
                                  
                                  const SizedBox(height: 30),
                                  
                                  // 星座匹配度
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '$zodiac匹配度',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF666666),
                                            ),
                                          ),
                                          Text(
                                            '${(_progressAnimation.value * 100).toInt()}%',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF333333),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Container(
                                        height: 8,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF0F0F0),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: FractionallySizedBox(
                                          widthFactor: _progressAnimation.value,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                colors: [Color(0xFFF5D0A9), Color(0xFFE6C3A5)],
                                              ),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  const SizedBox(height: 24),
                                  
                                  // 五行属性
                                  Column(
                                    children: [
                                      const Text(
                                        '五行属性：',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: List.generate(
                                          3,
                                          (index) => const Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 4),
                                            child: Icon(
                                              Icons.local_fire_department,
                                              color: Color(0xFFFF6B6B),
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  const SizedBox(height: 24),
                                  
                                  // 名字解析
                                  Column(
                                    children: [
                                      const Text(
                                        '名字解析',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF333333),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        nameAnalysis,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  const SizedBox(height: 30),
                                  
                                  // 操作按钮
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ShareScreen(
                                                  chineseName: chineseName,
                                                  pinyin: pinyin,
                                                  zodiac: zodiac,
                                                  matchPercentage: matchPercentage,
                                                  meaning: nameAnalysis,
                                                ),
                                              ),
                                            );
                                          },
                                          icon: const Icon(Icons.share),
                                          label: const Text('分享'),
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
                                            // 重新生成逻辑
                                            setState(() {
                                              // 在这里实现重新生成的逻辑
                                              _controller.reset();
                                              _controller.forward();
                                            });
                                          },
                                          icon: const Icon(Icons.refresh),
                                          label: const Text('重新生成'),
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
                          );
                        },
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

class StarBackground extends StatelessWidget {
  const StarBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: CustomPaint(
        painter: StarPainter(),
      ),
    );
  }
}

class StarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(42); // 固定种子以保持一致性
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    
    for (int i = 0; i < 30; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 2 + 1;
      
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class TrigramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    
    // 上横线
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.2, size.height * 0.2, size.width * 0.6, size.height * 0.1),
      paint,
    );
    
    // 中横线
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.2, size.height * 0.45, size.width * 0.6, size.height * 0.1),
      paint,
    );
    
    // 下横线（分开的）
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.2, size.height * 0.7, size.width * 0.25, size.height * 0.1),
      paint,
    );
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.55, size.height * 0.7, size.width * 0.25, size.height * 0.1),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}