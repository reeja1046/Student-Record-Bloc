// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//  import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:student_record_bloc/bloc/image_picker/image_picker_bloc.dart';
// import 'package:student_record_bloc/bloc/search_record/search_record_bloc.dart';
// import 'package:student_record_bloc/bloc/view_records/view_records_bloc.dart';
// import 'package:student_record_bloc/database/models/db_models.dart';
// import 'package:student_record_bloc/screens/screen_splash.dart';

// // import 'database/functions/db_functions.dart';

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Hive.initFlutter();

//   // if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
//   Hive.registerAdapter(StudentModelAdapter());
//   //}
//   // await openStudentBox();
//   await Hive.openBox<StudentModel>('student_db');
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) {
//             return ViewRecordsBloc();
//           },
//         ),
//         BlocProvider(
//           create: (context) {
//             return SearchRecordBloc();
//           },
//         ),
//         BlocProvider(
//           create: (context) {
//             return ImagePickerBloc();
//           },
//         ),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Student Record',
//         theme: ThemeData(
//           primarySwatch: Colors.purple,
//         ),
//         home: const SplashScreen(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_record_bloc/bloc/image_picker/image_picker_bloc.dart';
import 'package:student_record_bloc/bloc/search_record/search_record_bloc.dart';
import 'package:student_record_bloc/bloc/view_records/view_records_bloc.dart';
import 'package:student_record_bloc/database/functions/db_functions.dart';
import 'package:student_record_bloc/database/models/db_models.dart';
import 'package:student_record_bloc/screens/screen_splash.dart';

Future main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // log('first working');
  // await Hive.initFlutter();
  // log('second working');

  // Hive.registerAdapter(StudentModelAdapter());
  // log('3 working');

  // // Open the student_db box
  // await Hive.openBox<StudentModel>('student_db');
  // log('4 working');

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(StudentModelAdapter());
  //await Hive.openBox<StudentModel>('student_db');
  await openStudentBox();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ViewRecordsBloc>(
          create: (context) => ViewRecordsBloc(),
        ),
        BlocProvider<SearchRecordBloc>(
          create: (context) => SearchRecordBloc(),
        ),
        BlocProvider<ImagePickerBloc>(
          create: (context) => ImagePickerBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Student Record',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
