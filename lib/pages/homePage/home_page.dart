import 'package:flutter/material.dart';
import 'package:srhealthcare/model/post_model.dart';
import 'package:srhealthcare/pages/homePage/homePage_Tools/dropdown_example.dart';
import 'package:srhealthcare/pages/homePage/homePage_Tools/namenotificationsavepost.dart';
import 'package:srhealthcare/services/postService/post_service.dart';
import 'package:srhealthcare/services/sharedprefrence_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> postType = [];
  String selectedTab = "All";
  List<PostModel> postList = [];
  bool isPaginationLoading = false;
  int currentPage = 1;
  int noOfRec = 10;
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();
  String? selectedLocation;
  String username =
      '${SharedPreferenceHelper().getUserData()?.name ?? ''} ${SharedPreferenceHelper().getUserData()?.lastName ?? ''}';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          getData(isLoadMore: true);
        }
      }
    });
  }

  Future<void> getData({bool isLoadMore = false}) async {
    if (isPaginationLoading) {
      return;
    }
    if (!isLoadMore) {
      currentPage = 1;
    }
    setState(() {
      if (!isLoadMore) {
        isLoading = true;
      } else {
        isPaginationLoading = true;
        currentPage++;
      }
    });

    try {
      // Use the selected location for filtering
      final locationFilter =
          (selectedLocation == "All" || selectedLocation == null)
              ? ''
              : selectedLocation;

      // Fetch posts from the service
      final (error, data) = await PostService().fetchPosts(
        location: locationFilter ?? '',
        currentPage: currentPage,
        noOfRec: noOfRec,
      );

      if (error?.isNotEmpty == true || data == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error ?? 'Something went wrong')),
        );
      } else {
        final allPosts = postList
                ?.where((element) => element.status == 'Approved')
                .toList() ??
            [];

        setState(() {
          if (!isLoadMore) {
            // Reset the post list if not loading more
            postList = allPosts;
          } else {
            // Filter out duplicates and append new posts
            postList.addAll(allPosts
                .where((post) =>
                    !postList.any((existingPost) => existingPost.id == post.id))
                .toList());
          }

          // Filter posts based on the selected tab
          if (selectedTab != "All") {
            postList = postList
                .where((post) => post.postType?.name == selectedTab)
                .toList();
          }
          // currentPage++;

          // if (data.postList?.isNotEmpty == true) {
          //   currentPage++;
          // }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() {
        isPaginationLoading = false;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery.of(context).size.height / 4.5,
        flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    end: Alignment.bottomRight,
                    begin: Alignment.topLeft,
                    colors: [
                      const Color.fromARGB(255, 48, 8, 159),
                      const Color.fromARGB(255, 76, 35, 146).withOpacity(.6)
                    ]),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Padding(
              padding: EdgeInsets.only(top: 40, left: 10, right: 10),
              child: Column(
                children: [
                  NameNotificationSavedPost(name: username),
                  DropdownExample(onLocationSelected: (selectedLocation) {
                    this.selectedLocation = selectedLocation;
                  })
                ],
              ),
            )),
      ),
    );
  }
}
