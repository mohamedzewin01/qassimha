import 'package:flutter/material.dart';

IconData getCategoryIcon(String categoryName) {
  final name = categoryName.toLowerCase();

  // تعليم أو صعوبات تعلم
  if (name.contains('تعليم') || name.contains('علم') ||
      name.contains('دراسة') || name.contains('مدرسة') ||
      name.contains('صعوبات') || name.contains('واجب') ||
      name.contains('تعليمي') || name.contains('مذاكرة')) {
    return Icons.school;

    // الخوف من الاستكشاف أو التجربة
  } else if (name.contains('مغامر') || name.contains('مغامرة') ||
      name.contains('خوف') || name.contains('مخاوف') ||
      name.contains('مجهول') || name.contains('تردد')) {
    return Icons.explore;

    // الخيال الزائد أو العالم الخيالي
  } else
  if (name.contains('خيال') || name.contains('سحر') || name.contains('وهم') ||
      name.contains('عجائب') ||
      name.contains('كائنات')) {
    return Icons.auto_fix_high;

    // الحيوانات (خوف منها أو تعلق بها)
  } else if (name.contains('حيوان') || name.contains('حيوانات') ||
      name.contains('قطة') || name.contains('كلب') ||
      name.contains('أرنب') || name.contains('خوف من الحيوانات')) {
    return Icons.pets;

    // مشاكل أسرية
  } else if (name.contains('أسرة') || name.contains('عائلة') ||
      name.contains('مشاكل منزلية') ||
      name.contains('طلاق') || name.contains('شجار') ||
      name.contains('خلافات')) {
    return Icons.family_restroom;

    // مشاكل دينية أو روحانية
  } else if (name.contains('دين') || name.contains('إسلام') ||
      name.contains('صلاة') ||
      name.contains('حجاب') || name.contains('قرآن') ||
      name.contains('أسئلة دينية')) {
    return Icons.mosque;

    // ذكريات أو ماضي مؤلم
  } else if (name.contains('تاريخ') || name.contains('ذكريات') ||
      name.contains('ماضي') ||
      name.contains('تراث') || name.contains('حدث قديم')) {
    return Icons.history_edu;

    // النشاط أو الخمول
  } else if (name.contains('رياضة') || name.contains('حركة') ||
      name.contains('طاقة') ||
      name.contains('كسل') || name.contains('رياضي') ||
      name.contains('نشاط')) {
    return Icons.sports;

    // قلق بيئي أو خوف من الطبيعة
  } else if (name.contains('طبيعة') || name.contains('بيئة') ||
      name.contains('شجرة') ||
      name.contains('خوف من الظلام') || name.contains('عاصفة') ||
      name.contains('أمطار')) {
    return Icons.nature;

    // فن أو مشكلة في التعبير الإبداعي
  } else
  if (name.contains('فن') || name.contains('رسم') || name.contains('ألوان') ||
      name.contains('إبداع') || name.contains('خجل') ||
      name.contains('عرض')) {
    return Icons.palette;

    // ضجيج أو مشاكل سمعية
  } else if (name.contains('موسيقى') || name.contains('غناء') ||
      name.contains('نشيد') ||
      name.contains('صوت عالي') || name.contains('ضوضاء')) {
    return Icons.music_note;

    // الأكل والمشاكل المرتبطة به
  } else
  if (name.contains('طعام') || name.contains('أكل') || name.contains('جوع') ||
      name.contains('طبخ') || name.contains('وجبة') || name.contains('نهم')) {
    return Icons.restaurant;

    // مشاكل اجتماعية
  } else if (name.contains('صداقة') || name.contains('أصدقاء') ||
      name.contains('عزلة') ||
      name.contains('خجل اجتماعي') || name.contains('رفاق') ||
      name.contains('تنمر')) {
    return Icons.people;

    // الخوف أو الشجاعة أو الثقة بالنفس
  } else if (name.contains('شجاعة') || name.contains('خوف') ||
      name.contains('جبن') ||
      name.contains('بطولة') || name.contains('قوة') ||
      name.contains('ثقة')) {
    return Icons.shield;

    // الحب أو التعلق أو الفقد
  } else if (name.contains('حب') || name.contains('فقدان') ||
      name.contains('تعلق') ||
      name.contains('مشاعر') || name.contains('عاطفة') ||
      name.contains('قلب')) {
    return Icons.favorite;

    // الغضب والانفعالات
  } else if (name.contains('غضب') || name.contains('عصبية') ||
      name.contains('انفعال') ||
      name.contains('نوبات غضب') || name.contains('انفجار عاطفي')) {
    return Icons.flash_on;

    // الاستقلالية أو رفض الأوامر أو العناد
  } else if (name.contains('استقلال') || name.contains('استقلالية') ||
      name.contains('رفض') ||
      name.contains('أوامر') || name.contains('عناد') ||
      name.contains('اعتماد على النفس')) {
    return Icons.self_improvement;

    // التوقعات المستقبلية (مثلاً مشاكل النطق، النوم، الغيرة، التبول اللاإرادي)
  } else
  if (name.contains('نطق') || name.contains('كلام') || name.contains('نوم') ||
      name.contains('أحلام') || name.contains('غيرة') ||
      name.contains('أخ جديد') ||
      name.contains('تبول') || name.contains('فراش') ||
      name.contains('ليلي')) {
    return Icons.psychology;

    // الافتراضي لأي قسم غير معروف

  }
  return Icons.book;
}