import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:facelink/post_container.dart';
import 'package:facelink/progress.dart';
import 'package:facelink/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:storage_path/storage_path.dart';
import 'file.dart';
import 'package:facelink/home.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;
import 'package:uuid/uuid.dart';
import 'package:geolocator/geolocator.dart';
// ignore: must_be_immutable
class AddPost extends StatefulWidget {

  User currentUser;
  AddPost(a)
  {
    this.currentUser=a;
  }
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> with AutomaticKeepAliveClientMixin<AddPost>{

  TextEditingController locationController=TextEditingController();
  TextEditingController captionController=TextEditingController();
  File _selectedFile;
  bool isPost=true;
  String postId = Uuid().v4();
  Widget getImageWidget() {
    return Image.file(_selectedFile, fit: BoxFit.cover);
  }

  bool isUploading=false;

  getImage(ImageSource source) async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(source: source);
    if (image != null) {
      File cropped = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: AndroidUiSettings(
          toolbarColor: Colors.blue,
          toolbarTitle: "Crop Image",
          statusBarColor: Colors.blue,
          backgroundColor: Colors.white,
        ),
      );
      this.setState(() {
        GallerySaver.saveImage(cropped.path);
        _selectedFile = image;
      });
    }
  }

  List<FileModel> files;
  FileModel selectedModel;
  String image;

  Widget imageFileSelect(String image) {
    if (image == null) {
      return Container();
    } else {
      _selectedFile=File(image);
      return Image.file(
        File(image),
      );
      // height: MediaQuery.of(context).size.height * 0.30,
      // width: MediaQuery.of(context).size.width,

    }
  }

  @override
  void initState() {
    super.initState();
    getImagePath();
  }

  getImagePath() async {
    var imagePath = await StoragePath.imagesPath;
    var images = jsonDecode(imagePath) as List;
    files = images.map<FileModel>((e) => FileModel.fromJson(e)).toList();
    if (files != null && files.length > 0) {
      setState(() {
        selectedModel = files[0];
        image = files[0].files[0];
      });
    } else {
      files = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return isPost ? selectPic() : buildUploadForm();
  }
  Scaffold selectPic(){
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.clear),
                    SizedBox(
                      width: 10,
                    ),
                    files != null
                        ? DropdownButtonHideUnderline(
                      child: DropdownButton<FileModel>(
                        items: getItems(),
                        onChanged: (FileModel d) {
                          assert(d.files.length >= 0);
                          image = d.files[0];
                          setState(() {
                            selectedModel = d;
                          });
                        },
                        value: selectedModel,
                      ),
                    )
                        : Container(),
                  ],
                ),
                FlatButton(
                  onPressed: () {
                      setState(() {
                        isPost=false;
                      });


                  },
                  child: Text(
                    'Next',
                    style: TextStyle(color: Colors.lightBlueAccent[700]),
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.black,
            ),
            files != null
                ? Expanded(
              //height: MediaQuery.of(context).size.height * 0.30,
              child: imageFileSelect(image),
            )
                : Container(),
            Divider(),
            // Container(
            //   child: getImageWidget(),
            //),
            files != null
                ? selectedModel == null && selectedModel.files.length < 1
                ? Expanded(child: Container())
                : Expanded(
              child: Container(
                child: GridView.builder(
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4),
                  itemBuilder: (_, i) {
                    String file = selectedModel.files[i];
                    return GestureDetector(
                      child: Image.file( File(file), fit: BoxFit.cover,),
                      onTap: () {
                        setState(() {
                          _selectedFile=File(file);
                          image = file;

                        });
                      },
                    );
                  },
                  itemCount: selectedModel.files.length,
                ),
              ),
            )
                : Container(),

            SizedBox(
              height: 2,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    iconSize: 30,
                    icon: PostInteraction(
                      Icons.photo_camera,
                      Colors.white,
                    ),
                    onPressed: () {
                      getImage(ImageSource.camera);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

}



  List<DropdownMenuItem> getItems() {
    return files
        .map((e) =>
        DropdownMenuItem(
          child: Text(
            e.folder,
            style: TextStyle(color: Colors.black),
          ),
          value: e,
        ))
        .toList() ??
        [];
  }





  clearImage() {
    setState(() {
      image= null;
    });
  }



  compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image imageFile = Im.decodeImage(_selectedFile.readAsBytesSync());
    final compressedImageFile = File('$path/img_$postId.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));
    setState(() {
      _selectedFile = compressedImageFile;
    });
  }

  Future<String> uploadImage(imageFile) async {

    Reference reference=storageRef.child("post_$postId.jpg");
    await reference.putFile(imageFile);
    return await reference.getDownloadURL();
  }

  createPostInFirestore(
      {String mediaUrl, String location, String description}) {
    postsRef
        .doc(currentUser.id)
        .collection("userPosts")
        .doc(postId)
        .set({
      "postId": postId,
      "ownerId": currentUser.id,
      "username": currentUser.username,
      "mediaUrl": mediaUrl,
      "description": description,
      "location": location,
      "timestamp": timestamp,
      "likes": {},
    });
  }
  handleSubmit() async {
    setState(() {
      isUploading = true;
    });
    await compressImage();
    String mediaUrl = await uploadImage(_selectedFile);
    createPostInFirestore(
      mediaUrl: mediaUrl,
      location: locationController.text,
      description: captionController.text,
    );
    captionController.clear();
    locationController.clear();
    setState(() {
      _selectedFile = null;
      isUploading = false;
      postId = Uuid().v4();
    });
  }




  Scaffold buildUploadForm() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: (){
              setState(() {
                clearImage();
                isPost=true;
              });
            }),
        title: Text(
          "Caption Post",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          FlatButton(
            onPressed: isUploading ? null :()=>handleSubmit(),
            child: Text(
              "Post",
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          isUploading ? linearProgress() : Text(""),
          Container(
             child: imageFileSelect(image),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
          ),
          ListTile(
            leading:
          currentUser.photoUrl == null ?Icon(Icons.account_circle):CircleAvatar(

              backgroundImage: CachedNetworkImageProvider(currentUser.photoUrl),
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                controller: captionController,
                decoration: InputDecoration(
                  hintText: "Write a caption...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.pin_drop,
              color: Colors.orange,
              size: 35.0,
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                controller: locationController,
                decoration: InputDecoration(
                  hintText: "Where was this photo taken?",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            width: 200.0,
            height: 100.0,
            alignment: Alignment.center,
            child: RaisedButton.icon(
              label: Text(
                "Use Current Location",
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              color: Colors.blue,
              onPressed: () => getUserLocation(),
              icon: Icon(
                Icons.my_location,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
  getUserLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];
    String completeAddress =
        '${placemark.subThoroughfare} ${placemark.thoroughfare}, ${placemark.subLocality} ${placemark.locality}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea} ${placemark.postalCode}, ${placemark.country}';
    print(completeAddress);
    String formattedAddress = "${placemark.locality}, ${placemark.country}";

    locationController.text = formattedAddress;
  }

  bool get wantKeepAlive => true;

}
