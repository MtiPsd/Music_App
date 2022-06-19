import 'package:flutter_music/pages/home/home.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'routes/routes.dart';
import 'Bloc/bloc.dart';
//****

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Bloc>(
          create: (BuildContext context) => Bloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
//

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      title: 'Flutter Demo',
      theme: const NeumorphicThemeData(
        baseColor: Color(0xFFFFFFFF),
        lightSource: LightSource.topLeft,
        depth: 10,
      ),
      darkTheme: const NeumorphicThemeData(
        baseColor: Color.fromARGB(255, 38, 41, 46),
        lightSource: LightSource.topLeft,
        depth: 6,
      ),
      initialRoute: Routes.mainPage,
      routes: Routes.routes,
      themeMode: ThemeMode.dark,
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
      showSemanticsDebugger: false,
    );
  }
}
