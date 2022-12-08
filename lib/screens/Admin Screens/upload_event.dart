import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coco_meet/widgets/button_widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import 'package:coco_meet/Models/eventsModel.dart';
import 'package:coco_meet/Services/global_method.dart';
import 'package:coco_meet/widgets/custom_toast.dart';
import 'package:coco_meet/widgets/textstyles.dart';

class UploadEventForm extends StatefulWidget {
  static const routeName = '/UploadProductForm';
  bool isEditable;
  Product? details;
  UploadEventForm({
    Key? key,
    required this.isEditable,
    this.details,
  }) : super(key: key);
  @override
  _UploadEventFormState createState() => _UploadEventFormState();
}

class _UploadEventFormState extends State<UploadEventForm> {
  final _formKey = GlobalKey<FormState>();
  UploadTask? task;
  File? file;

  var _eventTitle = '';
  // String _productAudioUrl = '';
  var _eventCategory = '';
  var _eventLocation = '';
  var _productDescription = '';
  // var _videoLength = '';
  String fullPath = '';
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _eventLocationController =
      TextEditingController();
  final TextEditingController _eventTitleController = TextEditingController();
  final TextEditingController _eventDescriptionController =
      TextEditingController();
  String? _categoryValue;
  final GlobalMethods _globalMethods = GlobalMethods();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  File? _pickedImage;
  bool _isLoading = false;
  bool _isAudioSelected = false;

  late String url;
  var uuid = const Uuid();

  DateTime? eventStartDate;

  DateTime? eventEndDate;

  @override
  void initState() {
    super.initState();
    if (widget.isEditable && widget.details != null) {
      _eventTitle = widget.details!.title!;
      // _productAudioUrl = widget.details!.videoUrl!;
      _eventCategory = widget.details!.productCategoryName!;
      _eventLocation = widget.details!.productCategoryName!;
      _productDescription = widget.details!.description!;
      // _videoLength = widget.details!.videoLength!;
      _categoryValue = widget.details!.productCategoryName;
      _categoryController.text = widget.details!.productCategoryName!;
      _eventLocationController.text = widget.details!.productCategoryName!;
      _eventTitleController.text = widget.details!.title!;
      _eventDescriptionController.text = widget.details!.description!;
    }
  }

