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
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

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
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top+5, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<HomeBloc, HomePageState>(
                    builder: (BuildContext context, HomePageState state) {
                      if (state is HomePageLoaded) {
                        final sellerData = state.sellerData;
                        final trendingProductsData = state.trendingProducts;
                        final story = state.productsStories;
                        final newArrival = state.newArrival;
                        final newShops = state.newShops;

                        var story_reversed = List.of(story!.reversed);
                        
                        final lastStory = [];
                        final restStory = [];

                        for(int i = 0; i<3;i++){
                          lastStory.add(story_reversed[i]);
                        }

                        return Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                trendingSeller(title: "Trending Sellers",sellerData: sellerData,sizingInformation: sizingInformation),
                                const SizedBox(height: 5,),
                                trendingProducts(title: "Trending Products",productData: trendingProductsData,sizingInformation: sizingInformation),
                                const SizedBox(height: 5,),
                                productsStory(storyData: story,sizingInformation: sizingInformation,length: 3,reverse: false),
                                const SizedBox(height: 5,),
                                trendingProducts(title: "New Arrivals",productData: newArrival,sizingInformation: sizingInformation),
                                const SizedBox(height: 5,),
                                productsStory(storyData: story_reversed,sizingInformation: sizingInformation,length: 3,reverse: true),
                                const SizedBox(height: 5,),
                                trendingSeller(title: "New Shops",sellerData: newShops,sizingInformation: sizingInformation),
                                const SizedBox(height: 5,),
                                productsStory(storyData: story,sizingInformation: sizingInformation,length: story.length,reverse: false),
                              ],
                            ),
                          ),
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
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
        borderRadius: BorderRadius.circular(5),
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
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: ExtendedImage.network(
                                  "${sellerData[index]["sellerItemPhoto"]}",
                                height: (sizingInformation.localWidgetSize!.height / 30) * 5.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Container(
                                    height: heightPx(height: sizingInformation.localWidgetSize!.height,value: 0.9),
                                    width: heightPx(height: sizingInformation.localWidgetSize!.height,value: 0.9),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.transparent,
                                    ),
                                    child: ExtendedImage.network(
                                      "${sellerData[index]["sellerProfilePhoto"]}",
                                      fit: BoxFit.cover,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: (sizingInformation.localWidgetSize!.width / 30) * 6,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5)),
                                    color: Colors.black.withOpacity(0.4),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("${sellerData[index]['sellerName']}",textAlign: TextAlign.center,style: boxListTitle().copyWith(fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 10, sizingInformation.localWidgetSize!.height))),
                                    ),
                                  ),
                                ),
                              ],
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

  Widget trendingProducts({title,productData, SizingInformation? sizingInformation}) {
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
                itemCount: productData.length,
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
                                  "${productData[index]["productImage"]}",
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
                                        Text("${productData[index]['productName']}",textAlign: TextAlign.center,style: cardTitle().copyWith(fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 10, sizingInformation.localWidgetSize!.height),color: Colors.black),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                        Text("Price BDT ${productData[index]['unitPrice']}.00",textAlign: TextAlign.center,style: boxListTitle().copyWith(fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 8, sizingInformation.localWidgetSize!.height),color: Colors.black),maxLines: 1,overflow: TextOverflow.ellipsis,),
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

  Widget productsStory({title,storyData, SizingInformation? sizingInformation,length,reverse}) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: length,
      shrinkWrap: true,
      reverse: reverse,
      padding: const EdgeInsets.symmetric(vertical: 5),
      physics: const ScrollPhysics(),
      itemBuilder: (context, index) => Container(
        height: (sizingInformation!.localWidgetSize!.height / 30) * 11.5,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Card(
          elevation: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Container(
                      height: heightPx(height: sizingInformation.localWidgetSize!.height,value: 0.9),
                      width: heightPx(height: sizingInformation.localWidgetSize!.height,value: 0.9),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                      ),
                      child: ExtendedImage.network(
                        "${storyData[index]["companyLogo"]}",
                        fit: BoxFit.cover,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  SizedBox(width: 5,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${storyData[index]["companyName"]}",style: cardTitle().copyWith(fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 13, sizingInformation.localWidgetSize!.height),color: Colors.black)),
                      Text("${storyData[index]["friendlyTimeDiff"]}",style: boxListTitle().copyWith(fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 10, sizingInformation.localWidgetSize!.height),color: Colors.black.withOpacity(0.4))),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("${storyData[index]["story"]}",style: boxListTitle().copyWith(fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 10, sizingInformation.localWidgetSize!.height),color: Colors.black.withOpacity(1))),
                    const SizedBox(height: 10,),
                    Expanded(
                      child: ExtendedImage.network(
                        "${storyData[index]["storyImage"]}",
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: heightPx(height: sizingInformation.localWidgetSize!.height,value: 1),
                color: Colors.transparent,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    bottomWidgets(icon: FeatherIcons.gift,title: "BDT ${storyData[index]["unitPrice"]}.00",sizingInformation: sizingInformation),
                    bottomWidgets(icon: FeatherIcons.menu,title: "${storyData[index]["availableStock"]} available stock",sizingInformation: sizingInformation),
                    bottomWidgets(icon: FeatherIcons.shoppingCart,title: "${storyData[index]["orderQty"]} order(s)",sizingInformation: sizingInformation),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomWidgets({IconData? icon,title,SizingInformation? sizingInformation}){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon,size: AdaptiveTextSize().getadaptiveTextSize(context, 13, sizingInformation!.localWidgetSize!.height),),
        const SizedBox(width: 5,),
        Text(title,style: cardTitle().copyWith(fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 8.5, sizingInformation.localWidgetSize!.height),color: Colors.black.withOpacity(1))),
      ],
    );
  }

}
