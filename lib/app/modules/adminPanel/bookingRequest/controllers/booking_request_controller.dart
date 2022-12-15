import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cui_timetable/app/modules/adminPanel/bookingRequest/models/booking_request_model.dart';
import 'package:get/get.dart';

class BookingRequestController extends GetxController {
  final requestes = <BookingRequest>[];
  final loading = true.obs;
  @override
  Future<void> onInit() async {
    await getApprovalRequestes();
    super.onInit();
  }

  getApprovalRequestes() async {
    loading.value = true;
    requestes.clear();
    final db = FirebaseFirestore.instance;

    // put deme dataaaa
    // db.collection('approvals').doc("123421dfsdg").set({
    //   'name': "Mr 2",
    //   "email": "at094@gmail.com",
    //   'approved': false,
    // });

    final documents = await db.collection('approvals').get();
    for (var element in documents.docs) {
      final result = element.data();
      result['id'] = element.id;
      final request = BookingRequest.fromMap(result);
      requestes.add(request);
    }
    print(requestes);
    loading.value = false;
  }

  approveBooking({required String id}) async {
    final db = FirebaseFirestore.instance;
    await db.collection('approvals').doc(id).update({
      'approved': true,
    });
    // refresh requestes.
    getApprovalRequestes();
  }

  revokeBooking({required String id}) async {
    final db = FirebaseFirestore.instance;
    await db.collection('approvals').doc(id).update({
      'approved': false,
    });
    // refresh requestes.
    getApprovalRequestes();
  }
}
