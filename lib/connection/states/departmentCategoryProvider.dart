import 'package:flutter/material.dart';

DepartmentCategoryProvider departmentCategoryProvider = DepartmentCategoryProvider();

class DepartmentCategoryProvider extends ChangeNotifier {
  String _selectedCategoryInEng = '12';

  String get currentCategoryInEng => _selectedCategoryInEng;
  String get currentCategoryInKor =>
      categoriesMapEngToKor[_selectedCategoryInEng]!;

  void setNewCategoryWithEng(String newCategory) {
    if (categoriesMapEngToKor.keys.contains(newCategory)) {
      _selectedCategoryInEng = newCategory;
      notifyListeners();
    }
  }

  void setNewCategoryWithKor(String newCategory) {
    if (categoriesMapEngToKor.values.contains(newCategory)) {
      _selectedCategoryInEng = categoriesMapKorToEng[newCategory]!;
      notifyListeners();
    }
  }
}

const Map<String, String> categoriesMapEngToKor = {
  'Mechanical': '기계',
  'Piping': '배관',
  'Structure': '철골',
  '12': '배관',
  'Pipi331ng': '배관',
  'Pip221ing': '배관',
  'Pip3ing': '배관',
  'Pip13ing': '배관',

};

late final Map<String, String> categoriesMapKorToEng =
categoriesMapEngToKor.map((key, value) => MapEntry(value, key));
