# Nomina - AI中文起名应用

## 项目介绍

Nomina是一款基于Flutter开发的AI中文起名应用，利用Gemini AI模型生成具有文化内涵的中文名字。应用支持根据星座特征和用户偏好生成个性化的中文名字，并提供名字的拼音、五行属性和含义解析。

## 功能特点

- 基于星座特征生成中文名字
- 提供名字的拼音和五行属性分析
- 详细的名字含义解析
- 名字分享功能
- 支持重新生成名字

## 技术栈

- Flutter框架
- Gemini AI API
- HTTP请求处理
- 环境变量配置
- Vercel部署

## 安装步骤

### 前提条件

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Gemini API密钥

### 安装流程

1. 克隆仓库
```bash
git clone https://github.com/yourusername/nomina.git
cd nomina
```

2. 安装依赖
```bash
flutter pub get
```

3. 配置环境变量
   - 在项目根目录创建`.env`文件
   - 添加Gemini API密钥：`GEMINI_API_KEY=your_api_key_here`

4. 运行应用
```bash
flutter run
```

## 使用方法

1. 启动应用后，在主页面输入您的星座和名字偏好
2. 点击「生成名字」按钮
3. 在结果页面查看生成的中文名字及其详细信息
4. 可以选择分享名字或重新生成

## Vercel部署指南

### 准备工作

1. 创建Vercel账户并安装Vercel CLI
2. 在Vercel平台创建新项目

### 配置环境变量

在Vercel项目设置中添加以下环境变量：
- `GEMINI_API_KEY`: 您的Gemini API密钥

### 部署步骤

1. 确保项目根目录包含正确配置的`vercel.json`文件
2. 使用GitHub Actions自动部署：
   - 确保GitHub仓库中设置了以下secrets:
     - `VERCEL_TOKEN`
     - `VERCEL_ORG_ID`
     - `VERCEL_PROJECT_ID`

3. 手动部署（可选）：
```bash
flutter build web --release
vercel --prod
```

### 部署注意事项

- 确保`.env`文件已添加到`.gitignore`中，不要将API密钥提交到版本控制系统
- 在Vercel平台上配置环境变量，而不是依赖于部署的`.env`文件
- 检查`vercel.json`配置是否正确，特别是构建输出目录和路由配置

## 常见问题

### API密钥相关

**问题**: 应用无法生成名字，提示API密钥错误
**解决方案**: 检查环境变量配置，确保Gemini API密钥正确设置

### 部署相关

**问题**: Vercel部署后应用无法正常工作
**解决方案**: 
- 检查Vercel环境变量是否正确设置
- 确认`vercel.json`配置是否正确
- 查看Vercel部署日志以获取详细错误信息

## 贡献指南

欢迎提交Pull Request或Issue来改进这个项目。

## 许可证

[MIT License](LICENSE)
