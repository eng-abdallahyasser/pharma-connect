# Localization Implementation Checklist

## Project Overview
Pharma Connect app with multi-language support (English & Arabic)

## Completion Status

### ✅ Completed
- [x] **Localization System Setup**
  - [x] LocalizationService created
  - [x] Translation files (en_us.dart, ar_ar.dart)
  - [x] AppTranslations class implemented
  - [x] Main.dart updated with localization config
  - [x] flutter_localizations dependency added
  - [x] Language selection dialog created

- [x] **Profile Module** (Reference Implementation)
  - [x] All text keys added to en_us.dart
  - [x] All text keys added to ar_ar.dart
  - [x] Menu items use translations
  - [x] Settings items use translations
  - [x] Language switching implemented
  - [x] RTL support prepared
  - [x] Modal dialogs use translations

### 🔄 To Do - By Priority

#### Priority 1: Core Navigation (ASAP)
- [x] **Home Module** (`lib/app/modules/home/`) ✅ COMPLETE
  - [x] Add translation keys to locale files
  - [x] Update home_view.dart
  - [x] Update home_controller.dart
  - [x] Test language switching
  - Estimated effort: 2-3 hours

- [ ] **Navigation Module** (`lib/app/modules/navigation/`)
  - [ ] Add bottom navigation labels
  - [ ] Update navigation translations
  - [ ] Test all nav items
  - [ ] Estimated effort: 1-2 hours

#### Priority 2: Main Features (Week 1)
- [ ] **Medicines Module** (`lib/app/modules/medicines/`)
  - [ ] Search, filter, sort labels
  - [ ] Product info translations
  - [ ] Test RTL support
  - [ ] Estimated effort: 3-4 hours

- [ ] **Pharmacies Module** (`lib/app/modules/pharmacies/`)
  - [ ] Location, delivery labels
  - [ ] Rating, hours translations
  - [ ] Map-related text
  - [ ] Estimated effort: 2-3 hours

- [ ] **Consultations Module** (`lib/app/modules/consultations/`)
  - [ ] Doctor info translations
  - [ ] Booking labels
  - [ ] Schedule text
  - [ ] Estimated effort: 2-3 hours

#### Priority 3: Secondary Features (Week 2)
- [ ] **Chat Module** (`lib/app/modules/chat/`)
  - [ ] Message labels
  - [ ] Timestamp formats
  - [ ] Status indicators
  - [ ] Estimated effort: 2-3 hours

- [ ] **Notifications Module** (`lib/app/modules/notifications/`)
  - [ ] Notification types
  - [ ] Action labels
  - [ ] Time formats
  - [ ] Estimated effort: 1-2 hours

- [ ] **Upload Prescription Module** (`lib/app/modules/upload_prescription/`)
  - [ ] Form labels
  - [ ] File upload text
  - [ ] Success/error messages
  - [ ] Estimated effort: 1-2 hours

## Implementation Workflow

For each module, follow these steps:

### Step 1: Identify All Strings ⚙️
```
- [ ] List all user-facing text
- [ ] Identify error messages
- [ ] Find dynamic messages
- [ ] Note any formatted strings
```

### Step 2: Add Translation Keys 🔤
```
- [ ] Add to en_us.dart (English)
- [ ] Add to ar_ar.dart (Arabic)
- [ ] Follow naming convention: module.feature.element
- [ ] Group by logical sections
```

### Step 3: Update Code 💻
```
- [ ] Replace hardcoded strings in controllers
- [ ] Replace hardcoded strings in views
- [ ] Use getTranslation() in controllers
- [ ] Use .tr in widgets
```

### Step 4: Handle RTL 🔄
```
- [ ] Check text alignment
- [ ] Check layout direction
- [ ] Test with Arabic language
- [ ] Fix any overflow issues
```

### Step 5: Test & Verify ✅
```
- [ ] Switch to English - verify display
- [ ] Switch to Arabic - verify display
- [ ] Check all screens
- [ ] Verify no hardcoded text remains
- [ ] Test on different screen sizes
```

