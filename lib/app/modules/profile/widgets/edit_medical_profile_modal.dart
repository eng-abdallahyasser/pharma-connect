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
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Text(
                  'Edit Medical Profile',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
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
                      initialValue:
                          _bloodTypes.contains(_bloodTypeController.text)
                          ? _bloodTypeController.text
                          : null,
                      decoration: _inputDecoration('Blood Type', context),
                      items: _bloodTypes.map((type) {
                        return DropdownMenuItem(value: type, child: Text(type));
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
                            decoration: _inputDecoration(
                              'Height (cm)',
                              context,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _weightController,
                            decoration: _inputDecoration(
                              'Weight (kg)',
                              context,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Allergies
                    _buildListSection(
                      context,
                      'Allergies',
                      _allergies,
                      _allergyController,
                      (item) => _addItem(_allergies, _allergyController, item),
                      (item) => _removeItem(_allergies, item),
                    ),
                    const SizedBox(height: 16),

                    // Chronic Conditions
                    _buildListSection(
                      context,
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
                      context,
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
                      decoration: _inputDecoration(
                        'Insurance Provider',
                        context,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _insurancePolicyNumberController,
                      decoration: _inputDecoration(
                        'Insurance Policy Number',
                        context,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Notes
                    TextFormField(
                      controller: _notesController,
                      decoration: _inputDecoration('Notes', context),
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
                      side: BorderSide(color: Theme.of(context).dividerColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Save Changes',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
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
    );
  }

  Widget _buildListSection(
    BuildContext context,
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
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items.map((item) {
            return Chip(
              label: Text(item),
              onDeleted: () => onRemove(item),
              backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
              deleteIconColor: Theme.of(context).hintColor,
              labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            );
          }).toList(),
        ),
        if (items.isNotEmpty) const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                decoration: _inputDecoration('Add $title', context),
                onFieldSubmitted: (value) => onAdd(value),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () => onAdd(controller.text),
              icon: Icon(
                Icons.add_circle,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String label, BuildContext context) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Theme.of(context).dividerColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Theme.of(context).dividerColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }
}
