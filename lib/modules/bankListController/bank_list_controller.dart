import 'package:device_apps/device_apps.dart';

class BanksListController {
  List<String> compatibleBanks = ["com.nu.production","br.com.intermedium","br.com.bb.android","com.santander.app","com.c6bank.app","br.com.neon","br.com.bradesco.next","com.itau","com.picpay","br.com.banese.android","com.hipercard.app","br.com.gabba.Caixa","com.itau.pers","com.mercadopago.wallet"];

  Future getBanksAppsOnDevice() async {
    List banksAppsOnDeviceList = [];
    for (var i = 0; i < compatibleBanks.length; i++) {
      if (await DeviceApps.isAppInstalled(compatibleBanks[i])) {
        Application? app = await DeviceApps.getApp(compatibleBanks[i],true);
        banksAppsOnDeviceList.add(app);
      }
    }
    return banksAppsOnDeviceList;
  }
}
