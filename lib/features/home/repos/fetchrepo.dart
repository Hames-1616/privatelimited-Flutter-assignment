import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:privatelimited/core/providers.dart';
import 'package:privatelimited/features/model/featuredSection.dart';

final FetchrepoProvider = Provider((ref) => Fetchrepo(
    cfirestr: ref.watch(firestoreinstanceProvider),
    cimgstore: ref.watch(firebaseStorageProvider)));

class Fetchrepo {
  final FirebaseFirestore firestr;
  final FirebaseStorage imgstore;
  Fetchrepo({
    required FirebaseFirestore cfirestr,
    required FirebaseStorage cimgstore,
  })  : firestr = cfirestr,
        imgstore = cimgstore;

  Reference get firebaseStorage => FirebaseStorage.instance.ref();

  Future<List<Featured>> getall() async {
    List<Featured> items = [];
    await firestr.collection("featured").get().then((value) => {
          // ignore: avoid_function_literals_in_foreach_calls
          value.docs.forEach((element) {
            Featured f = Featured(
                name: element.data()['name'],
                discount: element.data()['discount'],
                original: element.data()['original']);
            items.add(f);
          })
        });
    return items;
  }

  Future<List<Category>> getcat() async {
    List<Category> items = [];
    await firestr.collection("category").get().then((value) => {
          // ignore: avoid_function_literals_in_foreach_calls
          value.docs.forEach((element) {
            Category c = Category(name: element.data()['name']);
            items.add(c);
          })
        });
    print(items);
    return items;
  }

  Future<String> getimg(String name) async {
    var urlref = firebaseStorage.child("${name}.jpg");
    var imgurl = await urlref.getDownloadURL();
    return imgurl;
  }
}
