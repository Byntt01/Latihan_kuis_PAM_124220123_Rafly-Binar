import 'package:flutter/material.dart';
import 'package:latihanresponsi/api_data_source.dart';
import 'package:latihanresponsi/blog_detail.dart';
import 'package:latihanresponsi/blog_models.dart';

class BlogList extends StatefulWidget {
  const BlogList({Key? key}) : super(key: key);

  @override
  State<BlogList> createState() => _BlogList();
}

class _BlogList extends State<BlogList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BLOG LIST", style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.purple[50],
        centerTitle: true,
        elevation: 4,
      ),
      body: _buildListBlogsBody(),
    );
  }

  Widget _buildListBlogsBody() {
    return Container(
      child: FutureBuilder(
          future: ApiDataSource.instance.loadBlogs(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return _buildErrorSection();
            }
            if (snapshot.hasData) {
              Blog blogs = Blog.fromJson(snapshot.data);
              return _buildSuccessSection(blogs);
            }
            return _buildLoadingSection();
          }),
    );
  }

  Widget _buildErrorSection() {
    return Center(
      child: Text(
        "Error loading blogs",
        style: TextStyle(fontSize: 18, color: Colors.red),
      ),
    );
  }

  Widget _buildSuccessSection(Blog data) {
    return ListView.builder(
      itemCount: data.results!.length,
      itemBuilder: (BuildContext context, int index) {
        return _BuildItemUsers(data.results![index]);
      },
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _BuildItemUsers(Results blog) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlogDetail(blog: blog),
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
                blog.imageUrl!,
                width: 120,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),

            // Kolom dengan informasi blog
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul blog
                  Text(
                    blog.title!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),

                  // Ringkasan atau bagian kecil dari blog
                  Text(
                    blog.summary ?? 'No summary available',
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
