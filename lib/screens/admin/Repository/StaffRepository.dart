import 'package:app/screens/admin/ApiProvider/StaffApiProvider.dart';
import 'package:app/utils/modal/LeaveAdmin.dart';
import 'package:app/utils/modal/LibraryCategoryMember.dart';
import 'package:app/utils/modal/Staff.dart';

class StaffRepository{


  StaffApiProvider _provider = StaffApiProvider();

  Future<LibraryMemberList> getStaff(){
    return _provider.getAllCategory();
  }

  Future<StaffList> getStaffList(int id){
    return _provider.getAllStaff(id);
  }

  Future<LeaveAdminList> getStaffLeave(String url , String endPoint){
    return _provider.getAllLeave(url,endPoint);
  }

}