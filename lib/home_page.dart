import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_list/controller/user_list_controller.dart';
import 'package:user_list/user_detail_screen.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final UserListController userList = Get.put(UserListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User List",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (userList.users.isEmpty &&
            !userList.isLoading.value &&
            userList.lastOpenUser.value == null) {
          return const Center(
            child: Text(
              "No users found.\nCheck your internet connection.",
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            userList.resetAndFetch();
          },

          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (!userList.isLoading.value &&
                  userList.hasMore.value &&
                  scrollInfo.metrics.pixels >=
                      scrollInfo.metrics.maxScrollExtent - 100) {
                userList.getUsersList();
              }
              return true;
            },
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount:
                  userList.users.length +
                  (userList.hasMore.value ? 1 : 0) +
                  (userList.lastOpenUser.value != null ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == 0 && userList.lastOpenUser.value != null) {
                  final user = userList.lastOpenUser.value!;
                  return Card(
                    color: Colors.yellow.shade100,
                    child: ListTile(
                      title: Text(
                        "Last Opened: ${user.name}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(user.email),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.photo),
                      ),
                    ),
                  );
                }

                final realIndex =
                    index - (userList.lastOpenUser.value != null ? 1 : 0);

                if (realIndex < userList.users.length) {
                  final user = userList.users[realIndex];
                  return InkWell(
                    onTap: () {
                      userList.lastOpenUser(user);
                      Get.to(() => UserDetailScreen(user: user));
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.photo),
                      ),
                      title: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: "Name: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: user.name,
                              style: const TextStyle(color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 6),
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: "Email: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: user.email,
                                  style: const TextStyle(color: Colors.black87),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 6),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        );
      }),
    );
  }
}
