import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:apho/constants/basic.dart';
import 'package:apho/constants/ui.dart';
import 'package:apho/views/crop_image_view.dart';
import 'package:apho/services/ui_services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import '../widgets/bottom_sheet_back_bar.dart';
import 'communications.dart';
import 'navigation/navigation.dart';

class ImageServices {
  Future<List<File>> pickImages(BuildContext context, {int limit = 10}) async {
    List<File> returnThis = [];

    await UIServices().showDatSheet(
      ImageOptionsBottomSheet(
        onCameraTap: () async {
          returnThis = await goToCamera(context, limit);

          NavigationService().pop();
        },
        onGalleryTap: () async {
          returnThis = await goToMultiPicker(context, limit);

          NavigationService().pop();
        },
      ),
      false,
      context,
      height: MediaQuery.of(context).size.height * 0.25,
    );

    return returnThis;
  }

  Future<List<File>> goToMultiPicker(
    BuildContext context,
    int limit,
  ) async {
    NavigationService().push(
      ImageWorks(),
    );

    List<File> images = [];
    List<Asset> resultList = [];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: limit,
        enableCamera: true,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: capitalizedAppName,
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      CommunicationServices().showToast(e.toString(), primaryColor);
    }

    if (resultList.isNotEmpty) {
      images.clear();

      List<File> tempFileList = [];
      final temp = await Directory.systemTemp.createTemp();
      for (int i = 0; i < resultList.length; i++) {
        final data = await resultList[i].getByteData();
        tempFileList.add(
          await File('${temp.path}/img$i').writeAsBytes(
            data.buffer.asUint8List(
              data.offsetInBytes,
              data.lengthInBytes,
            ),
          ),
        );
      }

      images = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CropImageView(
            limit: limit,
            images: tempFileList,
          ),
        ),
      );

      Navigator.of(context).pop();

      return images;
    } else {
      images.clear();
      Navigator.of(context).pop();
      return images;
    }
  }

  Future<List<File>> goToCamera(
    BuildContext context,
    int limit,
  ) async {
    NavigationService().push(
      ImageWorks(),
    );

    XFile image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (image != null) {
      File ff = File(image.path);

      List<File> images = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CropImageView(
            limit: limit,
            images: [ff],
          ),
        ),
      );

      Navigator.of(context).pop();

      return images;
    } else {
      return [];
    }
  }

  Future<List<String>> uploadImages({
    @required String path,
    @required Function onError,
    @required List images,
  }) async {
    List<String> imgUrls = [];

    if (images == null || images.isEmpty || images[0] == null) {
      return imgUrls;
    } else {
      try {
        for (var element in images) {
          if (element is File) {
            List<int> imageData = await element.readAsBytes();
            String tyme = DateTime.now().toString();
            Reference ref = FirebaseStorage.instance
                .ref()
                .child(
                  path ?? "images",
                )
                .child(
                  "$tyme.jpg",
                );
            UploadTask uploadTask = ref.putData(imageData);
            String url = await (await uploadTask).ref.getDownloadURL();
            imgUrls.add(url);
          } else {
            if (element.toString().trim().contains(
                  "assets/images",
                )) {
            } else {
              if (element is String) {
                imgUrls.add(element.toString());
              }
            }
          }
        }

        return imgUrls;
        // ignore: unused_catch_clause
      } on Exception catch (e) {
        onError();
        return [];
      }
    }
  }
}

class ImageWorks extends StatelessWidget {
  const ImageWorks({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
    );
  }
}

class ImageOptionsBottomSheet extends StatelessWidget {
  final Function onCameraTap;
  final Function onGalleryTap;
  const ImageOptionsBottomSheet({
    Key key,
    @required this.onCameraTap,
    @required this.onGalleryTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BackBar(
          icon: null,
          onPressed: null,
          text: "Select An Option",
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      onCameraTap();
                    },
                    icon: Icon(
                      Icons.camera,
                    ),
                  ),
                  Text(
                    "Camera",
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      onGalleryTap();
                    },
                    icon: Icon(
                      Icons.add_photo_alternate,
                    ),
                  ),
                  Text(
                    "Gallery",
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
