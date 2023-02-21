import 'package:flutter/material.dart';

DepartmentCategoryProvider departmentCategoryProvider = DepartmentCategoryProvider();

class DepartmentCategoryProvider extends ChangeNotifier {
  String _selectedCategoryInEng = 'none';

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
};

Map<String, String> categoriesMapKorToEng =
categoriesMapEngToKor.map((key, value) => MapEntry(value, key));
