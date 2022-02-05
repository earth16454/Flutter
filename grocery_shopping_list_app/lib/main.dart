import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'model/one.dart';
import 'model/send.dart';
import 'package:provider/provider.dart';
import 'providers/sublist_provider.dart';
import 'screen/main_screen.dart';
import 'screen/add_list_screen.dart';
import 'screen/page2.dart';
import 'screen/add_page2.dart';

main() async {
  // Initialize hive
  await Hive.initFlutter();
  // Registering the adapter
  Hive.registerAdapter(TodoAdapter());
  // Open the peopleBox
  await Hive.openBox('ListBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return NameListProvider();
        })
      ],
      child: MaterialApp(
        routes: {
          AddScreen.routeName: (context) => const AddScreen(),
          //Page3.routeName: (context) => const Page3(),
          //Page2.routeName: (context) => const Page2(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == Page2.routeName) {
            final args = settings.arguments as sendIndex;
            return MaterialPageRoute(
              builder: (context) {
                return Page2(title: args.title);
              },
            );
          }
          if (settings.name == AddPage2.routeName) {
            final args = settings.arguments as sendIndex;
            return MaterialPageRoute(
              builder: (context) {
                return AddPage2(title: args.title);
              },
            );
          }

          return null;
        },
        debugShowCheckedModeBanner: false,
        title: 'Grocery Shopping List',
        theme: ThemeData(primarySwatch: Colors.green),
        home: const MyHomePage(),
      ),
    );
  }
}
