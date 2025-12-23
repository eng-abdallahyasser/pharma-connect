import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/medical_profile_model.dart';
import '../controllers/profile_controller.dart';

class EditMedicalProfileModal extends StatefulWidget {
  final MedicalProfile? medicalProfile;

  const EditMedicalProfileModal({super.key, this.medicalProfile});

  @override
  State<EditMedicalProfileModal> createState() =>
      _EditMedicalProfileModalState();
}

class _EditMedicalProfileModalState extends State<EditMedicalProfileModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _bloodTypeController;
  late TextEditingController _heightController;
  late TextEditingController _weightController;
  late TextEditingController _insuranceProviderController;
  late TextEditingController _insurancePolicyNumberController;
  late TextEditingController _notesController;

  List<String> _allergies = [];
  List<String> _chronicConditions = [];
  List<String> _currentMedications = [];

  final _allergyController = TextEditingController();
  final _conditionController = TextEditingController();
  final _medicationController = TextEditingController();

  final List<String> _bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  @override
  void initState() {
    super.initState();
    final profile = widget.medicalProfile;
    _bloodTypeController = TextEditingController(text: profile?.bloodType);
    _heightController = TextEditingController(
      text: profile?.height.toString() ?? '',
    );
    _weightController = TextEditingController(
      text: profile?.weight.toString() ?? '',
    );
    _insuranceProviderController = TextEditingController(
      text: profile?.insuranceProvider,
    );
    _insurancePolicyNumberController = TextEditingController(
      text: profile?.insurancePolicyNumber,
    );
    _notesController = TextEditingController(text: profile?.notes);

    _allergies = List.from(profile?.allergies ?? []);
    _chronicConditions = List.from(profile?.chronicConditions ?? []);
    _currentMedications = List.from(profile?.currentMedications ?? []);
  }

  @override
  void dispose() {
    _bloodTypeController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _insuranceProviderController.dispose();
    _insurancePolicyNumberController.dispose();
    _notesController.dispose();
    _allergyController.dispose();
    _conditionController.dispose();
    _medicationController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final updatedProfile = MedicalProfile(
        id: widget.medicalProfile?.id ?? '', // ID should ideally be handled
        userId:
            widget.medicalProfile?.userId ??
            '', // UserID should ideally be handled
        bloodType: _bloodTypeController.text,
        allergies: _allergies,
        chronicConditions: _chronicConditions,
        currentMedications: _currentMedications,
        height: num.tryParse(_heightController.text) ?? 0,
        weight: num.tryParse(_weightController.text) ?? 0,
        insuranceProvider: _insuranceProviderController.text,
        insurancePolicyNumber: _insurancePolicyNumberController.text,
        notes: _notesController.text,
        metadata:
            widget.medicalProfile?.metadata ??
            MedicalProfileMetadata(createdAt: '', version: 0),
      );

      Get.find<ProfileController>().updateMedicalProfile(updatedProfile);
    }
  }

  void _addItem(
    List<String> list,
    TextEditingController controller,
    String item,
  ) {
    if (item.isNotEmpty && !list.contains(item)) {
      setState(() {
        list.add(item);
        controller.clear();
      });
    }
  }

  void _removeItem(List<String> list, String item) {
    setState(() {
      list.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 700),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  const Text(
                    'Edit Medical Profile',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // Form
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Blood Type
                      DropdownButtonFormField<String>(
                        value: _bloodTypes.contains(_bloodTypeController.text)
                            ? _bloodTypeController.text
                            : null,
                        decoration: _inputDecoration('Blood Type'),
                        items: _bloodTypes.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            _bloodTypeController.text = value;
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      // Height & Weight
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _heightController,
                              decoration: _inputDecoration('Height (cm)'),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _weightController,
                              decoration: _inputDecoration('Weight (kg)'),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Allergies
                      _buildListSection(
                        'Allergies',
                        _allergies,
                        _allergyController,
                        (item) =>
                            _addItem(_allergies, _allergyController, item),
                        (item) => _removeItem(_allergies, item),
                      ),
                      const SizedBox(height: 16),

                      // Chronic Conditions
                      _buildListSection(
                        'Chronic Conditions',
                        _chronicConditions,
                        _conditionController,
                        (item) => _addItem(
                          _chronicConditions,
                          _conditionController,
                          item,
                        ),
                        (item) => _removeItem(_chronicConditions, item),
                      ),
                      const SizedBox(height: 16),

                      // Current Medications
                      _buildListSection(
                        'Current Medications',
                        _currentMedications,
                        _medicationController,
                        (item) => _addItem(
                          _currentMedications,
                          _medicationController,
                          item,
                        ),
                        (item) => _removeItem(_currentMedications, item),
                      ),
                      const SizedBox(height: 16),

                      // Insurance
                      TextFormField(
                        controller: _insuranceProviderController,
                        decoration: _inputDecoration('Insurance Provider'),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _insurancePolicyNumberController,
                        decoration: _inputDecoration('Insurance Policy Number'),
                      ),
                      const SizedBox(height: 16),

                      // Notes
                      TextFormField(
                        controller: _notesController,
                        decoration: _inputDecoration('Notes'),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(height: 1),

            // Footer
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: Colors.grey[300]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _save,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A73E8),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Save Changes',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListSection(
    String title,
    List<String> items,
    TextEditingController controller,
    Function(String) onAdd,
    Function(String) onRemove,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items.map((item) {
            return Chip(
              label: Text(item),
              onDeleted: () => onRemove(item),
              backgroundColor: Colors.grey[100],
              deleteIconColor: Colors.grey[600],
              labelStyle: TextStyle(color: Colors.grey[800], fontSize: 12),
            );
          }).toList(),
        ),
        if (items.isNotEmpty) const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                decoration: _inputDecoration('Add $title'),
                onFieldSubmitted: (value) => onAdd(value),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () => onAdd(controller.text),
              icon: const Icon(Icons.add_circle, color: Color(0xFF1A73E8)),
            ),
          ],
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF1A73E8), width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }
}
