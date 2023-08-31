part of 'image_picker_bloc.dart';

@immutable
class ImagePickerState {
  final XFile? image;
  const ImagePickerState({required this.image});
}

class ImagePickerInitial extends ImagePickerState {
  const ImagePickerInitial() : super(image: null);
}