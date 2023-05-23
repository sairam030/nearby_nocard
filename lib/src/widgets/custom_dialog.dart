import 'package:nearby_nocard/app_exports.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final VoidCallback? onTap;

  const CustomDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64.0, color: Colors.green),
            const SizedBox(height: 16.0),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                onTap?.call();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
