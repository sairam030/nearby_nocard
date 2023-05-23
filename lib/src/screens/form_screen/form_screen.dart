import 'package:nearby_nocard/app_exports.dart';

class FormScreen extends GetView<FormController> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nocard Form'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                controller: controller.nameController,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone number'),
                controller: controller.phoneController,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address'),
                controller: controller.addressController,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Role'),
                controller: controller.roleController,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter a role';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Mail'),
                controller: controller.mailController,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter a valid mail';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    controller.submit();
                  }
                },
                child: const Text('Submit'),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
