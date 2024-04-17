import 'package:flutter/material.dart';

class RankTable extends StatelessWidget {
  final List<UserItem> userItems;
  final String currentUserName;

  const RankTable({
    Key? key,
    required this.userItems,
    required this.currentUserName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sort userItems based on points in descending order
    List<UserItem> sortedItems = List.from(userItems);
    sortedItems.sort((a, b) => b.point.compareTo(a.point));

    return Container(
      height: MediaQuery.of(context).size.height * 0.50,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
          bottom: Radius.circular(20), // Adjusted to make bottom round
        ),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 15),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: sortedItems.length,
        itemBuilder: (context, index) {
          final items = sortedItems[index];
          final isCurrentUser = items.name == currentUserName;
          final isOnScreen = index < 5; // Assuming only the top 5 users are shown on the screen

          return Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 15),
            child: Row(
              children: [
                Text(
                  (index + 1).toString(), // Display rank as index + 1
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 15),
                CircleAvatar(
                  radius: 25,
                  backgroundImage: items.image.isNotEmpty
                      ? AssetImage(items.image)
                      : AssetImage("assets/images/woman.png"), // Default image path
                ),
                const SizedBox(width: 15),
                // Adjusted TextStyle to remove glow effect
                Text(
                  items.name,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: isCurrentUser ? FontWeight.bold : isOnScreen ? FontWeight.w500 : FontWeight.normal,
                    color: isCurrentUser ? Colors.deepOrangeAccent : null,
                  ),
                ),
                const Spacer(),
                Text(
                  items.point.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class UserItem {
  final String image;
  final String name;
  final int point;

  UserItem({
    required this.image,
    required this.name,
    required this.point,
  });
}
