
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oasis/controller/controllerBITANA/controllerBITANA.dart';
import 'package:oasis/screen/splash/splash.dart';
import 'package:oasis/screen/view/balance_NFT/balance_NFT.dart';
import 'package:oasis/screen/view/balance_NFT/category/pet_NFT/pet_NFT.dart';
import 'package:oasis/screen/view/broadcast/broadcast.dart';
import 'package:oasis/screen/view/friends/friends.dart';
import 'package:oasis/screen/view/login/LoginViwe.dart';
import 'package:oasis/screen/view/privateKey/PrivateKeyViwe.dart';
import 'package:oasis/screen/view/store/categoryStore/RealState.dart';
import 'package:oasis/screen/view/store/categoryStore/car.dart';
import 'package:oasis/screen/view/store/categoryStore/cloth.dart';
import 'package:oasis/screen/view/store/categoryStore/guns.dart';
import 'package:oasis/screen/view/store/categoryStore/pet.dart';
import 'package:oasis/screen/view/store/categoryStore/phone.dart';
import 'package:oasis/screen/view/store/store.dart';
import 'package:oasis/screen/view/voting/voting.dart';
import 'package:oasis/screen/view/walletScreen/WalletScreenViwe.dart';
import 'package:oasis/screen/viweModel/friends/chat.dart';
import 'package:oasis/screen/viweModel/friends/friends.dart';
import 'package:oasis/screen/viweModel/friends/transferMatic.dart';
import 'package:oasis/screen/viweModel/friends/transferNFT.dart';
import 'package:oasis/screen/viweModel/walletScreen/balanceNFT/balance_NFT.dart';
import 'controller/controllerBalance/controllerBalance.dart';
import 'controller/controllerNFT/controllerNFT.dart';
import 'controller/controllerPublickKey/controllerPublickKey.dart';

void main() async {

  Get.put(PublicKeyController());
  Get.put(BalanceControllerMATIC());
  Get.put(BalanceControllerBITANA());
  Get.put(NftController());

//flutter run -d chrome

  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(
    initialRoute: "/SplashScreen",
    getPages: [
      //open app 1
      GetPage(name: "/SplashScreen", page: () => SplashScreen()),

      // wallet 2
      GetPage(name: "/loginPage", page: () => LoginPageViwe()),
      GetPage(name: "/PrivateKeyScreen", page: () => PrivateKeyViwe()),
      GetPage(name: "/WalletScreen", page: () => WalletScreenView (privateKey: '',)),

      //friends page 3
      GetPage(name: "/FriendsListScreen", page: () => FriendsListScreen()),
      GetPage(name: "/ChatPage", page: () => ChatPage()),
      GetPage(name: "/TransferPage", page: () => TransferPage()),
      GetPage(name: "/NFTManagementApp", page: () => NFTManagementApp()),

      //Store page 4
      GetPage(name: "/StorePage", page: () => StorePage()),
      GetPage(name: "/Car", page: () => Car_StorePage()),
      GetPage(name: "/cloth", page: () => Cloth_StorePage()),
      GetPage(name: "/Guns", page: () => Guns_StorePage()),
      GetPage(name: "/Pet", page: () => Pet_StorePage()),
      GetPage(name: "/phone", page: () => Phone_StorePage()),
      GetPage(name: "/RealState", page: () => RealState_StorePage()),

      //Voting 5
      GetPage(name: "/VotingPage", page: () => Voting_Page()),

      //wallet info_NFT
      GetPage(name: "/PetCategoryScreen", page: () => PetCategoryScreen()),
      GetPage(name: "/ExpensiveItemsView", page: () => ExpensiveItemsView()),
      GetPage(name: "/PetCategoryView", page: () => PetCategoryView()),

     //lastPage
      GetPage(name: "/broadcast", page: () => Broadcast()),
    ],
  ));
}

const storage = FlutterSecureStorage();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallet Blockchain',
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurpleAccent,
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
