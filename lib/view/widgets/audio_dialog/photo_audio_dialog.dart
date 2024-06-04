import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';

class PhotoAudioDialog extends StatelessWidget {
  const PhotoAudioDialog({
    super.key,
    required this.metd,
  });

  final Future<Metadata> metd;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: metd,
      builder: (context, snapshot) => Container(
        height: 60,
        width: 60,
        margin: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(5),
        ),
        foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: snapshot.hasData
              ? snapshot.data?.albumArt != null
                  ? DecorationImage(
                      image: MemoryImage(snapshot.data!.albumArt!),
                      fit: BoxFit.cover,
                    )
                  : null
              : null,
        ),
        child: const Icon(
          Icons.audiotrack_rounded,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}
