import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PdfReaderView extends StatefulWidget {
  final String title;
  final String url;

  const PdfReaderView({
    Key? key,
    required this.title,
    required this.url,
  }) : super(key: key);

  @override
  State<PdfReaderView> createState() => _PdfReaderViewState();
}

class _PdfReaderViewState extends State<PdfReaderView> {
  late WebViewController _controller;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  void _initWebView() {
    // Convertir Google Drive URL en URL d'embed
    final embedUrl = _convertToEmbedUrl(widget.url);

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _isLoading = true),
          onPageFinished: (_) => setState(() => _isLoading = false),
          onWebResourceError: (error) {
            setState(() {
              _error = 'Erreur de chargement: ${error.description}';
              _isLoading = false;
            });
          },
        ),
      );

    if (embedUrl != null) {
      _controller.loadRequest(Uri.parse(embedUrl));
    } else {
      // Fallback: utiliser Google Docs Viewer
      final docsUrl =
          'https://docs.google.com/gview?embedded=1&url=${Uri.encodeComponent(widget.url)}';
      _controller.loadRequest(Uri.parse(docsUrl));
    }
  }

  String? _convertToEmbedUrl(String url) {
    // Pattern pour extraire l'ID Google Drive
    final regExp = RegExp(r'/d/([a-zA-Z0-9_-]+)');
    final match = regExp.firstMatch(url);

    if (match != null && match.groupCount >= 1) {
      final fileId = match.group(1);
      return 'https://drive.google.com/file/d/$fileId/preview';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F1117) : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1C1F2E) : Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded,
              color: isDark ? Colors.white : const Color(0xFF0D1B2A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : const Color(0xFF0D1B2A),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => _controller.reload(),
          ),
          IconButton(
            icon: const Icon(Icons.open_in_browser_rounded),
            onPressed: () {
              // Ouvrir dans navigateur externe
              // launchUrl(Uri.parse(widget.url));
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: isDark
                ? Colors.white.withOpacity(0.1)
                : const Color(0xFFE5E7EB),
          ),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            Container(
              color: isDark ? const Color(0xFF0F1117) : Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: isDark ? Colors.white70 : const Color(0xFF6366F1),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Chargement du document...',
                      style: TextStyle(
                        color:
                            isDark ? Colors.white54 : const Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (_error != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline_rounded,
                        size: 56, color: Colors.red.shade300),
                    const SizedBox(height: 16),
                    Text(
                      _error!,
                      style: TextStyle(
                        color:
                            isDark ? Colors.white70 : const Color(0xFF444444),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _error = null;
                          _isLoading = true;
                        });
                        _controller.reload();
                      },
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Réessayer'),
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
