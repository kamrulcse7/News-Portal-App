import 'package:flutter/material.dart';
import 'package:news_portal_app/model/news_model.dart';
import 'package:news_portal_app/service/news_api_service.dart';
import 'package:news_portal_app/widget/const.dart';
import 'package:news_portal_app/widget/news_list_bg.dart';
import 'package:news_portal_app/widget/news_list_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<Articles> newsList = [];
  // @override
  // void didChangeDependencies() async {
  //   newsList = await NewsApiService().getNewsData();
  //   // setState(() {});
  //   super.didChangeDependencies();
  // }

  int currentIndex = 1;
  String sortBy = SortNews.popularity.name;
  TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
        ),
        title: Text("News App"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_border),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Container(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
            child: TextFormField(
              controller: searchcontroller,
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(
                  color: Color(0xFF9c9c9d),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
                fillColor: Colors.white,
                filled: true,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 10.0),
                  child: Icon(
                    Icons.search_rounded,
                    color: Color(0xFF9c9c9d),
                    size: 32.0,
                  ),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      searchcontroller.clear();
                    });
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.black54,
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0.6),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0.6),
                  borderRadius: BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "All News",
                style: myStyle(18, Colors.black, FontWeight.w600),
              ),
              Container(
                height: 50.0,
                child: Row(
                  children: [
                    ElevatedButton(onPressed: () {}, child: Text("Prev")),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        height: 35,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  currentIndex = index + 1;
                                });
                              },
                              child: Container(
                                width: 40,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: index + 1 == currentIndex
                                      ? Colors.orange[300]
                                      : Colors.grey[400],
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "${index + 1}",
                                  style: myStyle(
                                    16.0,
                                    Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    ElevatedButton(onPressed: () {}, child: Text("Next")),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(
                        color: Colors.grey,
                        style: BorderStyle.solid,
                        width: 0.80),
                  ),
                  child: DropdownButton<String>(
                    value: sortBy,
                    style: myStyle(20.0, Colors.black54, FontWeight.w500),
                    underline: Container(),
                    items: [
                      DropdownMenuItem(
                        child: Text("${SortNews.popularity.name}"),
                        value: SortNews.popularity.name,
                      ),
                      DropdownMenuItem(
                        child: Text("${SortNews.publishedAt.name}"),
                        value: SortNews.publishedAt.name,
                      ),
                      DropdownMenuItem(
                        child: Text("${SortNews.relevancy.name}"),
                        value: SortNews.relevancy.name,
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        sortBy = value!;
                      });
                      print("drop down value is $sortBy");
                    },
                  ),
                ),
              ),

              FutureBuilder<List<Articles>>(

                future: NewsApiService().getNewsData(
                  page: currentIndex,
                  sortBy: sortBy,
                  searchText: searchcontroller.text,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Data Loading Error!"),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return NewsListCard(
                        article: snapshot.data![index],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum SortNews {
  publishedAt,
  popularity,
  relevancy,
}
