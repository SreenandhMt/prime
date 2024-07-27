import 'package:flutter/material.dart';
import 'package:redacted/redacted.dart';

import '/features/buying/presentaion/page/buying_page.dart';
import '/features/home/domain/entities/home_entitie.dart';
import '/main.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    Key? key,
    required this.data,
    this.dataList,
  }) : super(key: key);
  final HomeDataEntities data;
  final List<HomeDataEntities>? dataList;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width <= 500) {
      return GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => BuyingPage(homeData: data,dataList: dataList,),)),
        child: Container(
          margin: const EdgeInsets.all(3.5),
          width: (size.width / 2) * 0.96,
          height: (size.width) * 0.68,
          decoration: BoxDecoration(color: theme.primary,borderRadius: BorderRadius.circular(10)),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 230,
                    ),
                    child: Image.network(data.productUrls!.first??"")),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      width: (size.width / 2) * 0.95,
                      height: 80,
                      decoration: BoxDecoration(color: theme.primary,borderRadius: BorderRadius.circular(10)),
                      child: ProductText(data: data,))),
            ],
          ),
        ),
      );
    } else {
      return Container(
        height: 500,
        width: 300,
        margin: const EdgeInsets.all(3.5),
        color: theme.primary,
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                width: (size.width / 2) * 0.95,
                height: 80,
                decoration: BoxDecoration(color: theme.primary,),
                child: ProductText(data: data,))),
      );
    }
  }

}

class ProductText extends StatelessWidget {
  const ProductText({
    Key? key,
    required this.data,
  }) : super(key: key);
  final HomeDataEntities data;
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.productName??"",style: TextStyle(color: theme.tertiary),),
          Text(
            data.productAbout??"",
            style: TextStyle(),
            maxLines: 1,
            overflow: TextOverflow.clip,
          ),
          Row(
            children: [
              Icon(
                Icons.star_rounded,
                color: Colors.yellow[600],
                size: 20,
              ),
              Text(data.map!["rate1"]==null?"3":ratingText(),style: TextStyle(color: theme.tertiary),),
              const Expanded(child: SizedBox()),
              Text(
                "₹${data.map!["price"]??""}",
                style: TextStyle(fontSize: 16, color: theme.secondary),
              )
            ],
          ),
        ],
      ),
    );
  }
  String ratingText(){
    dynamic top,rateindex;
    for (var i = 1; i <=5; i++) {
      if(i==1)
      {
        top = data.map!["rate$i"];
        rateindex=i;
      }
      else if(data.map!["rate$i"]>top)
      {
        top = data.map!["rate$i"];
        rateindex=i;
      }
    }
    return top!=null?"$rateindex | ${!top.toString().endsWith(".0")?top.toString()+".0":top.toString()}":"";
  }
}

class ProductLoadingWidget extends StatelessWidget {
  const ProductLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
              margin: const EdgeInsets.all(3.5),
              width: (size.width / 2) * 0.96,
              height: (size.width) * 0.68,
              decoration: BoxDecoration(color:theme.primary,),
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
       width: (size.width / 2) * 0.95,
       height: (size.width) * 0.28,
       color: Theme.of(context).colorScheme.primary,
       child: ProductTextForLoading())),
                ],
              ),
            ).redacted(context: context, redact: true,configuration: RedactedConfiguration());
  }
}

class ProductTextForLoading extends StatelessWidget {
  const ProductTextForLoading({
    Key? key,
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 90,height: 20,decoration: BoxDecoration(color: theme.primary,borderRadius: BorderRadius.circular(10)),margin: EdgeInsets.all(3),),
          Container(height: 30,decoration:  BoxDecoration(color: theme.primary,borderRadius: BorderRadius.circular(10)),margin: EdgeInsets.all(3),),
          Row(
            children: [
              Container(width: 70,height: 20,decoration: BoxDecoration(color: theme.primary,borderRadius: BorderRadius.circular(10)),margin: EdgeInsets.all(3),),
              Spacer(),
              Container(width: 60,height: 20,decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(10)),margin: EdgeInsets.all(3),),
            ],
          )
        ],
      ),
    ).redacted(context: context, redact: true);
  }
}