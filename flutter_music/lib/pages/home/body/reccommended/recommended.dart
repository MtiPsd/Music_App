import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../../../helpers/neumorphic_button.dart';
//****

class Reccommended extends StatefulWidget {
  const Reccommended({Key? key}) : super(key: key);

  @override
  State<Reccommended> createState() => _ReccommendedState();
}

class _ReccommendedState extends State<Reccommended> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      child: ListView(
        cacheExtent: 200,
        padding:
            const EdgeInsets.only(bottom: 70, top: 30, left: 30, right: 30),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          //****************** Audio Edit ******************

          // ignore: missing_required_param
          renderButton(
            padding: const EdgeInsets.all(0),
            height: 100,
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // ignore: missing_required_param
                renderButton(
                  width: 50,
                  height: 50,
                  padding: const EdgeInsets.only(left: 25, top: 25),
                  onTap: () {},
                  iconColor: Colors.grey,
                  icon: Icons.cut,
                  iconSize: 23,
                ),
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.only(left: 21),
                  child: Text(
                    "Audio Edit",
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 0.5,
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.bold,
                      color: Colors.white30,
                    ),
                  ),
                ),
              ],
            ),
            useButton: false,
          ),

          const SizedBox(width: 50),

          //****************** Top 50 ******************

          // ignore: missing_required_param
          renderButton(
            padding: const EdgeInsets.all(0),
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // ignore: missing_required_param
                renderButton(
                  width: 50,
                  height: 50,
                  padding: const EdgeInsets.only(left: 25, top: 25),
                  onTap: () {},
                  iconColor: Colors.grey,
                  icon: Icons.star,
                  iconSize: 23,
                ),
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.only(left: 21),
                  child: Text(
                    "Top 50",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: Colors.white30,
                    ),
                  ),
                ),
              ],
            ),
            useButton: false,
          ),

          const SizedBox(width: 50),

          //****************** Last Added ******************

          // ignore: missing_required_param
          renderButton(
            padding: const EdgeInsets.all(0),
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // ignore: missing_required_param
                renderButton(
                  width: 50,
                  height: 50,
                  padding: const EdgeInsets.only(left: 25, top: 25),
                  onTap: () {},
                  iconColor: Colors.grey,
                  icon: Icons.more_time,
                  iconSize: 25,
                ),
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.only(left: 21),
                  child: Text(
                    "Last Added",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: Colors.white30,
                    ),
                  ),
                ),
              ],
            ),
            useButton: false,
          ),

          //
        ],
      ),
    );
  }
}
