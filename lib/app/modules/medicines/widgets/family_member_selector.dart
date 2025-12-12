import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/family_medicines_model.dart';

// Family member selector widget for switching between family members
class FamilyMemberSelector extends StatelessWidget {
  final List<FamilyMedicinesModel> familyMembers;
  final FamilyMedicinesModel? selectedMember;
  final ValueChanged<FamilyMedicinesModel> onMemberSelected;
  final VoidCallback? onAddMemberPressed;

  const FamilyMemberSelector({
    super.key,
    required this.familyMembers,
    required this.selectedMember,
    required this.onMemberSelected,
    this.onAddMemberPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemCount: familyMembers.length + 1, // +1 for add button
        itemBuilder: (context, index) {
          // Add member button
          if (index == familyMembers.length) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GestureDetector(
                onTap: onAddMemberPressed,
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 2,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(13),
                        blurRadius: 4,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A73E8).withAlpha(26),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Color(0xFF1A73E8),
                          size: 24,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'medicines.add_member'.tr,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          // Family member button
          final member = familyMembers[index];
          final isSelected = selectedMember?.id == member.id;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: GestureDetector(
              onTap: () => onMemberSelected(member),
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF1A73E8) : Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(isSelected ? 38 : 13),
                      blurRadius: 4,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Avatar
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? Colors.white.withAlpha(77)
                              : Colors.grey[300]!,
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: member.imageUrl != null
                            ? Image.network(
                                member.imageUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[300],
                                    child: Center(
                                      child: Text(
                                        member.initials,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Container(
                                color: Colors.grey[300],
                                child: Center(
                                  child: Text(
                                    member.initials,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Name
                    Text(
                      member.name,
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected ? Colors.white : Colors.grey[800],
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Relation
                    Text(
                      'medicines.relation_${member.relation.toLowerCase()}'.tr,
                      style: TextStyle(
                        fontSize: 10,
                        color: isSelected
                            ? Colors.white.withAlpha(204)
                            : Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),

                    // Medicine count badge
                    if (member.medicinesCount > 0) ...[
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.white.withAlpha(51)
                              : const Color(0xFF1A73E8).withAlpha(26),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${member.medicinesCount} ${'medicines.medicine_${member.medicinesCount == 1 ? 'singular' : 'plural'}'.tr}',
                          style: TextStyle(
                            fontSize: 9,
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF1A73E8),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
