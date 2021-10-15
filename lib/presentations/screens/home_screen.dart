import 'package:bloc_task/constant/enums/enums.dart';
import 'package:bloc_task/constant/text_size_style/adaptive_text_size.dart';
import 'package:bloc_task/constant/text_size_style/text_style.dart';
import 'package:bloc_task/logics/HomeBloc/home_bloc.dart';
import 'package:bloc_task/logics/HomeBloc/home_events.dart';
import 'package:bloc_task/logics/HomeBloc/home_state.dart';
import 'package:bloc_task/logics/InternetConnectivity/internet_connectivity_cubit.dart';
import 'package:bloc_task/presentations/base_widget.dart';
import 'package:bloc_task/presentations/sizing_information.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadAlbums();
  }

  _loadAlbums() async {
    //context.read<HomeBloc>().add(FetchFeaturedSeller());
    context.read<HomeBloc>().add(GetData(1));
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      builder: (context, sizingInformation) => BlocListener<InternetConnectivityCubit, InternetConnectivityState>(
        listener: (context, state) {
          if (state is InternetConnected &&
              state.connectionType == ConnectionType.wifi) {
            context.read<HomeBloc>().add(FetchHomeData());
          } else if (state is InternetConnected &&
              state.connectionType == ConnectionType.mobile) {
            context.read<HomeBloc>().add(FetchHomeData());
          } else if (state is InternetDisconnected) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("No internet")));
          }
        },
        child: Scaffold(
          body: Container(
            margin: EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top+5, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<HomeBloc, HomePageState>(
                    builder: (BuildContext context, HomePageState state) {
                      if (state is HomePageLoaded) {
                        final sellerData = state.sellerData;
                        final trendingProductsData = state.trendingProducts;
                        return Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              trendingSeller(title: "Trending Sellers",sellerData: sellerData,sizingInformation: sizingInformation),
                              const SizedBox(height: 5,),
                              trendingProducts(title: "Trending Products",sellerData: trendingProductsData,sizingInformation: sizingInformation),
                            ],
                          ),
                        );
                      }
                      return const CircularProgressIndicator();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget trendingSeller({title,sellerData, SizingInformation? sizingInformation}) {
    return Container(
      height: (sizingInformation!.localWidgetSize!.height / 30) * 6.5,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Card(
        elevation: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10,10,10,0),
              child: Text("$title",textAlign: TextAlign.start,style: cardTitle().copyWith(fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 14, sizingInformation.localWidgetSize!.height,),color: Colors.black),),
            ),
            Container(
              height: (sizingInformation.localWidgetSize!.height / 30) * 5.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: sellerData.length,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 5),
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        width: (sizingInformation.localWidgetSize!.width / 30) * 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: ExtendedImage.network(
                                  "${sellerData[index]["sellerItemPhoto"]}",
                                height: (sizingInformation.localWidgetSize!.height / 30) * 5.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: (sizingInformation.localWidgetSize!.height / 30) * 1,
                                width: (sizingInformation.localWidgetSize!.width / 30) * 6,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                                  color: Colors.black.withOpacity(0.4),
                                ),
                                child: Center(
                                  child: Text("${sellerData[index]['sellerName']}",textAlign: TextAlign.center,style: boxListTitle().copyWith(fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 10, sizingInformation.localWidgetSize!.height))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget trendingProducts({title,sellerData, SizingInformation? sizingInformation}) {
    return Container(
      height: (sizingInformation!.localWidgetSize!.height / 30) * 7,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Card(
        elevation: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10,10,10,0),
              child: Text("$title",textAlign: TextAlign.start,style: cardTitle().copyWith(fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 14, sizingInformation.localWidgetSize!.height,),color: Colors.black),),
            ),
            Container(
              height: (sizingInformation.localWidgetSize!.height / 30) * 5.5,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: sellerData.length,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 5),
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        width: (sizingInformation.localWidgetSize!.width / 30) * 7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Card(
                          child: Column(
                            children: [
                              Expanded(
                                child: ExtendedImage.network(
                                  "${sellerData[index]["productImage"]}",
                                  height: (sizingInformation.localWidgetSize!.height / 30) * 5.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                height: heightPx(height: sizingInformation.localWidgetSize!.height,value: 1.2),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("${sellerData[index]['productName']}",textAlign: TextAlign.center,style: cardTitle().copyWith(fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 10, sizingInformation.localWidgetSize!.height),color: Colors.black),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                        Text("Price BDT ${sellerData[index]['unitPrice']}.00",textAlign: TextAlign.center,style: boxListTitle().copyWith(fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 8, sizingInformation.localWidgetSize!.height),color: Colors.black),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
