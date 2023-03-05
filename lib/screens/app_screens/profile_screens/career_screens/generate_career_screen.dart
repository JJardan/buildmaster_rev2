import 'package:buildmaster_rev2/connection/service/career_service.dart';
import 'package:buildmaster_rev2/connection/states/departmentCategoryProvider.dart';
import 'package:buildmaster_rev2/theme/basicTheme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../../../../connection/model/career_model.dart';
import '../../../../connection/states/user_provider.dart';
import '../../../../constants/common_size.dart';

class GenerateCareerScreen extends StatefulWidget {
  @override
  _GenerateCareerScreenState createState() => _GenerateCareerScreenState();
}

class _GenerateCareerScreenState extends State<GenerateCareerScreen> {
  var _divider = Divider(
    height: 1,
    thickness: 1,
    color: Colors.blueGrey,
    indent: basic_padding,
    endIndent: basic_padding,
  );

  var _border =
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent));

  bool _suggestedPricesSelected = false;
  bool _isCreatingItem = false;

  TextEditingController _positionDetailController = TextEditingController();
  TextEditingController _detailController = TextEditingController();
  TextEditingController _companyDetailController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  Future attemptCreateItem() async {
    if (FirebaseAuth.instance.currentUser == null) return null;

    _isCreatingItem = true;
    setState(() {});

    final String userKey = FirebaseAuth.instance.currentUser!.uid;
    final String itemKey = CareerModel.generateCareerKey(userKey);

    UserProvider userProvider = context.read<UserProvider>();

    if (userProvider.userModel == null) return null;

    final num? price =
        num.tryParse(_priceController.text.replaceAll(new RegExp(r"\D"), ''));

    CareerModel careerModel = CareerModel(
        careerKey: itemKey,
        ownerKey: userKey,
        departmentCategory:
            context.read<DepartmentCategoryProvider>().currentCategoryInEng,
        positionCategory:
            context.read<DepartmentCategoryProvider>().currentCategoryInEng,
        positionDetail: _positionDetailController.text,
        companyDescription: _companyDetailController.text,
        beginDate: DateTime.now().toUtc(),
        endDate: DateTime.now().toUtc(),
        detailDescription: _detailController.text,
        annualSalary: price ?? 0,
        masterCareerVerified: false,
        uploadTime: DateTime.now().toUtc(),
        ownerImageUrl: userProvider.userModel!.profileImageUrl,
        ownerName: userProvider.userModel!.profileName,
        ownerNationality: userProvider.userModel!.profileName,
        ownerFindWork: userProvider.userModel!.workingAbroad,
        checkCount: 0);

    await CareerService()
        .uploadNewCareer(careerModel, itemKey, userProvider.user!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        Size _size = MediaQuery.of(context).size;

        return IgnorePointer(
          ignoring: _isCreatingItem,
          child: Scaffold(
            backgroundColor: Color.fromRGBO(246, 246, 255, 1),
            appBar: AppBar(
              leading: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 22.0, horizontal: 10),
                child: TextButton(
                  onPressed: () {
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size.zero),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(0)),
                    elevation: MaterialStateProperty.all<double>(0),
                    backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.hovered)) {
                        return Colors.indigoAccent;
                      } else {
                        return Colors.indigo;
                      }
                    }),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            side: BorderSide(color: Colors.transparent))),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 13),
                    ),
                  ),
                ),
              ),
              bottom: PreferredSize(
                  preferredSize: Size(_size.width, 2),
                  child: _isCreatingItem
                      ? LinearProgressIndicator(minHeight: 2)
                      : Container()),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 22.0, horizontal: 10),
                  child: TextButton(
                    onPressed: attemptCreateItem,
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size.zero),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(0)),
                      elevation: MaterialStateProperty.all<double>(0),
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.hovered)) {
                          return Colors.indigoAccent;
                        } else {
                          return Colors.indigo;
                        }
                      }),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              side: BorderSide(color: Colors.transparent))),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      child: Text(
                        'Update',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 800),
                child: ListView(children: [
                  Container(
                      child: Text(
                    'Add New Career',
                    style: Theme.of(context).textTheme.titleLarge,
                  )),
                  Card(
                    margin: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          'Add New Career',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        TextFormField(
                          controller: _positionDetailController,
                          decoration: InputDecoration(
                            hintText: '글 제목',
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                            border: _border,
                            focusedBorder: _border,
                            enabledBorder: _border,
                          ),
                        ),
                        _divider,
                        ListTile(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  child: ListView.builder(
                                    itemCount: context
                                        .watch<DepartmentCategoryProvider>()
                                        .currentCategoryInEng
                                        .length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListTile(
                                        title: Text(context
                                            .watch<DepartmentCategoryProvider>()
                                            .currentCategoryInEng),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        _divider,
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: _priceController,
                                  onChanged: (value) {
                                    if (value == '0원') _priceController.clear();
                                    setState(() {});
                                  },
                                  decoration: InputDecoration(
                                    hintText: '얼마에 파시겠어요?',
                                    prefixIcon: Icon(
                                      Icons.money,
                                      size: 20,
                                      color: (_priceController.text.isEmpty)
                                          ? Colors.blueGrey
                                          : Colors.deepOrange,
                                    ),
                                    prefixIconConstraints:
                                        BoxConstraints(minWidth: 20),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    border: _border,
                                    focusedBorder: _border,
                                    enabledBorder: _border,
                                  ),
                                ),
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                setState(() {
                                  _suggestedPricesSelected =
                                      !_suggestedPricesSelected;
                                });
                              },
                              icon: Icon(
                                  _suggestedPricesSelected
                                      ? Icons.check_circle
                                      : Icons.check_circle_outline,
                                  color: _suggestedPricesSelected
                                      ? Theme.of(context).primaryColor
                                      : Colors.blueGrey),
                              label: Text(
                                '가격제안 받기',
                                style: TextStyle(
                                    color: _suggestedPricesSelected
                                        ? Theme.of(context).primaryColor
                                        : Colors.blueGrey),
                              ),
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.transparent),
                            )
                          ],
                        ),
                        _divider,
                        TextFormField(
                          controller: _detailController,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: '아티클 내용 입력하기',
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
                            border: _border,
                            focusedBorder: _border,
                            enabledBorder: _border,
                          ),
                        ),
                        // your card content here
                      ],
                    ),
                  ),
                  Card(),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
