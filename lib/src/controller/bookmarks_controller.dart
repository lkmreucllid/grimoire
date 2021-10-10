import 'package:flutter_medium/src/models/bookmarks_model.dart';
import 'package:flutter_medium/src/provider/bookmarks_provider.dart';
import 'package:flutter_medium/src/utils/server_communicator.dart';
import 'package:get/get.dart';

class BookmarkController extends GetxController {
  RxBool isBookMarked = false.obs;
  RxString bookmarkId = "".obs;
  RxString selectedFeedId = "".obs;
  RxBool isBookmarkScreenLoading = false.obs;
  BookmarksProvider bookMarksProvider = new BookmarksProvider();
  BookmarksModel bookmarksModel;
  RxList<BookmarkList> bookmarkList = <BookmarkList>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getBookMarkFeed(String feedId) async {
    bookMarksProvider
        .getBookmarks(ServerCommunicator().baseUrl + "post/book-marked")
        .then((value) {
      if (value.body['sucess'] == true) {
        if (value.body['message'] == 'Post found') {
          bookmarksModel = BookmarksModel.fromJson(value.body);
          bookmarkList.value = bookmarksModel.data;

          bookmarkList.forEach((element) {
            if (element.feedId == feedId) {
              isBookMarked.value = true;
              bookmarkId.value = element.bookMarkId;
            }
          });

          update();
        } else if (value.body['message'] == 'No Posts found') {
          update();
        }
      }
    });
  }

  void addBookMark(String feedId) async {
    isBookMarked.value = true;
    bookMarksProvider
        .addBookMark(ServerCommunicator().baseUrl + "post/add-bookmark/$feedId")
        .then((value) {
      if (value.body['sucess'] == true) {
        if (value.body['message'] == 'Post Bookmarked') {
          getBookMarkFeed(feedId);
          update();
        } else if (value.body['message'] == 'No Posts found') {
          update();
        }
      }
    });
  }

  void deleteBookMark(String feedId) async {
    isBookMarked.value = false;
    bookMarksProvider
        .deleteBookMark(ServerCommunicator().baseUrl +
            "post/remove-bookmark/${bookmarkId.value}")
        .then((value) {
      if (value.body['sucess'] == true) {
        if (value.body['message'] == 'Removed Bookmarked') {
          getBookMarkFeed(feedId);
          update();
        } else if (value.body['message'] == 'No Posts found') {
          update();
        }
      }
    });
  }

  void getAllBookMarks() async {
    isBookmarkScreenLoading.value = true;
    bookMarksProvider
        .getBookmarks(ServerCommunicator().baseUrl + "post/book-marked")
        .then((value) {
      if (value.body['sucess'] == true) {
        if (value.body['message'] == 'Post found') {
          isBookmarkScreenLoading.value = false;
          bookmarksModel = BookmarksModel.fromJson(value.body);
          bookmarkList.value = bookmarksModel.data;

          update();
        } else if (value.body['message'] == 'Not bookmarked Yet') {
          isBookmarkScreenLoading.value = false;
          update();
        }
      }
    });
  }
}
