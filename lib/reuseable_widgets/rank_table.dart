import 'package:flutter/material.dart';
import 'package:test_drive/utils/colour_utils.dart';

class RankTable extends StatelessWidget {
  final List<UserItem> userItems;

  const RankTable({Key? key, required this.userItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.9,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: ListView.builder(
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
                Container(
                  height: 25,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 5),
                      RotatedBox(
                        quarterTurns: 1,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: hexStringToColour("#FFBB00"),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        items.point.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                )
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
