import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facelink/post.dart';
import 'package:facelink/post_tile.dart';
import 'package:facelink/progress.dart';
import 'package:facelink/search.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'post_container.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {

  final String profileId;

  MyHomePage({this.profileId});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String postOrientation = "grid";
  bool isFollowing = false;
  bool isLoading = false;
  int postCount = 0;
  int followerCount = 0;
  int followingCount = 0;
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    getProfilePosts();

  }

  getProfilePosts() async {
    setState(() {
      isLoading = true;
    });
    QuerySnapshot snapshot = await postsRef
        .doc(widget.profileId)
        .collection('userPosts')
        .orderBy('timestamp', descending: true)
        .get();
    setState(() {
      isLoading = false;
      postCount = snapshot.docs.length;
      posts = snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
    });
  }

  buildProfilePosts() {

    bool isLoading = false;
    if (isLoading) {
      return circularProgress();
    }
    return Column(
      children: posts,
    );
  }


  // camera croper add by utsav
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
          statusBarColor: Colors.lightBlueAccent[700],
          backgroundColor: Colors.white,
        ),
      );
      this.setState(() {
        //_selectedFile = cropped;
      });
    }
  }
  // end camera 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue,
        leading: IconButton(
        icon: PostInteraction(
           Icons.photo_camera,
           Colors.white,
        ),
          onPressed: ()
          {
            // call camera 
           getImage(ImageSource.camera);
          },
        ),
        centerTitle: true,
        title: Text(
          "FaceLink",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('search');
                },
              ),
            ],
          )
        ],
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(0.0),
          children: [
            buildProfilePosts(),
          ],
        ),
      ),
    );
  }
}
