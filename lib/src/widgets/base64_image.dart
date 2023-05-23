import 'package:nearby_nocard/app_exports.dart';

class Base64Image extends StatelessWidget {
  final String? base64;

  const Base64Image({required Key? key, required this.base64})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (base64!.isEmpty || base64 == null) {
      return Container();
    }

    final bytes = base64Decode(base64!);

    return Image.memory(
      bytes,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }
}
