/// English Translations
///
/// This file contains all English text strings used throughout the app.
/// Each translation is organized by module/feature for easy maintenance.

const Map<String, String> enUS = {
  // ==================== Common ====================
  'common.ok': 'OK',
  'common.cancel': 'Cancel',
  'common.save': 'Save',
  'common.delete': 'Delete',
  'common.edit': 'Edit',
  'common.add': 'Add',
  'common.back': 'Back',
  'common.next': 'Next',
  'common.skip': 'Skip',
  'common.close': 'Close',
  'common.loading': 'Loading...',
  'common.error': 'Error',
  'common.success': 'Success',
  'common.warning': 'Warning',
  'common.info': 'Information',
  'common.no_data': 'No data available',
  'common.retry': 'Retry',
  'common.logout': 'Logout',
  'common.settings': 'Settings',

  // ==================== Navigation ====================
  'nav.home': 'Home',
  'nav.medicines': 'Medicines',
  'nav.pharmacies': 'Pharmacies',
  'nav.consultations': 'Consultations',
  'nav.chat': 'Chat',
  'nav.profile': 'Profile',
  'nav.notifications': 'Notifications',

  // ==================== Profile Module ====================
  'profile.title': 'Profile',
  'profile.edit_profile': 'Edit Profile',
  'profile.view_profile': 'View Profile',
  'profile.my_account': 'My Account',
  'profile.settings': 'Settings',
  'profile.help': 'Help & Support',

  // Account Menu Items
  'profile.medical_profile': 'Medical Profile',
  'profile.medical_profile_desc': 'View medical information',
  'profile.prescriptions': 'Prescription History',
  'profile.prescriptions_desc': 'View past prescriptions',
  'profile.family_members': 'Family Members',
  'profile.family_members_desc': 'Manage family members',
  'profile.saved_addresses': 'Saved Addresses',
  'profile.saved_addresses_desc': 'Manage delivery locations',
  'profile.order_history': 'Order History',
  'profile.order_history_desc': 'View past orders',

  // Settings Items
  'profile.notifications': 'Notifications',
  'profile.dark_mode': 'Dark Mode',
  'profile.language': 'Language',
  'profile.privacy_security': 'Privacy & Security',

  // Medical Profile Modal
  'profile.medical_info': 'Medical Information',
  'profile.blood_type': 'Blood Type',
  'profile.allergies': 'Allergies',
  'profile.chronic_conditions': 'Chronic Conditions',
  'profile.insurance': 'Insurance',
  'profile.emergency_contact': 'Emergency Contact',
  'profile.no_allergies': 'No known allergies',
  'profile.no_conditions': 'No chronic conditions',

  // Prescriptions Modal
  'profile.prescription_history': 'Prescription History',
  'profile.diagnosis': 'Diagnosis',
  'profile.doctor': 'Doctor',
  'profile.medicines': 'Medicines',
  'profile.date': 'Date',
  'profile.status': 'Status',
  'profile.active': 'Active',
  'profile.completed': 'Completed',
  'profile.download': 'Download',
  'profile.no_prescriptions': 'No prescriptions available',

  // Family Members Modal
  'profile.relation': 'Relation',
  'profile.age': 'Age',
  'profile.add_family_member': 'Add Family Member',
  'profile.no_family_members': 'No family members added',

  // ==================== Home Module ====================
  'home.welcome': 'Welcome',
  'home.location': 'Location',
  'home.location_value': 'Downtown, City',
  'home.search_placeholder': 'Search medicine or pharmacy...',
  'home.quick_actions': 'Quick Actions',
  'home.upload_prescription': 'Upload Prescription',
  'home.consult_doctor': 'Consult a Doctor',
  'home.my_medicine': 'My Medicine',
  'home.nearby_pharmacies': 'Nearby Pharmacies',
  'home.available_doctors': 'Available Doctors Now',
  'home.see_all': 'See All',
  'home.view_map': 'View Map',
  'home.health_tips': 'Health Tips',
  'home.view_all': 'View All',
  'home.stay_hydrated': 'Stay Hydrated',
  'home.stay_hydrated_desc':
      'Drink at least 8 glasses of water daily to maintain optimal health and energy levels.',
  'home.regular_exercise': 'Regular Exercise',
  'home.regular_exercise_desc':
      'Engage in at least 30 minutes of physical activity daily for better cardiovascular health.',
  'home.balanced_diet': 'Balanced Diet',
  'home.balanced_diet_desc':
      'Include fruits, vegetables, and whole grains in your daily meals for complete nutrition.',
  'home.categories': 'Categories',

  // ==================== Medicines Module ====================
  'medicines.title': 'Medicines',
  'medicines.search': 'Search medicines',
  'medicines.filter': 'Filter',
  'medicines.sort': 'Sort',
  'medicines.price': 'Price',
  'medicines.in_stock': 'In Stock',
  'medicines.out_of_stock': 'Out of Stock',
  'medicines.add_to_cart': 'Add to Cart',
  'medicines.quantity': 'Quantity',

  // ==================== Pharmacies Module ====================
  'pharmacies.title': 'Pharmacies',
  'pharmacies.near_me': 'Near Me',
  'pharmacies.open_now': 'Open Now',
  'pharmacies.closed': 'Closed',
  'pharmacies.distance': 'Distance',
  'pharmacies.delivery': 'Delivery Available',
  'pharmacies.rating': 'Rating',

  // ==================== Consultations Module ====================
  'consultations.title': 'Consultations',
  'consultations.doctors': 'Doctors',
  'consultations.book_consultation': 'Book Consultation',
  'consultations.upcoming': 'Upcoming',
  'consultations.past': 'Past',
  'consultations.speciality': 'Speciality',
  'consultations.available_times': 'Available Times',

  // ==================== Chat Module ====================
  'chat.title': 'Chat',
  'chat.messages': 'Messages',
  'chat.new_message': 'New Message',
  'chat.type_message': 'Type a message...',
  'chat.send': 'Send',
  'chat.no_messages': 'No messages yet',

  // ==================== Notifications Module ====================
  'notifications.title': 'Notifications',
  'notifications.no_notifications': 'No notifications',
  'notifications.mark_as_read': 'Mark as read',
  'notifications.clear_all': 'Clear all',

  // ==================== Upload Prescription Module ====================
  'upload.title': 'Upload Prescription',
  'upload.select_image': 'Select Image',
  'upload.take_photo': 'Take Photo',
  'upload.choose_file': 'Choose File',
  'upload.uploading': 'Uploading...',
  'upload.success': 'Prescription uploaded successfully',
  'upload.error': 'Failed to upload prescription',

  // ==================== Localization/Language ====================
  'language.title': 'Language',
  'language.english': 'English',
  'language.arabic': 'العربية',
  'language.select': 'Select Language',
  'language.changed': 'Language changed to English',
};
