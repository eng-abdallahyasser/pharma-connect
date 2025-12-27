import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../models/family_member_model.dart';
import '../controllers/profile_controller.dart';

class AddEditFamilyMemberModal extends StatefulWidget {
  final FamilyMemberModel? member;

  const AddEditFamilyMemberModal({super.key, this.member});

  @override
  State<AddEditFamilyMemberModal> createState() =>
      _AddEditFamilyMemberModalState();
}

class _AddEditFamilyMemberModalState extends State<AddEditFamilyMemberModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _middleNameController;
  late TextEditingController _mobileController;
  late TextEditingController _emailController;
  String? _birthDate;
  String? _gender;
  String? _relationship;
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(
      text: widget.member?.firstName ?? '',
    );
    _lastNameController = TextEditingController(
      text: widget.member?.lastName ?? '',
    );
    _middleNameController = TextEditingController(
      text: widget.member?.middleName ?? '',
    );
    _relationship = widget.member?.relationship?.toLowerCase();
    _mobileController = TextEditingController(
      text: widget.member?.mobile ?? '',
    );
    _emailController = TextEditingController(text: widget.member?.email ?? '');
    _birthDate = widget.member?.birthDate;
    _gender = widget.member?.gender;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _middleNameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.member == null
                    ? 'Add Family Member'
                    : 'Edit Family Member',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // Profile Photo
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 2,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: _imageFile != null
                              ? Image.file(
                                  File(_imageFile!.path),
                                  fit: BoxFit.cover,
                                )
                              : (widget.member?.photoUrl != null
                                    ? Image.network(
                                        widget.member!.photoUrl!,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                _buildFallbackAvatar(),
                                      )
                                    : _buildFallbackAvatar()),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Color(0xFF1A73E8),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name *'),
                validator: (v) => v?.isEmpty == true ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _middleNameController,
                decoration: const InputDecoration(labelText: 'Middle Name'),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name *'),
                validator: (v) => v?.isEmpty == true ? 'Required' : null,
              ),
              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                initialValue: _relationship,
                decoration: const InputDecoration(labelText: 'Relationship *'),
                items: ['principal', 'spouse', 'child', 'parent']
                    .map(
                      (r) => DropdownMenuItem(
                        value: r,
                        child: Text(r[0].toUpperCase() + r.substring(1)),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _relationship = v),
                validator: (v) => v == null ? 'Required' : null,
              ),
              const SizedBox(height: 12),

              // BirthDate Picker
              GestureDetector(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    setState(() {
                      _birthDate = date.toIso8601String().split('T')[0];
                    });
                  }
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: TextEditingController(text: _birthDate),
                    decoration: const InputDecoration(
                      labelText: 'Birth Date (YYYY-MM-DD)',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                initialValue: _gender,
                decoration: const InputDecoration(labelText: 'Gender'),
                items: ['male', 'female']
                    .map(
                      (g) => DropdownMenuItem(
                        value: g,
                        child: Text(g[0].toUpperCase() + g.substring(1)),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _gender = v),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _mobileController,
                decoration: const InputDecoration(labelText: 'Mobile'),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 24),
              ElevatedButton(onPressed: _submit, child: const Text('Save')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackAvatar() {
    return Container(
      color: Colors.grey[200],
      child: const Center(
        child: Icon(Icons.person, color: Colors.grey, size: 40),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState?.validate() == true) {
      final controller = Get.find<ProfileController>();

      final newMember = FamilyMemberModel(
        id: widget.member?.id, // Keep ID if editing
        firstName: _firstNameController.text,
        middleName: _middleNameController.text.isEmpty
            ? null
            : _middleNameController.text,
        lastName: _lastNameController.text,
        relationship: _relationship,
        birthDate: _birthDate,
        gender: _gender,
        mobile: _mobileController.text.isEmpty ? null : _mobileController.text,
        email: _emailController.text.isEmpty ? null : _emailController.text,
        photoUrl: widget.member?.photoUrl,
      );

      File? imageFile = _imageFile != null ? File(_imageFile!.path) : null;

      if (widget.member == null) {
        controller.createFamilyMember(newMember, imageFile: imageFile);
      } else {
        controller.updateFamilyMemberDetails(
          widget.member!.id!,
          newMember,
          imageFile: imageFile,
        );
      }
    }
  }
}
