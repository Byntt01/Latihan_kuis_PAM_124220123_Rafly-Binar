import 'package:flutter/material.dart';
import 'package:latihanresponsi/api_data_source.dart';
import 'package:latihanresponsi/news_detail.dart';
import 'package:latihanresponsi/news_models.dart';

class NewsList extends StatefulWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  State<NewsList> createState() => _NewsList();
}

class _NewsList extends State<NewsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "NEWS LIST",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.purple[50],
        centerTitle: true,
        elevation: 4,
      ),
      body: _buildListNewsBody(),
    );
  }

  Widget _buildListNewsBody() {
    return Container(
      child: FutureBuilder(
          future: ApiDataSource.instance.loadNews(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return _buildErrorSection();
            }
            if (snapshot.hasData) {
              News news = News.fromJson(snapshot.data);
              return _buildSuccessSection(news);
            }
            return _buildLoadingSection();
          }),
    );
  }

  Widget _buildErrorSection() {
    return Center(
      child: Text(
        "Error loading news",
        style: TextStyle(fontSize: 18, color: Colors.red),
      ),
    );
  }

  Widget _buildSuccessSection(News data) {
    return ListView.builder(
      itemCount: data.results!.length,
      itemBuilder: (BuildContext context, int index) {
        return _BuildItemNews(data.results![index]);
      },
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _BuildItemNews(Results news) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetail(news: news),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Gambar dengan border-radius dan shadow
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                news.imageUrl!,
                width: 120,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),

            // Kolom dengan informasi berita
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul berita
                  Text(
                    news.title!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),

                  // Ringkasan atau bagian kecil dari berita
                  Text(
                    news.summary ?? 'No summary available',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
