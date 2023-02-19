import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class FeedDetailScreen extends StatefulWidget {
  const FeedDetailScreen({Key? key}) : super(key: key);

  @override
  State<FeedDetailScreen> createState() => _FeedDetailScreenState();
}

class _FeedDetailScreenState extends State<FeedDetailScreen> {
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
    'https://media.istockphoto.com/photos/woman-kayaking-in-fjord-in-norway-picture-id1059380230?b=1&k=6&m=1059380230&s=170667a&w=0&h=kA_A_XrhZJjw2bo5jIJ7089-VktFK0h0I4OWDqaac0c=',
    'https://cdn.pixabay.com/photo/2019/11/05/00/53/cellular-4602489_960_720.jpg',
    'https://cdn.pixabay.com/photo/2017/02/12/10/29/christmas-2059698_960_720.jpg',
    'https://cdn.pixabay.com/photo/2022/07/19/20/10/fire-7332958_1280.jpg',
    'https://cdn.pixabay.com/photo/2020/01/29/17/09/snowboard-4803050_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/02/06/20/01/university-library-4825366_960_720.jpg',
    'https://cdn.pixabay.com/photo/2019/04/30/21/16/monastery-4169566_1280.jpg',
    'https://cdn.pixabay.com/photo/2022/07/16/19/54/helenium-7325889_1280.jpg',
    'https://cdn.pixabay.com/photo/2020/11/22/17/28/cat-5767334_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/13/16/22/snow-5828736_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/09/09/27/women-5816861_960_720.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                snap: true,
                floating: true,
                elevation: 0,
                titleSpacing: 0,
                leading: IconButton(
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                    icon: Icon(Icons.arrow_back_ios_sharp)),
                actions: [
                  IconButton(
                      onPressed: () {
                        setState(() {});
                      },
                      icon: Icon(Icons.shopping_bag)),
                  IconButton(
                      onPressed: () {
                        setState(() {});
                      },
                      icon: Icon(Icons.send)),
                ],
                flexibleSpace: const FlexibleSpaceBar(
                  background: ColoredBox(color: Colors.white),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.black,
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: [
                      Container(
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image:
                          'https://cdn.pixabay.com/photo/2017/07/05/19/21/art-2475718_1280.jpg',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                    height: 72,
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 48,
                          height: 48,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: ExtendedImage.network(
                                'https://minimaltoolkit.com/images/randomdata/male/104.jpg',
                                fit: BoxFit.cover,
                                shape: BoxShape.rectangle,
                                border:
                                Border.all(width: 2, color: Colors.white),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 8,
                        ),
                        Column(
                          children: [Text('vanvan_10th'), Text('112')],
                        ),
                        Expanded(child: Container()),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ElevatedButton(
                              onPressed: () {},
                              child: Container(
                                child: Text('KEEP'),
                              )),
                        )
                      ],
                    )),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: MasonryGridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    itemCount: imageList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(_subdetailRoute());
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: Card(
                            key: ValueKey(imageList[index]),
                            color: Colors.white,
                            elevation: 0,
                            margin: EdgeInsets.all(0),
                            child: LayoutBuilder(
                              builder: (BuildContext context,
                                  BoxConstraints constraints) {
                                return Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.stretch,
                                  children: [
                                    Stack(
                                      children: [
                                        FadeInImage.memoryNetwork(
                                          placeholder: kTransparentImage,
                                          image: imageList[index],
                                          fit: BoxFit.scaleDown,
                                        ),
                                        Positioned(
                                            right: 0,
                                            left: 0,
                                            bottom: 0,
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                        begin:
                                                        Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        colors: [
                                                          Colors.transparent,
                                                          Colors.transparent,
                                                          Colors.transparent
                                                        ])),
                                                height: 28,
                                                child: Row(children: [
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  SizedBox(
                                                    child: Text(
                                                      'varvar_12',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  Expanded(child: SizedBox()),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        child: Text(
                                                          '112',
                                                          style: TextStyle(
                                                              color:
                                                              Colors.white,
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 2,
                                                      ),
                                                      Icon(
                                                        Icons.favorite_sharp,
                                                        color: Colors.white,
                                                        size: 12,
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                ])))
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Route _subdetailRoute() {
  return PageRouteBuilder(
    barrierColor: Colors.white,
    transitionDuration: Duration(milliseconds: 300),
    reverseTransitionDuration: Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => FeedDetailScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1, 0.0);
      var end = Offset.zero;
      var curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}