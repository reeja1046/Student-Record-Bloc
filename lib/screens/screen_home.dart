import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_record_bloc/screens/screen_add.dart';
import 'package:student_record_bloc/screens/screen_view.dart';

import '../bloc/image_picker/image_picker_bloc.dart';
import '../core/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Home',
          style: kAppBarText,
        ),
      ),
      body: Container(
        decoration: kScaffoldbgClr,
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<ImagePickerBloc>(context)
                        .add(RemoveImage());
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AddRecordScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Add Records',
                    style: kTextStyle,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ViewRecordsScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'View Records',
                    style: kTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
