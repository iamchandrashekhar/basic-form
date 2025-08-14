import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simpleform/src/repository.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final formFileds = ["First Name", "Last Name", "Mobile No."];
    Map<String, dynamic> formData = {};
    final formDataKey = ["first_name", "last_name", "mobile_no"];
    final theme = Theme.of(context);
    final repo = NetworkRepository();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("User Form"),
        backgroundColor: theme.colorScheme.primary.withAlpha(153),
      ),
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...List.generate(
              formFileds.length,
              (index) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      (value ?? "").isEmpty ? "Required" : null,
                  inputFormatters: [
                    formFileds[index].startsWith("Mobile")
                        ? FilteringTextInputFormatter.digitsOnly
                        : FilteringTextInputFormatter.allow(RegExp(r'[A-z ]*'))
                  ],
                  onChanged: (value) {
                    formData[formDataKey[index]] = value;
                  },
                  decoration: InputDecoration(
                    labelText: formFileds[index],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    int res = await repo.submitDetails(formData);
                    if (res == 200) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Submitted"),
                        ),
                      );
                    }
                  }
                },
                child: const Text("Submit"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
