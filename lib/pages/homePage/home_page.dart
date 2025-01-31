import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:srhealthcare/Utils/app_cache_network_image.dart';
import 'package:srhealthcare/constant/color_constant.dart';
import 'package:srhealthcare/customWidgets/custom_action.dart';
import 'package:srhealthcare/customWidgets/custom_chip.dart';
import 'package:srhealthcare/customWidgets/custom_text.dart';
import 'package:srhealthcare/customWidgets/expandable_text.dart';
import 'package:srhealthcare/customWidgets/timeago.dart';
import 'package:srhealthcare/model/post_model.dart';
import 'package:srhealthcare/pages/feedDetailPage/feed_detail_page.dart';
import 'package:srhealthcare/pages/homePage/homePage_Tools/dropdown_example.dart';
import 'package:srhealthcare/pages/homePage/homePage_Tools/namenotificationsavepost.dart';
import 'package:srhealthcare/pages/homePage/homePage_Tools/search_and_filter.dart';
import 'package:srhealthcare/services/postService/post_service.dart';
import 'package:srhealthcare/services/shareService/share_plus_service.dart';
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
    super.initState();
    fetchPostTypeList;
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          getData(isLoadMore: true);
        }
      }
    });
  }
  Future<void> fetchPostTypeList() async {
    // setState(() {
    //   isLoading = true; // Show loading indicator while fetching
    // });

    final fetchedPostTypes = await PostService().fetchPostTypeList();

    setState(() {
      isLoading = false; // Hide loading indicator after fetching

      // Add default "All" to the fetched list and remove duplicates
      postType = ["All"] + fetchedPostTypes.toSet().toList();

      // Set the default tab to the first post type, or "All" if no post types are available
      if (postType.isNotEmpty) {
        selectedTab = postType.first;
      }
    });

    // Fetch posts when the post types list is updated
    getData();
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

  Widget _buildPostList() {
    if (isLoading) {
      return SliverToBoxAdapter(
          child: const Center(child: CircularProgressIndicator()));
    }
    if (postList.isEmpty) {
      return SliverToBoxAdapter(
        child: const Center(
          child: Text(
            "No posts available",
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }
    return SliverList.builder(
      itemCount: postList.length,
      itemBuilder: (context, index) {
        final post = postList[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: GestureDetector(
            onTap: () async {
              log('message');
              final value = await Get.to(() => FeedDetailPage(
                    post: post,
                  ));
              log(value);
              if (value == true) {
                setState(() {
                  getData();
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade100,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundColor: gradientColor1,
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: gradientColor1,
                          child: AppCacheNetworkImage(
                            width: Get.width,
                            borderRadius: 50,
                            imageUrl: post?.user?.photo?.url ?? '',
                            height: Get.height,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: post?.userName ?? '',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            CustomText(
                                text: post?.user?.department ?? '',
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: greyColorShade)
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/homepage/clock.png',
                            height: 15,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          TimeAgoCustomWidget(
                            createdAt: post.createdAt.toString(),
                            size: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: AppCacheNetworkImage(
                      imageUrl: post?.thumbnail ?? '',
                      fit: BoxFit.cover,
                      height: 180,
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ExpandableText(
                    text: post?.description ?? '',
                    trimLength: 100,
                  ),
                  const SizedBox(height: 10),
                  if (post?.fieldName != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: CustomChip(title: post?.fieldName ?? ''),
                    ),
                  const SizedBox(height: 10),
                  Divider(
                    thickness: .5,
                    color: Colors.grey.withOpacity(.2),
                  ),
                  Row(
                    children: [
                      // Obx(() {
                      //   // Use the isPostSaved method to check if the post is saved
                      //   bool isSaved =
                      //       savepostController.isPostSaved(post.id ?? -1);

                      //   return SaveButton(
                      //     postId: post.id ?? -1,
                      //     isSaved: isSaved,
                      //   );
                      // }),
                      const SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                          onTap: () {
                            ShareService().shareText(
                                'Hello This Is My Post on Sr HealthCare ${post?.thumbnail}');
                          },
                          child: CustomAction(
                            image:
                                'assets/path/to/your/image.png', // Provide image path here
                            label: 'Your Label',
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


Widget _buildTab(String title, bool isActive) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = title; // Update the selected tab
          currentPage = 1;
        });
        getData(); // Fetch posts based on the selected tab
      },
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 40,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: isActive ? gradientColor1 : gradientColor1.withOpacity(.03),
          borderRadius: BorderRadius.circular(15),
        ),
        child: CustomText(text: title ,color:  isActive ?whiteColor :blackColor , fontSize: 13 ,fontWeight: FontWeight.w500,)
        
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery.of(context).size.height / 4.4,
        flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    end: Alignment.bottomRight,
                    begin: Alignment.topLeft,
                    colors: [gradientColor1, gradientColor2]),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Padding(
              padding: EdgeInsets.only(top: 40, left: 10, right: 10),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      height: 25,
                      child: NameNotificationSavedPost(name: username)),
                  DropdownExample(onLocationSelected: (selectedLocation) {
                    setState(() {
                      this.selectedLocation = selectedLocation;
                    });
                    getData();
                  }),
                  SearchAndFilterWidget()
                ],
              ),
            )),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: postType.isEmpty
            ?Center(child: CircularProgressIndicator( color: gradientColor1,  ),)
            :SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: postType.map((type) {
                  return _buildTab(type , selectedTab ==type);
                }).toList()
                ),
            ),
            
          ),
          _buildPostList(),
          if(isPaginationLoading)
          SliverPadding(padding: EdgeInsets.symmetric(vertical: 5.0),
          sliver: SliverToBoxAdapter(child: Center(child: CircularProgressIndicator(),),),
          )
        ],
      ),
    );
  }
}
