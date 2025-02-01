import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:srhealthcare/constant/color_constant.dart';
import 'package:srhealthcare/constant/text_constant.dart';
import 'package:srhealthcare/customWidgets/custom_text.dart';
import 'package:srhealthcare/pages/searchPage/search_page.dart';

class SearchAndFilterWidget extends StatelessWidget {
  const SearchAndFilterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Get.to(
                  transition: Transition.zoom,
                  duration: const Duration(milliseconds: 2),
                  const SearchPage());
            },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.search_rounded),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomText(
                      text: TextConstant.searchBarHintText,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color:  ColorConstant.greyColor,
                    )
                  ],
                )),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        // GestureDetector(
        //   onTap: () {
        //     showModalBottomSheet(
        //         isScrollControlled: true,
        //         context: context,
        //         builder: (_) => const SortFilterBottomSheet());
        //   },
        //   child: CircleAvatar(
        //     backgroundColor: whiteColor,
        //     child: Image.asset(
        //       'assets/homepage/filter.png',
        //       height: 18,
        //     ),
        //   ),
        // )
      ],
    );
  }
}
