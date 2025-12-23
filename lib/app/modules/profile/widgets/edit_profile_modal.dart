import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import 'package:intl/intl.dart';

class EditProfileModal extends StatefulWidget {
  final UserModel user;
  final bool notificationsEnabled;
  final Function(Map<String, dynamic> data) onSave;

  const EditProfileModal({
    super.key,
    required this.user,
    required this.notificationsEnabled,
    required this.onSave,
  });

  @override
  State<EditProfileModal> createState() => _EditProfileModalState();
}

class _EditProfileModalState extends State<EditProfileModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _middleNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _countryCodeController;
  late TextEditingController _nationalIdController;

  DateTime? _birthDate;
  String _gender = 'male';

  @override
  void initState() {
    super.initState();
    final names = widget.user.name.split(' ');
    _firstNameController = TextEditingController(
      text: names.isNotEmpty ? names[0] : '',
    );
    _middleNameController = TextEditingController(
      text: names.length > 2 ? names[1] : '',
    );
    _lastNameController = TextEditingController(
      text: names.length > 1 ? names.last : '',
    );
    _emailController = TextEditingController(text: widget.user.email);
    _countryCodeController = TextEditingController(
      text: 'eg',
    ); // Default or fetch if available
    _nationalIdController = TextEditingController();

    // Set default birthdate or parse if available in user model (not currently in UserModel)
    _birthDate = DateTime(2000, 7, 10);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _countryCodeController.dispose();
    _nationalIdController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _birthDate) {
      setState(() {
        _birthDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Edit Profile',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Get.back(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Name Fields
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _firstNameController,
                            label: 'First Name',
                            validator: (v) => v == null || v.trim().isEmpty
                                ? 'First Name is required'
                                : null,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildTextField(
                            controller: _middleNameController,
                            label: 'Middle Name',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _lastNameController,
                      label: 'Last Name',
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'Last Name is required'
                          : null,
                    ),

                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _emailController,
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) =>
                          !GetUtils.isEmail(v ?? '') ? 'Invalid email' : null,
                    ),

                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _nationalIdController,
                      label: 'National ID',
                      validator: (v) =>
                          v?.isNotEmpty == true && (v!.length != 14)
                          ? 'National ID must be 14 digits'
                          : null,
                      keyboardType: TextInputType.number,
                    ),

                    // const SizedBox(height: 10),
                    // _buildTextField(
                    //   controller: _countryCodeController,
                    //   label: 'Country Code',
                    // ),
                    const SizedBox(height: 20),

                    // Birth Date
                    InkWell(
                      onTap: () => _selectDate(context),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Birth Date',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        child: Text(
                          _birthDate != null
                              ? DateFormat('yyyy-MM-dd').format(_birthDate!)
                              : 'Select Date',
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Gender
                    DropdownButtonFormField<String>(
                      initialValue: _gender,
                      decoration: const InputDecoration(
                        labelText: 'Gender',
                        border: OutlineInputBorder(),
                      ),
                      items: ['male', 'female'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value.capitalizeFirst!),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _gender = newValue!;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    // Notifications Toggle removed as per request
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
          // Save Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final data = <String, dynamic>{};

                  if (_firstNameController.text.isNotEmpty) {
                    data["firstName"] = _firstNameController.text;
                  }
                  if (_middleNameController.text.isNotEmpty) {
                    data["middleName"] = _middleNameController.text;
                  }
                  if (_lastNameController.text.isNotEmpty) {
                    data["lastName"] = _lastNameController.text;
                  }
                  if (_emailController.text.isNotEmpty) {
                    data["email"] = _emailController.text;
                  }
                  if (_birthDate != null) {
                    data["birthDate"] = _birthDate?.toUtc().toIso8601String();
                  }
                  if (_countryCodeController.text.isNotEmpty) {
                    data["countryCode"] = _countryCodeController.text;
                  }

                  if (_nationalIdController.text.isNotEmpty) {
                    data["nationalId"] = _nationalIdController.text;
                  }

                  data["gender"] = _gender;

                  widget.onSave(data);
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Update Profile',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}
