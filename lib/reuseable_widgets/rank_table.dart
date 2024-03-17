import 'package:flutter/material.dart';

class RankTable extends StatelessWidget {
  final List<UserItem> userItems;

  const RankTable({Key? key, required this.userItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.only(top: 15), // Added padding here
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: userItems.length,
        itemBuilder: (context, index) {
          final items = userItems[index];
          return Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 15),
            child: Row(
              children: [
                Text(
                  items.rank.toString(),
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
                  items.point.toString(), // Removed from Container
                  style: const TextStyle( // Added direct styling here
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
  final int rank;
  final String image;
  final String name;
  final int point;

  UserItem({
    required this.rank,
    required this.image,
    required this.name,
    required this.point,
  });
}


class UserCard extends StatelessWidget {
  final int rank;
  final String image;
  final String name;
  final int point;

  const UserCard({
    Key? key,
    required this.rank,
    required this.image,
    required this.name,
    required this.point,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Text(
              rank.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 15),
            CircleAvatar(
              radius: 25,
              backgroundImage: image.isNotEmpty
                  ? AssetImage(image)
                  : AssetImage("assets/images/user.png"), // Default image path
            ),
            const SizedBox(width: 15),
            Text(
              name,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Text(
              point.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
