import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latihanresponsi/news_models.dart';

class NewsDetail extends StatelessWidget {
  final Results news;
  const NewsDetail({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "NEWS DETAIL",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purple[50],
        centerTitle: true,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  news.imageUrl ?? '',
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),

              // Judul berita
              Text(
                news.title ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple[900],
                ),
              ),
              SizedBox(height: 20),

              // Ringkasan / Deskripsi berita
              Text(
                news.summary ?? 'No summary available.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 30),

              // Tindakan tombol 'See More'
              Align(
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _launchURL(news.url ?? '');
                  },
                  icon: Icon(Icons.open_in_browser),
                  label: Text("See More"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[200],
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membuka URL
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
