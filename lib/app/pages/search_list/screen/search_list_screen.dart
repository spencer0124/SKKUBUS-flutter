import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:skkumap/app/components/mainpage/middle_snappingsheet/stationrow.dart';
import 'package:skkumap/app_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:skkumap/app/pages/search_list/controller/search_list_controller.dart';

import 'package:skkumap/app/components/NavigationBar/custom_navigation.dart';
import 'package:skkumap/app/utils/screensize.dart';
import 'package:skkumap/app/model/search_option3_model.dart';

class SearchList extends StatelessWidget {
  SearchList({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = ScreenSize.height(context);
    final double screenWidth = ScreenSize.width(context);

    final controller = Get.find<SearchListController>();

    searchController.addListener(() {
      controller.onSearchChanged(searchController.text);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            alignment: Alignment.centerLeft,
            height: 49,
            width: screenWidth * 0.95,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              // only bottom border! bottom border

              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: Icon(
                    Icons.search,
                    size: 23,
                    color: Colors.grey[600],
                  ),
                ),

                SizedBox(
                  width: dwidth * 0.8,
                  height: 12,
                  child: TextField(
                    controller: searchController,
                    autocorrect: false,
                    enableSuggestions: false,
                    enableIMEPersonalizedLearning: false,
                    keyboardType: TextInputType.name,
                    // controller: controller.passwordController,
                    obscureText: false,
                    // obscuringCharacter: '*',
                    style: const TextStyle(
                      color: Colors.black,
                      // fontSize: 20,
                      fontFamily: 'CJKMedium',
                    ),
                    cursorColor: AppColors.green_main,
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(20),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Colors.transparent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Colors.transparent),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
                // Text(
                //   '성균관대 공간명/코드 검색',
                //   style: TextStyle(
                //     color: Colors.grey[400],
                //     fontFamily: 'CJKMedium',
                //     fontSize: 15,
                //   ),
                // ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => controller.updateFilter(SearchTab.all),
                child: const Text('All'),
              ),
              ElevatedButton(
                onPressed: () => controller.updateFilter(SearchTab.hssc),
                child: const Text('HSSC'),
              ),
              ElevatedButton(
                onPressed: () => controller.updateFilter(SearchTab.nsc),
                child: const Text('NSC'),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(() {
            // Filtered list based on the current tab
            List<SpaceItem> items = controller.filteredItems;
            if (items.isEmpty) {
              // If the list is empty, show a "No results" message
              return const Center(
                child: Text('검색 결과가 없습니다.'),
              );
            } else {
              // Otherwise, build the list as usual
              return Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    SpaceItem item = items[index];
                    // ... build your ListTile ...
                    return ListTile(
                      title: Row(
                        children: [
                          Text(
                            item.spaceInfo!.spaceNmKr!,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(item.spaceInfo!.spaceCd!,
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontFamily: 'CJKMedium',
                                fontSize: 15,
                              )),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Text(item.category!),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(item.buildingInfo!.buildNmKr!),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(item.spaceInfo!.floorNmKr!),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
