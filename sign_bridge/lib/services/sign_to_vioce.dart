import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenWebsiteCard extends StatelessWidget {
  final String url;

  OpenWebsiteCard({required this.url});

  Future<void> _launchURL() async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _launchURL, // Open site when tapped
      child: Card(
        color: Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Click to Open Website",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(height: 5),
              Text(url, style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      ),
    );
  }
}