### Step 6: Document 📝
```
- [ ] Update module documentation
- [ ] Note any special translation needs
- [ ] Add examples if needed
- [ ] Update this checklist
```

## Key Files Reference

### Core Localization Files
- `lib/app/locales/en_us.dart` - English translations
- `lib/app/locales/ar_ar.dart` - Arabic translations
- `lib/app/locales/translations.dart` - Translation helper
- `lib/app/services/localization_service.dart` - Language service

### Documentation
- `lib/app/LOCALIZATION_SETUP_GUIDE.md` - Complete setup guide
- `lib/app/HOW_TO_ADD_TRANSLATIONS.md` - Step-by-step guide
- This file - Implementation checklist

### Example Implementation
- `lib/app/modules/profile/` - Reference module
- `lib/app/widgets/language_selection_widget.dart` - Language picker

## Translation Key Template

When adding keys, use this template for consistency:

```dart
// ==================== [Module Name] ====================
'[module].[feature].[element]': '[English text]',

// Examples:
'medicines.search.placeholder': 'Search medicines',
'medicines.search.no_results': 'No medicines found',
'medicines.filter.by_price': 'Filter by price',
```

## Testing Checklist for Each Module

Before marking a module as complete:

```
[ ] English language displays correctly
[ ] Arabic language displays correctly
[ ] All text uses translation keys (no hardcoding)
[ ] RTL layout is correct in Arabic
[ ] No text overflow or clipping
[ ] Buttons and labels are translatable
[ ] Error messages are translatable
[ ] Success messages are translatable
[ ] Dialogs and modals are translatable
[ ] All screens tested with both languages
```

## Known Issues & Notes

### Current Status
- ✅ Core localization system works
- ✅ Profile module fully localized
- ✅ Home module fully localized
- ⚠️ Other modules still have hardcoded text
- ⚠️ SharedPreferences not yet integrated for persistence

### TO DO Before Production
- [ ] Add SharedPreferences for language persistence
- [ ] Test on real devices (especially RTL)
- [ ] Add more languages if needed
- [ ] Optimize text for translation (avoid concatenation)
- [ ] Add date/number formatting for locales
- [ ] Add pluralization support

## Progress Tracking

### Week Starting [Date]
- [ ] Navigation & Home modules
- [ ] Core features (Medicines, Pharmacies, Consultations)

### Week 2
- [ ] Secondary features (Chat, Notifications, Upload)
- [ ] Final testing and refinement

### Week 3
- [ ] Production readiness review
- [ ] User testing with Arabic speakers
- [ ] Final adjustments

## Quick Stats

| Item | Count |
|------|-------|
| Supported Languages | 2 (EN, AR) |
| Translation Keys | ~120+ (and growing) |
| Modules to Localize | 9 total |
| Completed Modules | 1 (Profile) |
| Remaining Modules | 8 |
| Estimated Total Time | 20-25 hours |

## Resources for Translators

### Arabic Translation Guidelines
1. Keep RTL direction in mind
2. Some English words may not translate directly
3. Use formal Arabic (Fusha) for professional terms
4. Keep button labels concise
5. Test on actual RTL devices

### Translation Review Checklist
- [ ] All keys translated (no missing)
- [ ] Translations are accurate
- [ ] No code/variables left in translations
- [ ] Proper formatting maintained
- [ ] Special characters handled correctly

## Contact & Questions

- **Localization Service**: `LocalizationService`
- **Translation Helper**: `getTranslation()` function
- **Language Widget**: `LanguageSelectionDialog`
- **Reference Module**: Profile module

## Notes

- Every module should be independent of localization system
- Use composition pattern for translation management
- Keep translations close to code
- Document any special formatting needs
- Test RTL thoroughly before release

---

**Last Updated**: December 11, 2025
**Next Review**: After each module completion
