import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
//****

class IntroPages extends StatefulWidget {
  const IntroPages({Key? key}) : super(key: key);

  @override
  State<IntroPages> createState() => _IntroPagesState();
}

class _IntroPagesState extends State<IntroPages> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();

    slides.add(
      Slide(
        title: "PICK YOUR OWN MUSIC AND ENJOY",
        description: "Browse your music in any format then tab play!",
        // pathImage: "images/photo_eraser.png",
        backgroundColor: const Color.fromARGB(255, 38, 41, 46),
      ),
    );
    slides.add(
      Slide(
        title: "MESMERIZING UI",
        description:
            "Feel neumorphic design and enjoy while listening to the music",
        // pathImage: "images/photo_pencil.png",
        backgroundColor: const Color.fromARGB(255, 38, 41, 46),
      ),
    );
  }

  List<Widget> _renderCustomTabs() {
    List<Widget> tabs = [];
    for (var i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];

      tabs.add(
        Scaffold(
          body: Center(
            child: SizedBox(
              height: 300,
              width: 300,
              child: Neumorphic(
                style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(25),
                  ),
                  depth: 3,
                  intensity: 0.5,
                  shadowDarkColor: Colors.black,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        currentSlide.title!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 25,
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          height: 1.3,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        currentSlide.description!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: "Quicksand",
                          color: Color.fromARGB(153, 255, 255, 255),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    return tabs;
  }

  void onDonePress() {
    Navigator.pushNamed(context, "homePage");
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: slides,
      onDonePress: onDonePress,
      listCustomTabs: _renderCustomTabs(),
      colorActiveDot: Colors.green,
      doneButtonStyle: ElevatedButton.styleFrom(
        primary: const Color.fromARGB(255, 186, 58, 49),
        textStyle: const TextStyle(
          fontFamily: "Quicksand",
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
      isScrollable: true,
      showNextBtn: false,
      showPrevBtn: false,
      showSkipBtn: false,
    );
  }
}
