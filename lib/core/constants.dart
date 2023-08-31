import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_record_bloc/bloc/view_records/view_records_bloc.dart';

const kTextColor = Colors.purple;

const kAppBarText = TextStyle(fontSize: 22, fontWeight: FontWeight.w400);

const kCenterText = TextStyle(fontSize: 30, fontWeight: FontWeight.w400);

const kScaffoldbgClr = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.purple, Colors.transparent],
  ),
);

const kTextStyle = TextStyle(fontSize: 16);

const kButtonTxtStyle = TextStyle(fontSize: 20);

const kHeight20 = SizedBox(height: 20);

const kHeight80 = SizedBox(height: 80);

kAddScreenDisplay(controller, keyboardType, text) {
  return TextFormField(
    onTapOutside: (_) {
      FocusManager.instance.primaryFocus?.unfocus();
    },
    controller: controller,
    textInputAction: TextInputAction.next,
    keyboardType: keyboardType,
    decoration:
        InputDecoration(border: const OutlineInputBorder(), hintText: text),
  );
}


 showAlertDialogue(BuildContext context, int index) {
    Widget cancelButton = ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text('Cancel'),
    );
    Widget okButton = ElevatedButton(
      onPressed: () {
        //deleteStudent(index);
        BlocProvider.of<ViewRecordsBloc>(context)
            .add(DeleteStudentRecord(index: index));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.purple,
            margin: EdgeInsets.all(20),
            behavior: SnackBarBehavior.floating,
            content: Text("Item deleted Successfully"),
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pop(context);
      },
      child: const Text('Ok'),
    );

    AlertDialog alert = AlertDialog(
      title: const Text('AlertDialogue'),
      content: const Text('Do you want to delete ?'),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }