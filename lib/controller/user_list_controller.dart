import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_list/model/user_model.dart';
import 'package:http/http.dart' as http;

class UserListController extends GetxController {
  RxList<UserList> users = <UserList>[].obs;

  int currentPage = 1;
  RxBool isLoading = false.obs;
  RxBool hasMore = true.obs;

  final int limit = 10;
  Rx<UserList?> lastOpenUser = Rx<UserList?>(null);
  @override
  void onInit() {
    getUsersList();
    super.onInit();
  }

  Future<void> getUsersList() async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;

    try {
      final url = Uri.parse(
        "https://fake-json-api.mock.beeceptor.com/users?_page=$currentPage&_limit=$limit",
      );

      final response = await http.get(url);
      print("Response: ${response.body}");

      print("Fetching page: $currentPage");
      if (response.statusCode == 200) {
        final List<UserList> fetchUsers = userListFromJson(response.body);

        print("Fetched: ${fetchUsers.length} users");

        if (fetchUsers.length < limit) {
          hasMore.value = false;
        }

        users.addAll(fetchUsers);
        currentPage++;
      } else {
        Get.snackbar("Error", "Failed to load data ${response.statusCode}");
      }
    } on SocketException catch (_) {
      Get.snackbar(
        "No Internet",
        "Please check your connection.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void resetAndFetch() {
    users.clear();
    currentPage = 1;
    hasMore.value = true;
    loadOpenUser();
    getUsersList();
  }

  Future<void> lastUser(UserList user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_user', json.encode(user.toJson()));
    lastOpenUser.value = user;
  }

  Future<void> loadOpenUser() async {
    final prefs = await SharedPreferences.getInstance();
    final lastUser = prefs.getString("last_user");

    if (lastUser != null) {
      lastOpenUser.value = UserList.fromJson(json.decode(lastUser));
    }
  }
}
