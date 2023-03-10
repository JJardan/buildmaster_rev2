import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:buildmaster_rev2/connection/model/career_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../connection/model/user_model.dart';
import '../../../connection/service/career_service.dart';
import '../../../connection/service/user_service.dart';
import '../../../connection/states/user_provider.dart';
import '../../../constants/data_keys.dart';
import '../../../constants/route_keys.dart';
import '../../../main.dart';
import '../../../theme/button_theme/text_button.dart';
import '../../auth_screens/sign_in_google.dart';
import '../profile_screens/career_screens/generate_career_screen.dart';
import 'feed_detail_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final List<String> imageList = [
    'https://cdn.pixabay.com/photo/2014/10/29/19/15/graffiti-508272_1280.jpg',
    'https://cdn.pixabay.com/photo/2013/10/25/20/46/mosaic-200864_1280.jpg',
    'https://cdn.pixabay.com/photo/2017/07/05/19/21/art-2475718_1280.jpg',
    'https://cdn.pixabay.com/photo/2022/07/02/17/24/abstract-7297671_1280.jpg',
    'https://cdn.pixabay.com/photo/2018/06/22/15/32/soap-bubble-3490959_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/11/23/13/56/light-1853025_1280.jpg',
    'https://cdn.pixabay.com/photo/2011/06/20/22/35/graffiti-8051_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/04/21/15/10/yellow-1343606_1280.jpg',
    'https://cdn.pixabay.com/photo/2020/12/15/16/25/clock-5834193__340.jpg',
    'https://cdn.pixabay.com/photo/2019/03/15/09/49/girl-4056684_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/09/18/19/31/laptop-5582775_960_720.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              snap: false,
              floating: false,
              elevation: 0.5,
              centerTitle: false,
              toolbarHeight: 80,
              backgroundColor: Colors.white,
              titleTextStyle: Theme.of(context).textTheme.titleLarge,
              title: Row(
                children: [
                  SizedBox(width: 18),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(_detailRoute());
                    },
                    child: SizedBox(
                      height: 32,
                      child: Row(
                        children: [
                          SizedBox(width: 6),
                          SizedBox(
                            height: 80,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 26,
                              child: Text(
                                'buildmaster',
                                style: GoogleFonts.squadaOne(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 6),
                          SizedBox(
                            height: 80,
                            child: (_size.width < 600)
                                ? Container()
                                : Container(
                                    alignment: Alignment.centerLeft,
                                    height: 24,
                                    child: Text(
                                      'Find Your Co-workers',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ),
                          ),
                          SizedBox(width: (_size.width < 600) ? 0 : 6),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              titleSpacing: 12,
              actions: (Provider.of<UserProvider>(context, listen: false)
                          .user !=
                      null)
                  ? [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 22.0, horizontal: 0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(_detailRoute());
                          },
                          child: SizedBox(
                            height: 24,
                            child: Row(
                              children: [
                                SizedBox(width: 6),
                                SizedBox(
                                  height: 24,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    height: 24,
                                    child: Text(
                                      'Go Master',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 6),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 22.0, bottom: 22.0, left: 10, right: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            onTap: () {
                              Navigator.of(context).push(_authRoute());
                            },
                            child: SizedBox(
                              width: 36,
                              height: 36,
                              // child: Container(color: Colors.blue)
                              child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: 'https://picsum.photos/250?image=111',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 22.0, horizontal: 0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(_uploadRoute());
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
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    side:
                                        BorderSide(color: Colors.transparent))),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Upload Career',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 28),
                    ]
                  : [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 22.0, horizontal: 0),
                        child: TextButton(
                          onPressed: () async {
                            await BuildMasterState().handleSignIn();
                            if (googleSignin.currentUser != null) {
                              UserModel userModel = UserModel(
                                userEmail: googleSignin.currentUser!.email,
                                profileName: 'unknown',
                                profileImageUrl: "",
                                profileNationality: 'Global',
                                workingAbroad: false,
                                varifiedUserEmail: false,
                                findWork: false,
                                careers: [],
                                signupDate: DateTime.now().toUtc(),
                                userKey: googleSignin.currentUser!.id,
                              );
                              UserService().createNewUser(
                                  userModel.toJson(), userModel.userKey);
                            }
                          },
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(Size.zero),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(0)),
                            elevation: MaterialStateProperty.all<double>(0),
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.black54;
                              } else {
                                return Colors.black;
                              }
                            }),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    side:
                                        BorderSide(color: Colors.transparent))),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Google Connection',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 28),
                    ],
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Card(
                    margin: const EdgeInsets.all(0),
                    child: Stack(
                      children: [
                        Container(
                          height: 540,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            image: DecorationImage(
                              image: AssetImage("images/test.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          height: 540,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.7),
                          ),
                        ),
                        Positioned.fill(
                            child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Explore the world???s best',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              (_size.width < 600) ? 24 : 36,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                      Text(
                                        'construction manpower',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              (_size.width < 600) ? 24 : 36,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        'Millions of engineers and direct manpowers around the world career',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              (_size.width < 600) ? 12 : 16,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        'we are the supplier, world`s best construction professionals.',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              (_size.width < 600) ? 12 : 16,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                )))
                      ],
                    ),
                  );
                },
                childCount: 1, // 1000 list items
              ),
            ),
            SliverToBoxAdapter(
              child: FutureBuilder(
                  future: CareerService().getAllCareers(),
                  builder: (context, snapshot) {
                    return AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        child: (snapshot.hasData && snapshot.data!.isNotEmpty)
                            ? sliverList(snapshot.data!)
                            : sliverList(snapshot.data!)); //_shimmerListView()
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _shimmerListView() {
    Size _size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: MasonryGridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        itemCount: imageList.length,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
              highlightColor: Color.fromRGBO(240, 240, 240, 1),
              baseColor: Color.fromRGBO(248, 248, 248, 1),
              period: Duration(milliseconds: 800),
              enabled: true,
              child: Card(
                child: Container(height: _size.width / 2 + (index % 3) * 100),
              ));
        },
      ),
    );
  }

  Padding sliverList(List<CareerModel> careers) {
    Size _size = MediaQuery.of(context).size;
    return Padding(
        padding: (_size.width <= 800)
            ? const EdgeInsets.symmetric(horizontal: 24, vertical: 24)
            : const EdgeInsets.symmetric(horizontal: 60, vertical: 24),
        child: MasonryGridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: (_size.width) ~/ 340,
          mainAxisSpacing: 24,
          crossAxisSpacing: 24,
          itemCount: imageList.length,
          itemBuilder: (context, index) {
            CareerModel career = careers[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Card(
                key: ValueKey(imageList[index]),
                elevation: 1,
                color: Colors.white,
                margin: EdgeInsets.all(0),
                child: Container(
                  height: 252,
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      final now = DateTime.now();
                      final difference = now.difference(career.uploadTime);

                      String formattedUploadTime;

                      if (difference.inDays == 1) {
                        formattedUploadTime = 'Yesterday';
                      } else if (difference.inDays > 1) {
                        final formatter = DateFormat('MMM d, yyyy');
                        formattedUploadTime =
                            formatter.format(career.uploadTime);
                      } else if (difference.inHours >= 1) {
                        formattedUploadTime = '${difference.inHours} hours ago';
                      } else if (difference.inMinutes >= 1) {
                        formattedUploadTime =
                            '${difference.inMinutes} minutes ago';
                      } else {
                        formattedUploadTime = 'Just now';
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          InkWell(
                            onTap: () {
                              context.goNamed(
                                  '/$LOCATION_CAREER/:${career.careerKey}');
                            },
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 14, right: 14, left: 14, bottom: 0),
                                child: Container(
                                    height: 190,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              child: TextButton(
                                                onPressed: () {},
                                                style: ButtonStyle(
                                                  minimumSize:
                                                      MaterialStateProperty.all(
                                                          Size.zero),
                                                  padding: MaterialStateProperty
                                                      .all<EdgeInsets>(
                                                          const EdgeInsets.all(
                                                              0)),
                                                  elevation:
                                                      MaterialStateProperty.all<
                                                          double>(0),
                                                  backgroundColor:
                                                      MaterialStateProperty
                                                          .resolveWith(
                                                              (states) {
                                                    if (states.contains(
                                                        MaterialState
                                                            .hovered)) {
                                                      return Colors.black;
                                                    } else {
                                                      return Colors.black;
                                                    }
                                                  }),
                                                  tapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      2.0),
                                                          side: BorderSide(
                                                              color: Colors
                                                                  .transparent))),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    career.departmentCategory,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(child: SizedBox()),
                                            SizedBox(
                                              height: 32,
                                              width: 32,
                                              child: ElevatedButton(
                                                onPressed: () {},
                                                child: Icon(
                                                  Icons.check,
                                                  color: Colors.grey,
                                                ),
                                                style: ButtonStyle(
                                                  minimumSize:
                                                      MaterialStateProperty.all(
                                                          Size.zero),
                                                  padding: MaterialStateProperty
                                                      .all<EdgeInsets>(
                                                          const EdgeInsets.all(
                                                              0)),
                                                  elevation:
                                                      MaterialStateProperty.all<
                                                          double>(0),
                                                  backgroundColor:
                                                      MaterialStateProperty
                                                          .resolveWith(
                                                              (states) {
                                                    if (states.contains(
                                                        MaterialState
                                                            .hovered)) {
                                                      return Colors.white70;
                                                    } else {
                                                      return Colors.transparent;
                                                    }
                                                  }),
                                                  tapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      2.0),
                                                          side: BorderSide(
                                                              color: Colors
                                                                  .transparent))),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              career.positionCategory,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              career.positionDetail,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              career.companyDescription,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              career.endDate
                                                  .difference(career.beginDate)
                                                  .inDays as String,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              career.detailDescription,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              formattedUploadTime,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ))),
                          ),
                          Expanded(
                            child: SizedBox(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(14),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: FadeInImage.memoryNetwork(
                                          placeholder: kTransparentImage,
                                          image: career.ownerImageUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    SizedBox(
                                      child: Text(
                                        career.ownerName,
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black,
                                            fontSize: 12),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    SizedBox(
                                      child: Text(
                                        career.ownerNationality,
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black,
                                            fontSize: 10),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    SizedBox(
                                      child: Text(
                                        career.ownerFindWork as String,
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black,
                                            fontSize: 10),
                                      ),
                                    ),
                                    Flexible(
                                      fit: FlexFit.tight,
                                      child: Text(
                                        career.annualSalary as String,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black,
                                            fontSize: 10),
                                      ),
                                    ),
                                    career.masterCareerVerified == true
                                        ? BlackLabelButton()
                                        : SizedBox(),
                                    career.ownerFindWork == true
                                        ? FindWorkButton()
                                        : SizedBox(),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.check_circle,
                                          color: Colors.black,
                                          size: 12,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        SizedBox(
                                          child: Text(
                                            career.checkCount as String,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ));
  }

  Route _authRoute() {
    return PageRouteBuilder(
        barrierColor: Colors.black,
        transitionDuration: Duration(milliseconds: 300),
        reverseTransitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) => SignInGoogle(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(1, 0);
          var end = Offset.zero;
          var curve = Curves.easeInOut;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        });
  }

  Route _detailRoute() {
    return PageRouteBuilder(
        barrierColor: Colors.black,
        transitionDuration: Duration(milliseconds: 300),
        reverseTransitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) =>
            FeedDetailScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0, 1);
          var end = Offset.zero;
          var curve = Curves.easeInOut;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        });
  }

  Route _uploadRoute() {
    return PageRouteBuilder(
        barrierColor: Colors.black,
        transitionDuration: Duration(milliseconds: 300),
        reverseTransitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) =>
            GenerateCareerScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0, 1);
          var end = Offset.zero;
          var curve = Curves.easeInOut;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        });
  }
}
