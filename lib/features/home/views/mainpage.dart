import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:privatelimited/core/dimensions.dart';
import 'package:privatelimited/core/loadingScreen.dart';
import 'package:privatelimited/core/showsnack.dart';
import 'package:privatelimited/features/home/controller/homeController.dart';
import 'package:privatelimited/features/home/views/allcategories.dart';

class Mainpage extends ConsumerStatefulWidget {
  const Mainpage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainpageState();
}

class _MainpageState extends ConsumerState<Mainpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          actions: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(100)),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: const Text(
                          "Hello there",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.notifications,
                        color: Colors.grey,
                        size: 28,
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 15),
                        child: const Icon(
                          Icons.bookmark_add,
                          color: Colors.grey,
                          size: 28,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height/hei(context, 50),
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey.shade300,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: Colors.grey.shade600,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Search",
                                style: TextStyle(
                                    color: Colors.grey.shade600, fontSize: 16),
                              )
                            ],
                          )),
                      Container(
                          padding: const EdgeInsets.only(right: 15),
                          child: Icon(
                            Icons.settings,
                            color: Colors.grey.shade600,
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 15),
                  child: const Text(
                    "Featured Items",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/hei(context, 230),
                  child: ref.watch(featuredProvider).when(
                      data: (data) {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(50)),
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.only(
                                    top: 20, left: 15, right: 15),
                                width: 190,
                                child: Column(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: ref
                                            .watch(imageprovider(
                                                data[index].name ?? ""))
                                            .when(
                                                data: (data) {
                                                  return CachedNetworkImage(
                                                      imageUrl: data);
                                                },
                                                error: (error, st) {
                                                  return const Icon(
                                                      Icons.error);
                                                },
                                                loading: () => const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Colors.black,
                                                      ),
                                                    ))),
                                    Column(
                                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 8, left: 10),
                                            child: Text(
                                              "${data[index].name}",
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            )),
                                        Row(
                                          children: [
                                            Container(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Text(
                                                  "Rs ${data[index].discount} ",
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                )),
                                            Text(
                                              " ${data[index].original}",
                                              style: const TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 13,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
                            });
                      },
                      error: (error, st) {
                        return Text(error.toString());
                      },
                      loading: () => const Loading()),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Category",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const categories()));
                              },
                              child: const Text(
                                "View All",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 12),
                              )))
                    ],
                  ),
                ),
                SizedBox(
                     height: MediaQuery.of(context).size.height/hei(context, 270),
                    child: ref.watch(categoryProvider).when(
                        data: (data) {
                          return   GridView.builder(
                          itemCount: 6,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            return Container(
                                  height: MediaQuery.of(context).size.height/hei(context, 200),
                                  width: MediaQuery.of(context).size.width/wid(context, 120),
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        width: 80,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          child: ref
                                              .watch(imageprovider(
                                                  data[index].name ?? ""))
                                              .when(
                                                  data: (data) {
                                                    return CachedNetworkImage(
                                                        imageUrl: data);
                                                  },
                                                  error: (error, st) {
                                                    return const Icon(
                                                        Icons.error);
                                                  },
                                                  loading: () => const Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: Colors.black,
                                                        ),
                                                      ))),
                                      ),
                                      Text(data[index].name ?? ""),
                                    ],
                                  ),
                                );
                          }
                    );
                        },
                        error: (error, st) {
                          ShowSnackBar(context, error.toString());
                          return null;
                        },
                        loading: () => const Center(
                          child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                        ))
                    
                    )
              ],
            ),
          ),
        ));
  }
}
