import 'package:flutter/material.dart';
import 'package:test_drive/utils/colour_utils.dart';

class RankTable extends StatelessWidget {
  final List<UserItem> userItems;

  const RankTable({Key? key, required this.userItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
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
                  backgroundImage: AssetImage(items.image),
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
