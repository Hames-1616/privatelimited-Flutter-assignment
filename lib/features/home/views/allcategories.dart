import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:privatelimited/core/dimensions.dart';
import 'package:privatelimited/core/showsnack.dart';
import 'package:privatelimited/features/home/controller/homeController.dart';

class categories extends ConsumerWidget {
  const categories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
        title: const Text("categories",style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: SizedBox(
                     height: MediaQuery.of(context).size.height,
                    child: ref.watch(categoryProvider).when(
                        data: (data) {
                          return   GridView.builder(
                          itemCount: data.length,
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
                    
                    ),
    );
  }
}
