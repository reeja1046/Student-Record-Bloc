part of 'image_picker_bloc.dart';

@immutable
abstract class ImagePickerEvent {}

class ChooseImage extends ImagePickerEvent {}

class RemoveImage extends ImagePickerEvent {}