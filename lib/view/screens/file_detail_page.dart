import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../data/data source/recent_files.dart';
import '../../core/constant/app_colors.dart';

class FileDetailPage extends StatefulWidget {
  final String title;
  final String fileCount;

  const FileDetailPage(
      {super.key, required this.title, required this.fileCount});

  @override
  State<FileDetailPage> createState() => _FileDetailPageState();
}

class _FileDetailPageState extends State<FileDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: getAppBar(),
      ),
      body: getBody(),
    );
  }

  Widget getAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            LineIcons.arrowLeft,
            color: AppColors.black,
          )),
      title: Text(
        "${widget.title} (${widget.fileCount})",
        style: const TextStyle(color: AppColors.black, fontSize: 17),
      ),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          getDateSection(),
          const SizedBox(
            height: 20,
          ),
          getItemLists()
        ],
      ),
    );
  }

  Widget getDateSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          children: [
            Text(
              "Date Modified",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 2,
            ),
            Icon(
              LineIcons.arrowDown,
              size: 20,
            )
          ],
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              LineIcons.borderAll,
              color: AppColors.black.withOpacity(0.5),
            ))
      ],
    );
  }

  Widget getItemLists() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.95,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      itemCount: imageFiles.length,
      itemBuilder: (context, index) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(22),
                image: DecorationImage(
                  image: NetworkImage(imageFiles[index]['img']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              imageFiles[index]['file_name'],
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              imageFiles[index]['file_size'],
              style: TextStyle(
                fontSize: 13,
                color: AppColors.secondary.withOpacity(0.5),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
