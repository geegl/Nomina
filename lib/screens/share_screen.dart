import 'package:flutter/material.dart';

class ShareScreen extends StatelessWidget {
  const ShareScreen({super.key});

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
          
          // 主内容
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  
                  // 标题
                  const Text(
                    '分享你的专属中文名',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  // 分享卡片预览
                  Container(
                    width: 320,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFFFF8E1), Color(0xFFFFFAF0)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // 背景星座图案
                        Positioned.fill(
                          child: Opacity(
                            opacity: 0.05,
                            child: Image.network(
                              'https://images.unsplash.com/photo-1534447677768-be436bb09401?ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        
                        // 卡片内容
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              const Text(
                                '雨晴',
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF333333),
                                ),
                              ),
                              
                              const SizedBox(height: 5),
                              
                              const Text(
                                'Yǔ Qíng',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF666666),
                                ),
                              ),
                              
                              const SizedBox(height: 15),
                              
                              // 星座匹配度
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Color(0xFFE6C3A5),
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    '狮子座匹配度 92%',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF666666),
                                    ),
                                  ),
                                ],
                              ),
                              
                              const SizedBox(height: 15),
                              
                              const Text(
                                '「雨晴」寓意着经历风雨后的晴朗，象征着乐观向上的生活态度。',
                                textAlign: TextAlign.center,
                                style: TextStyle(
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
                  
                  // 分享文案
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '分享文案',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          '🔥 这是我的AI中文名！叫雨晴 (Yǔ Qíng)，寓意经历风雨后的晴朗，与我的狮子座超级匹配！你也来试试？ #Nomina #AI起名 #中文名',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // 社交分享按钮
                  Row(
                    children: [
                      Expanded(
                        child: _buildSocialButton(
                          icon: Icons.tiktok,
                          label: 'TikTok',
                          color: Colors.black,
                          onPressed: () {
                            // TikTok分享逻辑
                          },
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
                          onPressed: () {
                            // Instagram分享逻辑
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildSocialButton(
                          icon: Icons.chat,
                          label: 'Twitter',
                          color: const Color(0xFF1DA1F2),
                          onPressed: () {
                            // Twitter分享逻辑
                          },
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
                            // 保存图片逻辑
                          },
                          icon: const Icon(Icons.download),
                          label: const Text('保存图片'),
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
                          label: const Text('返回'),
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
    Color? color,
    Gradient? gradient,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 0,
      ).copyWith(
        backgroundColor: gradient != null
            ? MaterialStateProperty.all(null)
            : null,
      ),
      clipBehavior: Clip.antiAlias,
    );
  }
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