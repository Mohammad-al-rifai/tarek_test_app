import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tarek_test_app/src/presentations/component/button.dart';

import '../../core/utils/functions.dart';

class ImagePickerType extends StatefulWidget {
  const ImagePickerType({
    super.key,
    required this.getFile,
    this.widget,
    required this.errorText,
    this.margin,
  });

  final EdgeInsetsGeometry? margin;
  final Function(File? file) getFile;

  final Widget? widget;
  final String errorText;

  @override
  State<ImagePickerType> createState() => _ImagePickerTypeState();
}

class _ImagePickerTypeState extends State<ImagePickerType> {
  final ImagePicker picker = ImagePicker();
  File? image;

  Future pickCamera() async {
    final myImage = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50, // Adjust as needed
      maxWidth: 800, // Adjust as needed
    );
    if (myImage != null) {
      setState(() {
        image = File(myImage.path);
        widget.getFile(image);
      });
    }
  }

  Future pickGallery() async {
    final myImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (myImage != null) {
      setState(() {
        image = File(myImage.path);
        widget.getFile(image);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          image == null
              ? widget.widget != null
                  ? InkWell(
                      onTap: () => handlePickerPress(),
                      child: widget.widget,
                    )
                  : InkWell(
                      onTap: () => handlePickerPress(),
                      child: Container(
                        margin:
                            widget.margin ?? const EdgeInsetsDirectional.all(8),
                        height: 260,
                        width: double.infinity,
                        decoration: getDeco(),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                CupertinoIcons.camera,
                                size: 40,
                                color: Colors.deepPurple,
                              ),
                              image == null
                                  ? Text(
                                      widget.errorText,
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    )
              : const SizedBox(),
          const SizedBox(height: 12),
          if (image != null)
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Container(
                  margin: widget.margin ?? const EdgeInsetsDirectional.all(8),
                  width: double.infinity,
                  height: 260,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: getDeco(),
                  child: Image.file(
                    image!,
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.all(12),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        image = null;
                      });
                    },
                    icon: const Icon(
                      CupertinoIcons.delete,
                      color: Colors.red,
                      size: 25,
                    ),
                  ),
                )
              ],
            )
          else
            const SizedBox(),
        ],
      ),
    );
  }

  handlePickerPress() => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Image Source Selection',
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 18,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    pickCamera();
                    popScreen(context);
                  },
                  child: Container(
                    decoration: getDeco(),
                    padding: const EdgeInsetsDirectional.all(
                      8,
                    ),
                    margin: const EdgeInsetsDirectional.all(
                      8,
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Icon(
                            CupertinoIcons.camera,
                            size: 25,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'From Camera',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    pickGallery();
                    popScreen(context);
                  },
                  child: Container(
                    decoration: getDeco(),
                    padding: const EdgeInsetsDirectional.all(
                      8,
                    ),
                    margin: const EdgeInsetsDirectional.all(
                      8,
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Icon(
                            CupertinoIcons.device_phone_portrait,
                            size: 25,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'From Gallery',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              DefaultButton(
                text: 'Cancel',
                function: () {
                  popScreen(context);
                },
              ),
            ],
          );
        },
      );
}
