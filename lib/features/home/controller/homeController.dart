import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:privatelimited/features/home/repos/fetchrepo.dart';
import 'package:privatelimited/features/model/featuredSection.dart';

final homeControllerProvider = StateNotifierProvider<homeController, bool>(
    (ref) => homeController(cfchrepo: ref.watch(FetchrepoProvider)));

final featuredProvider = FutureProvider(
    (ref) => ref.watch(homeControllerProvider.notifier).featureditems());

final categoryProvider = FutureProvider(
    (ref) => ref.watch(homeControllerProvider.notifier).getcategory());

final imageprovider = FutureProvider.family((ref, String name) =>
    ref.watch(homeControllerProvider.notifier).getimg(name));

class homeController extends StateNotifier<bool> {
  final Fetchrepo fchrepo;

  homeController({
    required Fetchrepo cfchrepo,
  })  : fchrepo = cfchrepo,
        super(false);

  Future<List<Featured>> featureditems() async {
    return await fchrepo.getall();
  }

  Future<String> getimg(String name) async {
    return await fchrepo.getimg(name);
  }

  Future<List<Category>> getcategory() async {
    return await fchrepo.getcat();
  }
}
