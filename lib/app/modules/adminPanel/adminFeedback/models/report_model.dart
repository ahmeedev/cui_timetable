// ignore_for_file: public_member_api_docs, sort_constructors_first
class Report {
  String documentId='';
  List<Feedback> feedbacks=[];
}

class Feedback {
  String id;
  // String adminTime;
  // String adminMsg;
  String userMsg;
  String userTitle;

  Feedback(
    this.id,
    this.userMsg,
    this.userTitle,
  );

}
