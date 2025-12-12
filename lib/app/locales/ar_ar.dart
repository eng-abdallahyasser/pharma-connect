/// Arabic Translations
///
/// This file contains all Arabic text strings used throughout the app.
/// Each translation is organized by module/feature for easy maintenance.

const Map<String, String> arAR = {
  // ==================== Common ====================
  'common.ok': 'حسناً',
  'common.cancel': 'إلغاء',
  'common.save': 'حفظ',
  'common.delete': 'حذف',
  'common.edit': 'تعديل',
  'common.add': 'إضافة',
  'common.back': 'رجوع',
  'common.next': 'التالي',
  'common.skip': 'تخطي',
  'common.close': 'إغلاق',
  'common.loading': 'جاري التحميل...',
  'common.error': 'خطأ',
  'common.success': 'نجح',
  'common.warning': 'تحذير',
  'common.info': 'معلومات',
  'common.no_data': 'لا توجد بيانات',
  'common.retry': 'إعادة المحاولة',
  'common.logout': 'تسجيل الخروج',
  'common.settings': 'الإعدادات',

  // ==================== Navigation ====================
  'nav.home': 'الرئيسية',
  'nav.medicines': 'الأدوية',
  'nav.pharmacies': 'الصيدليات',
  'nav.consultations': 'الاستشارات',
  'nav.chat': 'الدردشة',
  'nav.profile': 'الملف الشخصي',
  'nav.notifications': 'التنبيهات',
  'nav.upload_prescription': 'تحميل الوصفة الطبية',
  'nav.upload_description': 'اختر كيفية تحميل وصفتك الطبية',
  'nav.take_photo': 'التقط صورة',
  'nav.use_camera': 'استخدم الكاميرا للالتقاط',
  'nav.choose_gallery': 'اختر من المعرض',
  'nav.select_photo': 'حدد صورة موجودة',
  'nav.cancel': 'إلغاء',


  // ==================== Profile Module ====================
  'profile.title': 'الملف الشخصي',
  'profile.edit_profile': 'تعديل الملف الشخصي',
  'profile.view_profile': 'عرض الملف الشخصي',
  'profile.my_account': 'حسابي',
  'profile.settings': 'الإعدادات',
  'profile.help': 'المساعدة والدعم',

  // Account Menu Items
  'profile.medical_profile': 'الملف الطبي',
  'profile.medical_profile_desc': 'عرض المعلومات الطبية',
  'profile.prescriptions': 'سجل الوصفات',
  'profile.prescriptions_desc': 'عرض الوصفات السابقة',
  'profile.family_members': 'أفراد الأسرة',
  'profile.family_members_desc': 'إدارة أفراد الأسرة',
  'profile.saved_addresses': 'العناوين المحفوظة',
  'profile.saved_addresses_desc': 'إدارة مواقع التسليم',
  'profile.order_history': 'سجل الطلبات',
  'profile.order_history_desc': 'عرض الطلبات السابقة',

  // Settings Items
  'profile.notifications': 'التنبيهات',
  'profile.dark_mode': 'الوضع الليلي',
  'profile.language': 'اللغة',
  'profile.privacy_security': 'الخصوصية والأمان',

  // Medical Profile Modal
  'profile.medical_info': 'المعلومات الطبية',
  'profile.blood_type': 'فئة الدم',
  'profile.allergies': 'الحساسيات',
  'profile.chronic_conditions': 'الأمراض المزمنة',
  'profile.insurance': 'التأمين',
  'profile.emergency_contact': 'جهة الاتصال في الطوارئ',
  'profile.no_allergies': 'لا توجد حساسيات معروفة',
  'profile.no_conditions': 'لا توجد أمراض مزمنة',

  // Prescriptions Modal
  'profile.prescription_history': 'سجل الوصفات الطبية',
  'profile.diagnosis': 'التشخيص',
  'profile.doctor': 'الطبيب',
  'profile.medicines': 'الأدوية',
  'profile.date': 'التاريخ',
  'profile.status': 'الحالة',
  'profile.active': 'نشطة',
  'profile.completed': 'مكتملة',
  'profile.download': 'تحميل',
  'profile.no_prescriptions': 'لا توجد وصفات طبية',

  // Family Members Modal
  'profile.relation': 'الصلة',
  'profile.age': 'العمر',
  'profile.add_family_member': 'إضافة فرد عائلة',
  'profile.no_family_members': 'لم يتم إضافة أفراد عائلة',

  // ==================== Home Module ====================
  'home.welcome': 'أهلا وسهلا',
  'home.location': 'الموقع',
  'home.location_value': 'وسط المدينة',
  'home.search_placeholder': 'ابحث عن دواء أو صيدلية...',
  'home.quick_actions': 'الإجراءات السريعة',
  'home.upload_prescription': 'تحميل الوصفة الطبية',
  'home.consult_doctor': 'استشارة الطبيب',
  'home.my_medicine': 'أدويتي',
  'home.nearby_pharmacies': 'الصيدليات القريبة',
  'home.available_doctors': 'الأطباء المتاحون الآن',
  'home.see_all': 'عرض الكل',
  'home.view_map': 'عرض الخريطة',
  'home.health_tips': 'نصائح الصحة',
  'home.view_all': 'عرض الكل',
  'home.stay_hydrated': 'البقاء رطباً',
  'home.stay_hydrated_desc':
      'اشرب ثمانية أكواب من الماء يومياً على الأقل للحفاظ على صحة مثالية ومستويات الطاقة.',
  'home.regular_exercise': 'التمارين المنتظمة',
  'home.regular_exercise_desc':
      'قم بممارسة نشاط بدني لمدة 30 دقيقة على الأقل يومياً من أجل صحة القلب والأوعية الدموية الأفضل.',
  'home.balanced_diet': 'نظام غذائي متوازن',
  'home.balanced_diet_desc':
      'أدرج الفواكه والخضروات والحبوب الكاملة في وجباتك اليومية للحصول على تغذية كاملة.',

  // ==================== Medicines Module ====================
  'medicines.title': 'الأدوية',
  'medicines.my_medicines': 'أدويتي',
  'medicines.family_members': 'أفراد الأسرة',
  'medicines.member_medicines': 'أدوية @name (@count)',
  'medicines.add_new': 'إضافة جديد',
  'medicines.add_first_medicine': 'إضافة أول دواء',
  'medicines.add_member': 'إضافة فرد',
  'medicines.no_medicines': 'لم تتم إضافة أدوية بعد',
  'medicines.medicine_singular': 'دواء',
  'medicines.medicine_plural': 'أدوية',
  'medicines.relation_self': 'أنا',
  'medicines.relation_mother': 'الأم',
  'medicines.relation_father': 'الأب',
  'medicines.relation_daughter': 'الابنة',
  'medicines.relation_son': 'الابن',
  'medicines.relation_wife': 'الزوجة',
  'medicines.relation_husband': 'الزوج',
  'medicines.relation_sister': 'الأخت',
  'medicines.relation_brother': 'الأخ',
  'medicines.search': 'ابحث عن الأدوية',
  'medicines.filter': 'تصفية',
  'medicines.sort': 'ترتيب',
  'medicines.price': 'السعر',
  'medicines.in_stock': 'متوفر',
  'medicines.out_of_stock': 'غير متوفر',
  'medicines.add_to_cart': 'إضافة إلى السلة',
  'medicines.quantity': 'الكمية',
  'medicines.progress_today': 'تقدم @name اليوم',
  'medicines.complete': '% مكتمل',
  'medicines.next_reminder': 'التذكير التالي لـ @name',
  'medicines.for_member': 'لـ @name',
  'medicines.frequency': 'التكرار',
  'medicines.timings': 'الأوقات',
  'medicines.instructions': 'التعليمات',
  'medicines.duration': 'المدة',
  'medicines.duration_range': '@start إلى @end',
  'medicines.reminders': 'التذكيرات',
  'medicines.close': 'إغلاق',
  'medicines.edit': 'تعديل',

  // ==================== Pharmacies Module ====================
  'pharmacies.title': 'البحث عن الصيدليات',
  'pharmacies.search_placeholder': 'ابحث عن الصيدلية باسمها...',
  'pharmacies.filters': 'المرشحات',
  'pharmacies.filter_open_now': 'مفتوحة الآن',
  'pharmacies.filter_within_5km': 'في حدود 5 كم',
  'pharmacies.filter_24_7': '24/7',
  'pharmacies.found_count': 'تم العثور على {count} صيدلية بالقرب منك',
  'pharmacies.no_pharmacies_found': 'لم يتم العثور على صيدليات',
  'pharmacies.near_me': 'بالقرب مني',
  'pharmacies.open_now': 'مفتوحة الآن',
  'pharmacies.closed': 'مغلقة',
  'pharmacies.distance': 'المسافة',
  'pharmacies.delivery': 'خدمة التوصيل متاحة',
  'pharmacies.rating': 'التقييم',

  // ==================== Consultations Module ====================
  'consultations.title': 'الاستشارات',
  'consultations.search_placeholder': 'ابحث عن الأطباء حسب الاسم أو التخصص...',
  'consultations.available': 'المتاحون',
  'consultations.upcoming': 'القادمة',
  'consultations.history': 'السجل',
  'consultations.no_doctors': 'لم يتم العثور على أطباء',
  'consultations.no_doctors_hint': 'حاول تعديل بحثك',
  'consultations.no_upcoming': 'لا توجد استشارات قادمة',
  'consultations.no_upcoming_hint': 'احجز استشارة مع طبيب',
  'consultations.no_history': 'لا يوجد سجل استشارات',
  'consultations.no_history_hint': 'ستظهر استشاراتك السابقة هنا',
  'consultations.doctors': 'الأطباء',
  'consultations.book_consultation': 'حجز استشارة',
  'consultations.past': 'السابقة',
  'consultations.speciality': 'التخصص',
  'consultations.available_times': 'الأوقات المتاحة',

  // ==================== Chat Module ====================
  'chat.title': 'الدردشة',
  'chat.messages': 'الرسائل',
  'chat.new_message': 'رسالة جديدة',
  'chat.type_message': 'اكتب رسالة...',
  'chat.send': 'إرسال',
  'chat.no_messages': 'لا توجد رسائل',
  'chat.secure_banner': '🔒 هذه استشارة آمنة ومشفرة',
  'chat.today': 'اليوم',
  'chat.attachment_photo': 'صورة',
  'chat.attachment_document': 'مستند',
  'chat.attachment_medical_report': 'تقرير طبي',

  // ==================== Notifications Module ====================
  'notifications.title': 'التنبيهات',
  'notifications.unread': '@count غير مقروء',
  'notifications.mark_all_read': 'تعليم الكل كمقروء',
  'notifications.no_notifications': 'لا توجد تنبيهات حالياً',
  'notifications.all': 'الكل',
  'notifications.medicine': 'الأدوية',
  'notifications.other': 'آخرى',
  'notifications.skip': 'تخطي',
  'notifications.taken': 'تم تناوله',

  // ==================== Upload Prescription Module ====================
  'upload.title': 'تحميل الوصفة الطبية',
  'upload.select_image': 'اختر صورة',
  'upload.take_photo': 'التقط صورة',
  'upload.choose_file': 'اختر ملف',
  'upload.uploading': 'جاري التحميل...',
  'upload.success': 'تم تحميل الوصفة الطبية بنجاح',
  'upload.error': 'فشل تحميل الوصفة الطبية',

  // ==================== Localization/Language ====================
  'language.title': 'اللغة',
  'language.english': 'English',
  'language.arabic': 'العربية',
  'language.select': 'اختر اللغة',
  'language.changed': 'تم تغيير اللغة إلى العربية',
};
