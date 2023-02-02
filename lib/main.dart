import 'package:demoprovider/provider/userdata_provider.dart';
import 'package:demoprovider/screen/home_page.dart';
import 'package:demoprovider/util/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'model/user_data.dart';

late Box userDataBox;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter<UserData>(UserDataAdapter());
  userDataBox = await Hive.openBox<UserData>(AppConstant.userBoxName);

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserDataProvider())
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

