import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/bloc/category_bloc/category_bloc.dart';
import 'package:shopping_app/bloc/product_bloc/product_bloc.dart';
import 'package:shopping_app/firebase/firestore_service.dart';
import 'package:shopping_app/screen/user_module/dashboard_screen.dart';
import 'package:shopping_app/screen/login_screen.dart';
import 'package:shopping_app/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CategoryBloc(FirestoreService())),
        BlocProvider(create: (_) => ProductBloc(FirestoreService())),
      ],
      child: MaterialApp(
        // theme: ThemeData(
        //   // brightness: Brightness.dark,
        //   // scaffoldBackgroundColor: Colors.transparent,
        // ),
        debugShowCheckedModeBanner: false,
        title: 'Flutter',
        home: SplashScreen(),
      ),
    );
  }
}
