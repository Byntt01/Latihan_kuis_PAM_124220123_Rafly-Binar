import 'package:flutter/material.dart';
import 'package:latihanresponsi/api_data_source.dart';
import 'package:latihanresponsi/reports_detail.dart';
import 'package:latihanresponsi/reports_models.dart';

class ReportsList extends StatefulWidget {
  const ReportsList({Key? key}) : super(key: key);

  @override
  State<ReportsList> createState() => _ReportsList();
}

class _ReportsList extends State<ReportsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "REPORTS LIST",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.purple[50],
        centerTitle: true,
        elevation: 4,
      ),
      body: _buildListReportsBody(),
    );
  }

  Widget _buildListReportsBody() {
    return Container(
      child: FutureBuilder(
          future: ApiDataSource.instance.loadReports(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return _buildErrorSection();
            }
            if (snapshot.hasData) {
              Reports reports = Reports.fromJson(snapshot.data);
              return _buildSuccessSection(reports);
            }
            return _buildLoadingSection();
          }),
    );
  }

  Widget _buildErrorSection() {
    return Center(
      child: Text(
        "Error loading reports",
        style: TextStyle(fontSize: 18, color: Colors.red),
      ),
    );
  }

  Widget _buildSuccessSection(Reports data) {
    return ListView.builder(
      itemCount: data.results!.length,
      itemBuilder: (BuildContext context, int index) {
        return _BuildItemReports(data.results![index]);
      },
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _BuildItemReports(Results reports) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReportsDetail(report: reports),
        ),
      ),
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
                reports.imageUrl!,
                width: 120,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),

            // Kolom dengan informasi laporan
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul laporan
                  Text(
                    reports.title!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),

                  // Ringkasan atau bagian kecil dari laporan
                  Text(
                    reports.summary ?? 'No summary available',
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