  showAlertDialog(BuildContext context, String title, String body) {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: [
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _trySubmit() async {
    // print("here");
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      // print(_eventTitle);
      // print(_eventCategory);
      // print(_eventLocation);
      // print(_productDescription);
      // print(_videoLength);
      // Use those values to send our request ...
    }
    // print("isValid $isValid");

    if (isValid) {
      _formKey.currentState!.save();
      try {
        if (_pickedImage == null && !widget.isEditable) {
          _globalMethods.authErrorHandle('Please pick an image', context);
        } else {
          setState(() {
            _isLoading = true;
          });
          if (!widget.isEditable) {
            final ref = FirebaseStorage.instance
                .ref()
                .child('productsImages')
                .child(_eventTitle + '.jpg');
            await ref.putFile(_pickedImage!);
            url = await ref.getDownloadURL();
            // await uploadFile();
          }
          final User? user = _auth.currentUser;
          final _uid = user!.uid;
          if (widget.isEditable) {
            Product product = widget.details!;
            await FirebaseFirestore.instance
                .collection('products')
                .doc(product.productId!)
                .update({
              'productId': product.productId,
              'productTitle': _eventTitle,
              'productCategory': _eventCategory,
              'categoryDescription': _eventLocation,
              'productDescription': _productDescription,
              'userId': _uid,
              'createdAt': Timestamp.now(),
            }).then((value) => {
                      print('after firebase'),
                      setState(() {
                        _isLoading = false;
                      }),
                      _globalMethods.authSuccessHandle(
                          'Audio Updated Successfully', context),
                    });
            Navigator.canPop(context) ? Navigator.pop(context) : null;
          } else {
            final String eventId = uuid.v4();
            await FirebaseFirestore.instance
                .collection('products')
                .doc(eventId)
                .set({
              'eventId': eventId,
              'eventTitle': _eventTitle,
              // 'videoUrl': _productAudioUrl,
              'eventImage': url,
              'path': fullPath,
              'eventCategory': _eventCategory,
              'eventLocation': _eventLocation,
              'productDescription': _productDescription,
              // 'videoLength': _videoLength,
              'userId': _uid,
              'createdAt': Timestamp.now(),
            }).then((value) => {
                      print('after firebase'),
                      setState(() {
                        _isLoading = false;
                      }),
                      _globalMethods.authSuccessHandle(
                          'Audio Uploaded Successfully', context),
                    });
          }
          Navigator.canPop(context) ? Navigator.pop(context) : null;
        }
      } catch (error) {
        _globalMethods.authErrorHandle(error.toString(), context);
      } finally {
        setState(() {
          _isLoading = false;
        });

      }
    }
  }

  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 40,
    );
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    // widget.imagePickFn(pickedImageFile);
  }

  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    final pickedImageFile = pickedImage == null ? null : File(pickedImage.path);

    setState(() {
      _pickedImage = pickedImageFile!;
    });
    // widget.imagePickFn(pickedImageFile);
  }

  void _removeImage() {
    setState(() {
      // _pickedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? _eventTitle : 'No File Selected';

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      // Flexible(
                      //   flex: 3,
                      // child:
                      Padding(
                        padding: const EdgeInsets.only(right: 9),
                        child: TextFormField(
                          key: const ValueKey('Title'),
                          controller: _eventTitleController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Title';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Event Title',
                          ),
                          onSaved: (value) {
                            _eventTitle = value!;
                          },
                        ),
                      ),
                      // ),
                      //   Flexible(
                      //     flex: 1,
                      //     child: TextFormField(
                      //       key: ValueKey('Price \$'),
                      //       keyboardType: TextInputType.number,
                      //       validator: (value) {
                      //         if (value!.isEmpty) {
                      //           return 'Price is missed';
                      //         }
                      //         return null;
                      //       },
                      //       inputFormatters: <TextInputFormatter>[
                      //         FilteringTextInputFormatter.allow(
                      //             RegExp(r'[0-9]')),
                      //       ],
                      //       decoration: InputDecoration(
                      //         labelText: 'Price \$',
                      //         //  prefixIcon: Icon(Icons.mail),
                      //         // suffixIcon: Text(
                      //         //   '\n \n \$',
                      //         //   textAlign: TextAlign.start,
                      //         // ),
                      //       ),
                      //       //obscureText: true,
                      //       onSaved: (value) {
                      //         _productPrice = value!;
                      //       },
                      //     ),
                      //   ),

                      // ],
                      // ),
                      widget.isEditable
                          ? const SizedBox()
                          : Column(
                              children: [
                                const SizedBox(height: 10),

                                // _isLoadingButtons
                                //     ? LoadingIndicator()
                                //     : ElevatedButton.icon(
                                //         onPressed: uploadFile,
                                //         icon: Icon(Icons.file_upload_outlined),
                                //         label: Text("Upload Video")),
                                const SizedBox(height: 10),
                                /* Image picker here ***********************************/
                                Text(
                                  "Select Image",
                                  style: titleTextStyle(
                                      context: context,
                                      color: Theme.of(context).dividerColor),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      //  flex: 2,
                                      // ignore: unnecessary_null_comparison
                                      child: this._pickedImage == null
                                          ? Container(
                                              margin: const EdgeInsets.all(10),
                                              height: 200,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                border: Border.all(width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: Theme.of(context)
                                                    .backgroundColor,
                                              ),
                                            )
                                          : Container(
                                              margin: const EdgeInsets.all(10),
                                              height: 200,
                                              width: 200,
                                              child: Container(
                                                height: 200,
                                                // width: 200,
                                                decoration: BoxDecoration(
                                                  // borderRadius: BorderRadius.only(
                                                  //   topLeft: const Radius.circular(40.0),
                                                  // ),
                                                  color: Theme.of(context)
                                                      .backgroundColor,
                                                ),
                                                child: Image.file(
                                                  this._pickedImage!,
                                                  fit: BoxFit.contain,
                                                  alignment: Alignment.center,
                                                ),
                                              ),
                                            ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FittedBox(
                                          child: IconButton(
                                            // textColor: Colors.white,
                                            onPressed: _pickImageCamera,
                                            icon: const Icon(Icons.camera,
                                                color: Colors.purpleAccent),
                                            tooltip: 'Pick Image from camera',
                                            // label: Text(
                                            //   'Camera',
                                            //   style: TextStyle(
                                            //     fontWeight: FontWeight.w500,
                                            //     color: Theme.of(context)
                                            //         .textSelectionColor,
                                            //   ),
                                            // ),
                                          ),
                                        ),
                                        FittedBox(
                                          child: IconButton(
                                            // textColor: Colors.white,
                                            onPressed: _pickImageGallery,
                                            icon: const Icon(Icons.image,
                                                color: Colors.purpleAccent),
                                            tooltip: 'Pick Image from gallery',
                                            // label: Text(
                                            //   'Gallery',
                                            //   style: TextStyle(
                                            //     fontWeight: FontWeight.w500,
                                            //     color: Theme.of(context)
                                            //         .textSelectionColor,
                                            //   ),
                                            // ),
                                          ),
                                        ),
                                        FittedBox(
                                          child: IconButton(
                                            // textColor: Colors.white,
                                            onPressed: _removeImage,
                                            icon: const Icon(
                                              Icons.remove_circle_rounded,
                                              color: Colors.red,
                                            ),
                                            tooltip: 'Remove Image',
                                            // label: Text(
                                            //   'Remove',
                                            //   style: TextStyle(
                                            //     fontWeight: FontWeight.w500,
                                            //     color: Colors.redAccent,
                                            //   ),
                                            // ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                              onPressed: () {
                                DatePicker.showDatePicker(
                                  context,
                                  showTitleActions: true,
                                  minTime: DateTime.now(),
                                  maxTime: DateTime(2024, 6, 7),
                                  onChanged: (date) {
                                  },
                                  onConfirm: (date) {
                                    setState(() {
                                      eventStartDate = date;
                                    });
                                  },
                                  currentTime: DateTime.now(),
                                );
                              },
                              child: Text(
                                eventStartDate != null
                                    ? '${eventStartDate!.day}/${eventStartDate!.month}/${eventStartDate!.year}'
                                    : 'Select Event Starting Date',
                                style: const TextStyle(color: Colors.blue),
                              )),
                          TextButton(
                              onPressed: () {
                                DatePicker.showDatePicker(
                                  context,
                                  showTitleActions: true,
                                  minTime: DateTime.now(),
                                  maxTime: DateTime(2024, 6, 7),
                                  onChanged: (date) {
                                  },
                                  onConfirm: (date) {
                                    setState(() {
                                      eventEndDate = date;
                                    });
                                  },
                                  currentTime: DateTime.now(),
                                );
                              },
                              child: Text(
                                eventEndDate != null
                                    ? '${eventEndDate!.day}/${eventEndDate!.month}/${eventEndDate!.year}'
                                    : 'Select Event End Date',
                                style: const TextStyle(color: Colors.blue),
                              )),
                        ],
                      ),
                      //    SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            // flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 9),
                              child: TextFormField(
                                controller: _categoryController,

                                key: const ValueKey('Category'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a Csategory';
                                  }
                                  return null;
                                },
                                //keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  labelText: 'Add a new Category',
                                ),
                                onSaved: (value) {
                                  _eventCategory = value!;
                                },
                              ),
                            ),
                          ),
                          DropdownButton<String>(
                            items: const [
                              DropdownMenuItem<String>(
                                value: 'Music',
                                child: Text('Music'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Art',
                                child: Text('Art'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Workshop',
                                child: Text('Workshop'),
                              ),
                            ],
                            onChanged: (String? value) {
                              setState(() {
                                _categoryValue = value!;
                                _categoryController.text = value;
                                //_controller.text= _productCategory;
                              });
                            },
                            hint: const Text('Select a Category'),
                            value: _categoryValue,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 9),
                              child: Container(
                                child: TextFormField(
                                  controller: _eventLocationController,

                                  key: const ValueKey(
                                      'Category Description(Optional)'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Event Location is missed';
                                    }
                                    return null;
                                  },
                                  //keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    labelText: 'Event Location',
                                  ),
                                  onSaved: (value) {
                                    _eventLocation = value!;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                          key: const ValueKey('Description'),
                          controller: _eventDescriptionController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'video description is required';
                            }
                            return null;
                          },
                          //controller: this._controller,
                          maxLines: 10,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration(
                            //  counterText: charLength.toString(),
                            labelText: 'Description',
                            hintText: 'Audio description',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (value) {
                            _productDescription = value!;
                          },
                          onChanged: (text) {
                            // setState(() => charLength -= text.length);
                          }),
                      //    SizedBox(height: 10),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   crossAxisAlignment: CrossAxisAlignment.end,
                      //   children: [
                      //     Expanded(
                      //       //flex: 2,
                      //       child: Padding(
                      //         padding: const EdgeInsets.only(right: 9),
                      //         child: TextFormField(
                      //           keyboardType: TextInputType.number,
                      //           key: ValueKey('Quantity'),
                      //           validator: (value) {
                      //             if (value!.isEmpty) {
                      //               return 'Quantity is missed';
                      //             }
                      //             return null;
                      //           },
                      //           decoration: InputDecoration(
                      //             labelText: 'Quantity',
                      //           ),
                      //           onSaved: (value) {
                      //             _productQuantity = value!;
                      //           },
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _isLoading
                  ? const CircularProgressIndicator.adaptive()
                  : BlueElevatedButton(
                      text: 'Upload',
                      onPressed: () => _trySubmit(),
                      icon: Icons.upload,
                    ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.any);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() {
      file = File(path);
      _isAudioSelected = true;
    });
    // VideoPlayerController fileVideocontroller =
    // VideoPlayerController.file(file!)..initialize();
    CustomToast.successToast(message: "Audio Selected Successfully");
    // debugPrint("========" + fileVideocontroller.value.duration.toString());
  }

  // Future uploadFile() async {
  //   if (file == null) return;
  //   final fileName = _eventTitle;
  //   final destination = 'videos/$_eventCategory/$fileName';

  //   // task = FirebaseApi.uploadFile(destination, file!);
  //   setState(() {});

  //   if (task == null) return;

  //   final snapshot = await task!.whenComplete(() {});
  //   final urlDownload = await snapshot.ref.getDownloadURL();
  //   fullPath = destination;
  //   setState(() {
  //     _productAudioUrl = urlDownload;
  //   });
  //   CustomToast.successToast(message: "Audio Uploaded SuccessFully");
  //   print('Download-Link: $urlDownload');
  // }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
}

class GradientIcon extends StatelessWidget {
  const GradientIcon(
    this.icon,
    this.size,
    this.gradient,
  );

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}
