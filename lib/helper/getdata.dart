import 'package:shared_preferences/shared_preferences.dart';

class GetData{



  static getiduser()async{
    SharedPreferences data = await SharedPreferences.getInstance();
    String id_user = data.getString("id_user");
    return id_user;
  }

  static getemail()async{
    SharedPreferences data = await SharedPreferences.getInstance();
    String email = data.getString("email");
    return email;
  }

  static getnpk()async{
    SharedPreferences data = await SharedPreferences.getInstance();
    String npk = data.getString("npk");
    return npk;
  }

  static getunitkerja()async{
    SharedPreferences data = await SharedPreferences.getInstance();
    String unitkerja = data.getString("unitkerja");
    return unitkerja;
  }

  static getnama_user()async{
    SharedPreferences data = await SharedPreferences.getInstance();
    String nama_user = data.getString("nama_user");
    return nama_user;
  }

  static getlast_login()async{
    SharedPreferences data = await SharedPreferences.getInstance();
    String last_login = data.getString("last_login");
    return last_login;
  }

  static getnickname()async{
    SharedPreferences data = await SharedPreferences.getInstance();
    String nickname = data.getString("nickname");
    return nickname;
  }

  static getrole()async{
    SharedPreferences data = await SharedPreferences.getInstance();
    String role = data.getString("role");
    return role;
  }

  static getis_organik()async{
    SharedPreferences data = await SharedPreferences.getInstance();
    String is_organik = data.getString("is_organik");
    return is_organik;
  }

  static getavatar()async{
    SharedPreferences data = await SharedPreferences.getInstance();
    String avatar = data.getString("avatar");
    return avatar;
  }

  static getkodeUnitKerja()async{
    SharedPreferences data = await SharedPreferences.getInstance();
    String kodeUnitKerja = data.getString("kodeUnitKerja");
    return kodeUnitKerja;
  }
}