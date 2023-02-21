import 'package:beamer/src/beamer.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../connection/model/career_model.dart';
import '../../../../connection/service/career_service.dart';
import '../../../../constants/data_keys.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        Size size = MediaQuery.of(context).size;
        final imgSize = size.width / 4;

        return FutureBuilder<List<CareerModel>>(
            future: CareerService().getAllCareers(),
            builder: (context, snapshot) {
              return AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: (snapshot.hasData && snapshot.data!.isNotEmpty)
                      ? _listView(imgSize, snapshot.data!)
                      : _shimmerListView(imgSize));
            });
        //return _listView(imgSize)
      },
    );
  }

  ListView _listView(double imgSize, List<CareerModel> items) {
    return ListView.separated(
      padding: EdgeInsets.all(16),
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          height: 12 * 2 + 1,
          thickness: 1,
          color: Colors.blueGrey[100],
          indent: 12,
          endIndent: 12,
        );
      },
      itemBuilder: (context, index) {
        CareerModel item = items[index];
        return InkWell(
          onTap: (){
            context.beamToNamed('/$LOCATION_CAREER/:${item.careerKey}');
          },
          child: SizedBox(
            height: imgSize,
            child: Row(
              children: [
                SizedBox(
                    height: imgSize,
                    width: imgSize,
                    child: ExtendedImage.network(
                      item.ownerImageUrl,
                      fit: BoxFit.cover,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(6),
                    )),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.companyDescription,
                        ),
                        Text(item.departmentCategory),
                        item.checkCount!=0?Row(
                          children: [
                            Icon(Icons.favorite, color: Colors.blueGrey),
                            Text(item.checkCount as String),
                          ],
                        ):SizedBox(),
                        Expanded(child: Container()),
                      ],
                    )),
                Container(color: Colors.white),
              ],
            ),
          ),
        );
      },
      itemCount: items.length,
    );
  }

  Widget _shimmerListView(double imgSize) {
    return Shimmer.fromColors(
      highlightColor: Colors.black12,
      baseColor: Colors.black26,
      enabled: true,
      child: ListView.separated(
        padding: EdgeInsets.all(16),
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 1 * 2 + 1,
            thickness: 1,
            color: Colors.blueGrey[100],
            indent: 12,
            endIndent: 12,
          );
        },
        itemBuilder: (context, index) {
          return SizedBox(
            height: imgSize,
            child: Row(
              children: [
                Container(
                  height: imgSize,
                  width: imgSize,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.deepOrange),
                ),
                SizedBox(width: 12),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 24,
                          width: 150,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.deepOrange),
                        ),
                        SizedBox(height: 4),
                        Container(
                          height: 16,
                          width: 180,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.deepOrange),
                        ),
                        SizedBox(height: 4),
                        Container(
                          height: 16,
                          width: 180,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.deepOrange),
                        ),
                        Expanded(child: Container()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                height: 18, width: 150, color: Colors.deepOrange),
                          ],
                        )
                      ],
                    )),
                Container(color: Colors.white),
              ],
            ),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
