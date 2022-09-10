import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:news_portal_app/model/news_model.dart';
import 'package:news_portal_app/widget/const.dart';
import 'package:news_portal_app/widget/news_list_bg.dart';

class NewsListCard extends StatelessWidget {
  NewsListCard({
    super.key,
    required this.article,
  });
  Articles article;

  @override
  Widget build(BuildContext context) {
    return NewsListBg(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    image: DecorationImage(
                      image:  NetworkImage(
                        "${article.urlToImage}",
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              flex: 7,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${article.title} ',
                      textAlign: TextAlign.justify,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: myStyle(18.0, Colors.black87, FontWeight.w600),
                    ),
                    // Spacer(),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            /*  Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: NewsDetailsWebView(
                                          url: '${article!.url} ',
                                        ),
                                        inheritTheme: true,
                                        ctx: context),
                                  );*/
                          },
                          icon: Icon(
                            Icons.link,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          '${article.publishedAt} ',
                          maxLines: 1,
                          //    style: smallTextStyle,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
