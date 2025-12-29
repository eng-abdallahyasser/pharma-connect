import 'package:flutter/material.dart';
import '../models/family_member_model.dart';

// Family members modal widget displaying family members list
class FamilyMembersModal extends StatelessWidget {
  final List<FamilyMemberModel> familyMembers;
  final VoidCallback onClose;
  final VoidCallback? onAddPressed;
  final Function(FamilyMemberModel)? onEditPressed;
  final Function(FamilyMemberModel)? onDeletePressed;
  final bool isLoading;

  const FamilyMembersModal({
    super.key,
    required this.familyMembers,
    required this.onClose,
    this.onAddPressed,
    this.onEditPressed,
    this.onDeletePressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Modal header with icon, title, and add button
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                    child: Row(
                      children: [
                        // Green people icon background
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.secondary.withAlpha(25),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.people,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Title
                        Expanded(
                          child: Text(
                            'Family Members',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),

                        // Add button
                        GestureDetector(
                          onTap: onAddPressed,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 14,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Add',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Family members list
                  isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : familyMembers.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Center(child: Text('No family members found')),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            children: familyMembers.map((member) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    // Family member avatar
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Theme.of(context).dividerColor,
                                          width: 2,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(24),
                                        child: Image.network(
                                          member.photoUrl ?? '',
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                // Fallback avatar with initials
                                                return Container(
                                                  color: Theme.of(
                                                    context,
                                                  ).disabledColor.withAlpha(50),
                                                  child: Center(
                                                    child: Text(
                                                      member.initials,
                                                      style: TextStyle(
                                                        color: Theme.of(
                                                          context,
                                                        ).colorScheme.onSurface,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),

                                    // Family member information
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Name and edit button
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // Member name
                                                    Text(
                                                      member.displayName,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge
                                                          ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                    const SizedBox(height: 2),

                                                    // Relation
                                                    Text(
                                                      member.relationship ??
                                                          'N/A',
                                                      style: Theme.of(
                                                        context,
                                                      ).textTheme.bodySmall,
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              // Edit button
                                              GestureDetector(
                                                onTap: () =>
                                                    onEditPressed?.call(member),
                                                child: Icon(
                                                  Icons.edit,
                                                  size: 16,
                                                  color: Theme.of(
                                                    context,
                                                  ).hintColor,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              // Delete button
                                              GestureDetector(
                                                onTap: () => onDeletePressed
                                                    ?.call(member),
                                                child: Icon(
                                                  Icons.delete,
                                                  size: 16,
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.error,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),

                                          if (member.birthDate != null)
                                            Text(
                                              'Born: ${member.birthDate}',
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodySmall,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                ],
              ),
            ),
          ),
          // Close button
          Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onClose,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Close',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
