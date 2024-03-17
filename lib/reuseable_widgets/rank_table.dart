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
      height: MediaQuery.of(context).size.height * 0.45,
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
                Text(
                  items.name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
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
                // Show a label for the current user
                if (items.name == currentUserName)
                  Text(
                    ' (You)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.blue, // You can adjust the color
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
